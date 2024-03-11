import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_vertify/common/utils/log_util.dart';
import 'package:email_vertify/constants/error_message_constants.dart';
import 'package:email_vertify/model/post_model.dart';
import 'package:email_vertify/model/state_model/create_edit_post_model.dart';
import 'package:email_vertify/model/types/return_type.dart';
import 'package:email_vertify/repository/firebase_post_repository.dart';
import 'package:email_vertify/repository/firebasestoroage_respository.dart';
import 'package:email_vertify/repository/image_picker_repository.dart';
import 'package:email_vertify/views/post_write/post_write_providers.dart';
import 'package:email_vertify/views/post_write/user_provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class CreatePostController extends StateNotifier<AsyncValue<void>> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final Ref ref;
  CreatePostController(this.ref) : super(const AsyncLoading()) {
    _init();
  }

  get titleController => _titleController;
  get contentController => _contentController;
  get categoryController => _categoryController;

  _init() async {
    state = const AsyncLoading();

    if (ref.read(createEditPostStateProvider).isForEdit) {
      final PostModel postStateModel =
          ref.read(createEditPostStateProvider).editPostInformation!;
      _titleController.text = postStateModel.postTitle;
      _contentController.text = postStateModel.postContent;
      _categoryController.text = postStateModel.category.toString();
    }
    state = const AsyncData(null);
  }

  initAllFieldforEdit(CreateEditPostModel editPostInformation) {
    _titleController.text = editPostInformation.postTitle;
    _contentController.text = editPostInformation.postContent;
    _categoryController.text = editPostInformation.category.toString();
  }

  pickMultipleImagesFromGallery() async {
    final result = await ref
        .watch(imagePickerRepositoryProvider)
        .pickMultipleImageFromGallery();
    if (result is ErrorReturnType) {
      state = AsyncError(result.message!, StackTrace.current);
      state = const AsyncData(null);
      return;
    } else if (result is SuccessReturnType && result.data == null) {
      return;
    }
    final List<File?> images = result.data as List<File?>;

    for (int i = 0; i < images.length; i++) {
      if (ref.read(createEditPostStateProvider).photos.length >= 6) {
        state = AsyncError("6개 이상의 사진은 업로드 할 수 없습니다.", StackTrace.current);
        break;
      }
      if (images[i] != null) {
        List<Object> updatedPhotos = [
          ...ref.read(createEditPostStateProvider).photos,
          images[i]!
        ];
        ref
            .read(createEditPostStateProvider.notifier)
            .updatePhotos(updatedPhotos);
      }
    }
  }

  pickImageFromCamera() async {
    if (ref.read(createEditPostStateProvider).photos.length >= 6) {
      state = AsyncError("6개 이상의 사진은 업로드 할 수 없습니다", StackTrace.current);
    } else {
      final result =
          await ref.watch(imagePickerRepositoryProvider).pickImageFromCamera();
      if (result is ErrorReturnType) {
        state = AsyncError(result.message!, StackTrace.current);
        state = const AsyncData(null);
        return;
      } else if (result is SuccessReturnType && result.data == null) {
        return;
      }
      if (result is SuccessReturnType && result.data != null) {
        List<Object> updatedPhotos = [
          ...ref.read(createEditPostStateProvider).photos,
          result.data!
        ];
        ref
            .read(createEditPostStateProvider.notifier)
            .updatePhotos(updatedPhotos);
      }
    }
  }

  Future<bool> uploadPost({required GlobalKey<FormState> formkey}) async {
    try {
      if (!formkey.currentState!.validate()) {
        return false;
      }
      final postState = ref.read(createEditPostStateProvider);

      if (postState.postContent.isEmpty) {
        state = AsyncError("게시물 내용은 빈칸으로 올릴 수 없습니다", StackTrace.current);
        state = const AsyncData(null);
        return false;
      } else if (postState.postTitle.isEmpty) {
        state = AsyncError("게시물 제목을 작성해주세요", StackTrace.current);
        state = const AsyncData(null);
        return false;
      }
      final isForEdit = postState.isForEdit;
      if (ref.read(currentUserProvider.notifier).mounted == false ||
          ref.read(currentUserProvider) == null) {
        state = AsyncError("Debug: current user error", StackTrace.current);
        state = const AsyncData(null);
        return false;
      }
      final user = ref.read(currentUserProvider)!;
      final String pid =
          isForEdit ? postState.editPostInformation!.pid : Uuid().v1();
      final photos = postState.photos;
      List<String>? photoUrls = await ref
          .watch(firebaseStorageProvider)
          .uploadPostImageToStorage(photos, pid);
      if (photoUrls == null) {
        state = AsyncError(
            ErrorMessageConstants.imageUploadError, StackTrace.current);
        state = AsyncData(null);
        return false;
      }
      PostModel post;

      if (isForEdit) {
        post = postState.editPostInformation!.update(
          postTitle: _titleController.text,
          postContent: _contentController.text,
          category: postState.category,
          contentImageUrlList: photoUrls,
        );
      } else {
        post = PostModel(
          postTitle: _titleController.text,
          postContent: _contentController.text,
          contentImageUrlList: photoUrls,
          pid: pid,
          userNickname: user.userNickname,
          uploadUserUid: user.userUid,
          category: postState.category,
          uploadTime: Timestamp.now(),
          userProfileURL: user.profileImageUrl,
          postLikes: 0,
        );
      }
      final postUploadResult = await ref
          .watch(firebasePostRepository)
          .uploadPostFirebase(post, isForEdit);
      if (postUploadResult == false) {
        state = AsyncError(
            ErrorMessageConstants.postUploadError, StackTrace.current);
        state = AsyncData(null);
        return false;
      }
      return true;
    } catch (error) {
      logToConsole("${ErrorMessageConstants.unknownError} : $error");
      return false;
    } finally {
      state = const AsyncData(null);
    }
  }
}
final createEditPostStateController = StateNotifierProvider<CreatePostController, AsyncValue<void>>((ref) {
  return CreatePostController(ref);
});