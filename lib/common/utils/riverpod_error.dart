import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodErrorHelperFunction {
  static void showSnackBarOnError(
      WidgetRef ref, provider, BuildContext context) {
    ref.listen<AsyncValue>(provider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.error.toString(),
            ),
          ),
        );
      }
    });
  }
}
