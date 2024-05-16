import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plo/common/utils/log_util.dart';
import 'package:plo/constants/error_replacement_constants.dart';
import 'package:plo/model/types/category_type.dart';
import 'package:http/http.dart';

class PostModelFieldNameConstants {
  static const pid = "pid";
  static const uploadUserUid = "uid";
  static const userNickname = "userNickname";
  static const userProfileURL = "userProfileURL";
  static const category = "category";
  static const postContent = "postContent";
  static const postTitle = "postTitle";
  static const contentImageUrlList = "contentImageURL";
  static const postLikes = "postLikes";
  static const isPostImageBool = "istPostImageBool";
  static const uploadTime = "uploadTime";
  static const postViewList = "postViewList";
  static const postViewListLength = "postViewListLength";
}

class PostModel {
  final String pid;
  final String uploadUserUid;
  final String userNickname;
  final String userProfileURL;
  final String postTitle;
  final String postContent;
  final List<String> contentImageUrlList;
  final int postLikes;
  final Timestamp? uploadTime;
  final bool isPostImageBool;
  final CategoryType category;
  final List<String> postViewList;
  final int postViewListLength;

  PostModel({
    this.pid = ErrorReplacementConstants.notSetString,
    this.uploadUserUid = ErrorReplacementConstants.notSetString,
    this.userNickname = ErrorReplacementConstants.notSetString,
    this.userProfileURL = ErrorReplacementConstants.notSetString,
    this.postTitle = ErrorReplacementConstants.notSetString,
    this.postContent = ErrorReplacementConstants.notSetString,
    this.contentImageUrlList = const [],
    this.postLikes = 0,
    this.uploadTime,
    this.isPostImageBool = false,
    this.category = CategoryType.information,
    this.postViewList = const [],
    this.postViewListLength = 0,
  });

  Map<String, Object?> toJson() {
    return {
      PostModelFieldNameConstants.pid: pid,
      PostModelFieldNameConstants.uploadUserUid: uploadUserUid,
      PostModelFieldNameConstants.userNickname: userNickname,
      PostModelFieldNameConstants.userProfileURL: userProfileURL,
      PostModelFieldNameConstants.postTitle: postTitle,
      PostModelFieldNameConstants.postContent: postContent,
      PostModelFieldNameConstants.contentImageUrlList: contentImageUrlList,
      PostModelFieldNameConstants.postLikes: postLikes,
      PostModelFieldNameConstants.uploadTime: uploadTime,
      PostModelFieldNameConstants.isPostImageBool: isPostImageBool,
      PostModelFieldNameConstants.category: category.toString(),
      PostModelFieldNameConstants.postViewList: postViewList,
      PostModelFieldNameConstants.postViewListLength: postViewListLength,
    };
  }

  PostModel? fromJson(Map<String, dynamic> json) {
    try {
      final List<String> convertedPostViewList =
          json[PostModelFieldNameConstants.postViewList] == null
              ? const []
              : (json[PostModelFieldNameConstants.postViewList]
                      as List<dynamic>)
                  .map((e) => e.toString())
                  .toList();
      final List<String> convertedcontentImageUrlList =
          json[PostModelFieldNameConstants.contentImageUrlList] == null
              ? const []
              : (json[PostModelFieldNameConstants.contentImageUrlList]
                      as List<dynamic>)
                  .map((e) => e.toString())
                  .toList();

      return PostModel(
          pid: json[PostModelFieldNameConstants.pid] ??
              ErrorReplacementConstants.notFoundString,
          uploadUserUid: json[PostModelFieldNameConstants.uploadUserUid] ??
              ErrorReplacementConstants.notFoundString,
          userNickname: json[PostModelFieldNameConstants.userNickname] ??
              ErrorReplacementConstants.notFoundString,
          userProfileURL: json[PostModelFieldNameConstants.userProfileURL] ??
              ErrorReplacementConstants.notFoundString,
          postTitle: json[PostModelFieldNameConstants.postTitle] ??
              ErrorReplacementConstants.notFoundString,
          postContent: json[PostModelFieldNameConstants.postContent] ??
              ErrorReplacementConstants.notFoundString,
          contentImageUrlList: convertedcontentImageUrlList,
          uploadTime: json[PostModelFieldNameConstants.uploadTime],
          isPostImageBool:
              json[PostModelFieldNameConstants.isPostImageBool] ?? false,
          category: CategoryType.stringToCategory(
              json[PostModelFieldNameConstants.category]),
          postLikes: json[PostModelFieldNameConstants.postLikes] ?? 0,
          postViewList: convertedPostViewList,
          postViewListLength:
              json[PostModelFieldNameConstants.postViewList] ?? -1);
    } catch (error) {
      logToConsole('PostModel fromJson Error: ${error.toString()}');
      return null;
    }
  }

  PostModel update(
      {String? pid,
      String? uploadUserUid,
      String? userNickname,
      String? userProfileURL,
      String? postTitle,
      String? postContent,
      List<String>? contentImageUrlList,
      Timestamp? uploadTime,
      bool? isPostImageBool,
      CategoryType? category,
      int? postLikes,
      List<String>? postViewList,
      int? postViewListLength}) {
    return PostModel(
        pid: pid ?? this.pid,
        uploadUserUid: uploadUserUid ?? this.uploadUserUid,
        userNickname: userNickname ?? this.userNickname,
        userProfileURL: userProfileURL ?? this.userProfileURL,
        postTitle: postTitle ?? this.postTitle,
        postContent: postContent ?? this.postContent,
        contentImageUrlList: contentImageUrlList ?? this.contentImageUrlList,
        uploadTime: uploadTime ?? this.uploadTime,
        isPostImageBool: isPostImageBool ?? this.isPostImageBool,
        category: category ?? this.category,
        postLikes: postLikes ?? this.postLikes,
        postViewList: postViewList ?? this.postViewList,
        postViewListLength: postViewListLength ?? this.postViewListLength);
  }

  @override
  String toString() {
    return 'PostModel(pid: $pid, uploadUseruid: $uploadUserUid)';
  }
}
