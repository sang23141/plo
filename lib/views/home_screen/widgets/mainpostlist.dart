import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:plo/common/widgets/loading_widgets/expande_loading_post.dart';
import 'package:plo/common/widgets/loading_widgets/loading_expanded_post.dart';
import 'package:plo/common/widgets/no_more_post.dart';
import 'package:plo/common/widgets/no_post_found.dart';
import 'package:plo/model/user_model.dart';
import 'package:plo/repository/firebase_user_repository.dart';
import 'package:plo/views/home_screen/main_post_list_controller.dart';
import 'package:plo/views/home_screen/main_post_list_provider.dart';

final mainPostListCurrentUserProvider =
    FutureProvider.autoDispose<UserModel?>((ref) async {
  final user = await ref.watch(firebaseUserRepository).fetchUser();
  return user;
});

class MainPostList extends ConsumerWidget {
  const MainPostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainpostListController);
    final posts = ref.watch(mainListProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(mainpostListController);
        ref.refresh(mainPostListCurrentUserProvider);
      },
      child: ref.watch(mainPostListCurrentUserProvider).when(
        data: (currentUser) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: state.isLoading
                ? const ExpandedPostListLoadingWidget()
                : posts.length == 0
                    ? const NoPostFound()
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: ref
                            .watch(mainpostListController.notifier)
                            .scrollController,
                        itemBuilder: (context, index) {
                          if (index >= posts.length) {
                            return ref
                                    .watch(mainpostListController.notifier)
                                    .isPostAllLoaded
                                ? const NoMorePost()
                                : const LoadingExpandedPostWidget();
                          }
                          return InkWell(
                            onTap: () async {
                              if (posts.elementAt(index).showWarning) {
                                final isConfirmed = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return 
                                  }
                                )
                              }
                            }
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
