import 'package:email_vertify/common/utils/log_util.dart';
import 'package:email_vertify/model/user_model.dart';
import 'package:email_vertify/repository/firebase_user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<UserModel?> {
  final Ref ref;
  UserProvider(this.ref) : super(null);

  void setUser(UserModel? user) {
    state = user;
    print("currently signed in as ${user?.userNickname}. UID: ${user?.userUid}}");
  }

  Future<bool> updateUserFromFirebase() async {
    await Future.delayed(Duration(seconds: 1));
    final user = await ref.watch(firebaseUserRepository).fetchUser();
    if (user != null) {
      // print("CurrentUserProvider: profileImageUrl : ${user.profileImgUrl}");
      state = user;
    } 
    return true;
  }
}

final currentUserProvider = StateNotifierProvider.autoDispose<UserProvider, UserModel?>((ref) {
  ref.onDispose(() {
    logToConsole("currentUserProvider disposed");
  });
  return UserProvider(ref);
});
