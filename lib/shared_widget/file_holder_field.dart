import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class FileHolderField extends StatelessWidget {
  final Function(File image) onAddFile;
  final Function() onRemoveFile;

  final String title;
  const FileHolderField({super.key, required this.onAddFile, required this.title, required this.onRemoveFile});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<File?> fileController = ValueNotifier<File?>(null);

    return InkWell(
      onTap: () async {
        if (fileController.value == null) {
          try {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                // type: FileType.custom,
                // allowedExtensions: ['jpg', 'pdf', 'doc'],
                );

            if (result != null) {
              fileController.value = File(result.files.single.path!);
              onAddFile(File(result.files.single.path!));
            }
          } catch (error) {
            print(error);
            print("Can not Upload");
          }
        } else {
          fileController.value = null;
          onRemoveFile();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE8E8E8))),
        child: ValueListenableBuilder<File?>(
          valueListenable: fileController,
          builder: (context, snapshot, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title: title,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  textColor: Colors.black,
                ),
                snapshot != null
                    ? const Icon(
                        Icons.remove,
                        color: Color(0xff444444),
                      )
                    : const Icon(
                        Icons.add,
                        color: Color(0xff444444),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
