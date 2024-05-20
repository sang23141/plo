import 'package:plo/model/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPostListProvider extends StateNotifier<List<PostModel>> {
  MainPostListProvider() : super(const []);

  _postExistInList(PostModel post) {
    return state.any((postInList) => postInList.pid == postInList.pid);
  }

  setPostList(List<PostModel> postList) {
    state = postList;
  }

  addListenToPostList(List<PostModel> postList) {
    state = [...state, ...postList];
  }

  updateSingePostInPostList(PostModel post) {
    if (_postExistInList(post)) {
      state = state
          .map((postInList) =>
              (postInList.pid == postInList.pid) ? post : postInList)
          .toList();
    }
  }
}

final mainListProvider =
    StateNotifierProvider.autoDispose<MainPostListProvider, List<PostModel>>(
        (ref) {
  return MainPostListProvider();
});
