import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class FileHolderField extends StatelessWidget {
  final String title;
  final double width;
  final Function(File image) onAddFile;
  final Function() onRemoveFile;

  const FileHolderField({
    super.key,
    required this.onAddFile,
    required this.title,
    required this.onRemoveFile,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<File?> fileController = ValueNotifier<File?>(null);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          if (fileController.value == null) {
            try {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'pdf', 'doc'],
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
        child: ValueListenableBuilder<File?>(
            valueListenable: fileController,
            builder: (context, snapshot, child) {
              return Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: snapshot != null ? const Color(0xff034061) : const Color(0xffe0e0e0),
                  ),
                ),
                child: Row(
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
                ),
              );
            }),
      ),
    );
  }
}
