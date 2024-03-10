import 'package:algoliasearch/algoliasearch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPostsController extends StateNotifier<AsyncValue<void>> {
  Ref ref;
  String searchQuery = "";
  SearchPostsController(this.ref) : super(const AsyncLoading()) {
    _init();
  }

  _init() async {
    state = const AsyncLoading();
    //final searchHistory = await ref.watch(sharedPreferenceRepositoryProvider).loadSearchHistory();
    //if (searchHistory != null) ref.read(searchHistoryListProvider.notifier).setList(searchHistory);
    state = const AsyncData(null);
  }
}

final searchItemsControllerProvider =
    StateNotifierProvider.autoDispose<SearchPostsController, AsyncValue<void>>(
        (ref) {
  ref.onDispose(() {
    //log("SearchItemsController disposed");
  });
  return SearchPostsController(ref);
});
