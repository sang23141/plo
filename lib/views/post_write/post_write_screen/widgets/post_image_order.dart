import 'dart:io';

import 'package:email_vertify/views/post_write/post_write_providers.dart';
import 'package:email_vertify/views/post_write/post_write_screen/widgets/post_create_images_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateEditPostImageOrderWidget extends ConsumerStatefulWidget {
  const CreateEditPostImageOrderWidget({super.key});
  @override
  ConsumerState<CreateEditPostImageOrderWidget> createState() =>
      _PhotoOrderState();
}

class _PhotoOrderState extends ConsumerState<CreateEditPostImageOrderWidget> {
  List<Object> _photos = [];
  Widget buildImageView(Object photo, int index, {bool isForProxy = false}) {
    return InkWell(
      key: UniqueKey(),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                CreateEditPostDetailWidget(index: index, photos: _photos),
          ),
        );
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: isForProxy ? null : EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    height: double.infinity,
                    child: photo is File
                        ? Image.file(
                            photo as File,
                            fit: BoxFit.cover,
                          )
                        : Text("There is an error loading the photo")),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "이미지 ${index + 1}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    if (index == 0)
                      const FittedBox(
                        child: Text("썸네일 이미지"),
                      ),
                  ]),
            ),
            IconButton(
                onPressed: () {
                  _photos.removeAt(index);
                  setState(() {});
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _photos = ref
        .read(createEditPostStateProvider)
        .photos
        .map((photo) => photo)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Center(
          child: Expanded(
            child: Column(
              children: [
                Text("이미지 순서 선택"),
                ReorderableListView(
                  proxyDecorator: (child, index, animation) => Material(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _photos
                          .map((photo) => buildImageView(
                              photo, _photos.indexOf(photo),
                              isForProxy: true))
                          .toList()[index],
                    ),
                  ),
                  children: _photos
                      .map((photo) =>
                          buildImageView(photo, _photos.indexOf(photo)))
                      .toList(),
                  onReorder: ((oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex <= -1;
                    }
                    final Object post = _photos.removeAt(oldIndex);
                    _photos.insert(newIndex, post);
                    setState(() {});
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(createEditPostStateProvider.notifier)
                        .updatePhotos(_photos);
                    Navigator.of(context).pop;
                  },
                  child: Text("확인"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
