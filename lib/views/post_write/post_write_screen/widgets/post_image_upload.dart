import 'package:email_vertify/views/post_write/post_write_controller.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateEditPostImage extends ConsumerWidget {
  const CreateEditPostImage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: SafeArea(
      child: Column(children: [
        ElevatedButton(
            child: const Text("Add a Picture"),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                            leading: const Icon(Icons.camera),
                            title: const Text("카메라"),
                            onTap: () async {
                              await ref
                                  .read(createEditPostStateController.notifier)
                                  .pickImageFromCamera();
                              Navigator.of(context).pop;
                            }),
                        ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text("갤러리"),
                            onTap: () async {
                              await ref
                                  .read(createEditPostStateController.notifier)
                                  .pickMultipleImagesFromGallery();
                              Navigator.of(context).pop;
                            })
                      ]);
                },
              );
            }),
      ]),
    ));
  }
}
