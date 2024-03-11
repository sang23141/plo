import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_vertify/common/validator/validator.dart';
import 'package:email_vertify/model/types/category_type.dart';
import 'package:email_vertify/views/post_write/post_write_controller.dart';
import 'package:email_vertify/views/post_write/post_write_providers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CreateEditPostFormWidget extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const CreateEditPostFormWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const SizedBox defaultSpacing = SizedBox(height: 10);
    final postState = ref.watch(createEditPostStateProvider);
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("제목"),
            defaultSpacing,
            TextFormField(
                controller: ref
                    .watch(createEditPostStateController.notifier)
                    .titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "제목",
                ),
                maxLength: 50,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                validator: (value) {
                  return Validator.titleValidator(value);
                }),
            defaultSpacing,
            Text("카테고리"),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                style: TextStyle(fontWeight: FontWeight.bold),
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  maxHeight: 150,
                  useSafeArea: true,
                ),
                menuItemStyleData: MenuItemStyleData(),
                customButton: Container(
                  width: double.infinity,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        postState.category.toString(),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Icon(Icons.arrow_downward)
                    ],
                  ),
                ),
                items: CategoryType.values
                    .sublist(0, CategoryType.values.length - 1)
                    .map(
                      (categories) => DropdownMenuItem(
                        alignment: Alignment.centerLeft,
                        value: categories.toString(),
                        child: Container(
                          width: double.infinity,
                          padding:EdgeInsets.all(10),
                        )
                      ),
                    ).toList(),
                    onChanged: (value) {
                      if(value != null) {
                        CategoryType newCategory = CategoryType.stringToCategory(value);
                        ref.read(createEditPostStateProvider.notifier).updateCategory(newCategory);
                      }
                    },
              ),
            ),
            defaultSpacing,
            Text("내용"),
            defaultSpacing,
            TextFormField(
                controller: ref
                    .watch(createEditPostStateController.notifier)
                    .contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "내용",
                ),
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                validator: (value) {
                  return Validator.contentValidator(value);
                }),
          ],
        ));
  }
}
