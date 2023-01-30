import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentor_app/shared_widget/custom_button.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPostBottomSheetsUtil {
  final BuildContext context;
  final String language;

  AddPostBottomSheetsUtil({
    required this.context,
    required this.language,
  });

  Future bottomSheet({
    required Function(File) postAdded,
  }) async {
    ValueNotifier<File?> assetsController = ValueNotifier<File?>(null);

    return await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      enableDrag: true,
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
          child: Wrap(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Expanded(child: SizedBox()),
                  CustomText(
                    title: AppLocalizations.of(context)!.addnewpost,
                    textColor: const Color(0xff444444),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffE8E8E8),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ValueListenableBuilder<File?>(
                            valueListenable: assetsController,
                            builder: (context, snapshot, child) {
                              return snapshot != null
                                  ? Center(
                                      child: Image.file(
                                        snapshot,
                                        fit: BoxFit.cover,
                                        height: 300,
                                      ),
                                    )
                                  : Image.asset("assets/images/storyplaceholder.png");
                            }),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  File image = await pickImage(ImageSource.gallery);
                  if (image.path.isEmpty) {
                    return;
                  }
                  assetsController.value = image;
                },
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.image_outlined,
                          color: Color(0xff444444),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomText(
                          title: AppLocalizations.of(context)!.pickimagefromstudio,
                          fontSize: 16,
                          textColor: const Color(0xff444444),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  File image = await pickImage(ImageSource.camera);
                  if (image.path.isEmpty) {
                    return;
                  }
                  assetsController.value = image;
                },
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xff444444),
                          )),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomText(
                          title: AppLocalizations.of(context)!.pickimagefromcamera,
                          fontSize: 16,
                          textColor: const Color(0xff444444),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<File?>(
                  valueListenable: assetsController,
                  builder: (context, snapshot, child) {
                    return CustomButton(
                      buttonTitle: AppLocalizations.of(context)!.addnewpost,
                      enableButton: snapshot != null,
                      onTap: () {
                        Navigator.pop(context);
                        postAdded(assetsController.value!);
                      },
                    );
                  })
            ],
          ),
        );
      },
    );
  }

  Future<File> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }
}
