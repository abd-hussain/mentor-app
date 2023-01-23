import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FileHolderField extends StatelessWidget {
  final Function(File image) onAddImage;
  final Function() onDeleteImage;
  const FileHolderField({super.key, required this.onAddImage, required this.onDeleteImage});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<File?> fileController = ValueNotifier<File?>(null);
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width - 16,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE8E8E8))),
        child: ValueListenableBuilder<File?>(
          valueListenable: fileController,
          builder: (context, snapshot, child) {
            return snapshot != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      snapshot,
                      width: 100,
                      height: 115,
                      fit: BoxFit.cover,
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: AppLocalizations.of(context)!.cv,
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        textColor: Colors.black,
                      ),
                      const Icon(
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
