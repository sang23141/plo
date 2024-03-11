import 'package:email_vertify/model/post_model.dart';
import 'package:email_vertify/model/types/category_type.dart';

class CreateEditPostModel {
  List<Object> photos;
  String postTitle;
  CategoryType category;
  String postContent;
  bool isForEdit;
  PostModel? editPostInformation;

  CreateEditPostModel({
    this.photos = const [],
    this.postTitle =  "",
    this.category = CategoryType.information,
    this.postContent = "",
    this.isForEdit = false,
    this.editPostInformation
  });

  static CreateEditPostModel initForEditItem(PostModel editPostInformation) {
    return CreateEditPostModel(
      category: editPostInformation.category,
      photos: editPostInformation.contentImageUrlList,
      postTitle: editPostInformation.postTitle,
      postContent: editPostInformation.postContent,
      isForEdit: true,
      editPostInformation: editPostInformation
    );
  }

  CreateEditPostModel update({
    List<Object>? photos,
    String? postTitle,
    CategoryType? category,
    bool? isForEdit,
    String? postContent,
    PostModel? postForEdit

  }) {
    return CreateEditPostModel(
      photos: photos ?? this.photos,
      postTitle: postTitle ?? this.postTitle,
      category: category ?? this.category,
      postContent: postContent ?? this.postContent,
      isForEdit:  isForEdit ?? this.isForEdit,
      editPostInformation: postForEdit ?? this.editPostInformation,
    );
  }
}