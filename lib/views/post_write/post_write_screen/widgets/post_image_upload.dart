import 'package:email_vertify/views/post_write/post_write_controller.dart';
import 'package:email_vertify/views/post_write/post_write_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CreateEditPostImage extends ConsumerWidget {
  const CreateEditPostImage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: SafeArea(
      child: Column(children: [
        ElevatedButton(
            child: Text("Add a Picture"),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                            leading: Icon(Icons.camera),
                            title: Text("카메라"),
                            onTap: () async {
                              await ref
                                  .read(createEditPostStateController.notifier)
                                  .pickImageFromCamera();
                              Navigator.of(context).pop;
                            }),
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text("갤러리"),
                          onTap: () async {
                            await ref.read(createEditPostStateController.notifier).pickMultipleImagesFromGallery();
                            Navigator.of(context).pop;
                          }
                        )
                      ]);
                },
              );
            }),
      ]),
    ));
  }
}
