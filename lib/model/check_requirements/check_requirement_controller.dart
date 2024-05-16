import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_auth_repository.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';

final isProfileSetUpProvider =StateProvider((ref) => false);

class CheckAppRequirementController extends StateNotifier<AsyncValue<void>> {
  final BuildContext context;
  Ref ref;
  CheckAppRequirementController(this.ref, this.context) : super(const AsyncValue.loading()) {
    _init();
  }
  void _init() async {
    state = const AsyncValue.loading();
    final user = ref.watch(firebaseAuthRepositoryProvider).getCurrentUser();
  if(user == null) {
    state = const AsyncData(null);
    return;
  }
  UserModel? fetchUser = await ref.watch(firebaseUserRepository).fetchUser();
  if(fetchUser == null) {
    ref.watch(isProfileSetUpProvider.notifier).state = false;
  } else {
    ref.watch(isProfileSetUpProvider.notifier).state = true;
    ref.read(currentUserProvider.notifier).setUser(fetchUser);
  }
  state = const AsyncValue.data(null);
  }
}
final checkAppRequirmentProvider = StateNotifierProvider.family.autoDispose<CheckAppRequirementController, AsyncValue<void>, BuildContext>((ref, context) {
  return CheckAppRequirementController(ref, context);
});