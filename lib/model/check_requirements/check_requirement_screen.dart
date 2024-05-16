import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/check_requirements/check_requirement_controller.dart';
import 'package:plo/views/home_screen/home_screen.dart';
import 'package:plo/views/post_write/user_provider/user_provider.dart';

class CheckAppRequirementsScreen extends ConsumerStatefulWidget{
  const CheckAppRequirementsScreen({super.key});
  @override
  ConsumerState<CheckAppRequirementsScreen> createState() => _CheckAppRequirementsScreen();
}

class _CheckAppRequirementsScreen extends ConsumerState<CheckAppRequirementsScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkAppRequirmentProvider(context));
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: state.isLoading? const CircularProgressIndicator() : const HomeScreen()
    );
  }
}