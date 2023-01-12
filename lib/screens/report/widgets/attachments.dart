import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';

class ReportAttatchment extends StatelessWidget {
  final Function(File?) attach1;
  final Function(File?) attach2;
  final Function(File?) attach3;

  const ReportAttatchment({required this.attach1, required this.attach2, required this.attach3, Key? key})
      : super(key: key);

  Future<File> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<File?> image1Controller = ValueNotifier<File?>(null);
    ValueNotifier<File?> image2Controller = ValueNotifier<File?>(null);
    ValueNotifier<File?> image3Controller = ValueNotifier<File?>(null);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                BottomSheetsUtil().addImageBottomSheet(
                  context,
                  false,
                  deleteCallBack: () {
                    image1Controller.value = null;
                    attach1(null);
                    Navigator.pop(context);
                  },
                  cameraCallBack: () async {
                    File image = await pickImage(ImageSource.camera);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image1Controller.value = image;
                    attach1(image);
                  },
                  galleryCallBack: () async {
                    File image = await pickImage(ImageSource.gallery);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image1Controller.value = image;
                    attach1(image);
                  },
                );
              },
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/attach_placeholder.png",
                    width: 70,
                    height: 70,
                  ),
                  ValueListenableBuilder<File?>(
                      valueListenable: image1Controller,
                      builder: (context, snapshot, child) {
                        return snapshot != null
                            ? Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    snapshot,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                BottomSheetsUtil().addImageBottomSheet(
                  context,
                  false,
                  deleteCallBack: () {
                    image2Controller.value = null;
                    attach2(null);

                    Navigator.pop(context);
                  },
                  cameraCallBack: () async {
                    File image = await pickImage(ImageSource.camera);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image2Controller.value = image;
                    attach2(image);
                  },
                  galleryCallBack: () async {
                    File image = await pickImage(ImageSource.gallery);
                    if (image.path.isEmpty) {
                      return;
                    }
                    image2Controller.value = image;
                    attach2(image);
                  },
                );
              },
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/attach_placeholder.png",
                    width: 70,
                    height: 70,
                  ),
                  ValueListenableBuilder<File?>(
                      valueListenable: image2Controller,
                      builder: (context, snapshot, child) {
                        return snapshot != null
                            ? Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    snapshot,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              BottomSheetsUtil().addImageBottomSheet(
                context,
                false,
                deleteCallBack: () {
                  image3Controller.value = null;
                  attach3(null);

                  Navigator.pop(context);
                },
                cameraCallBack: () async {
                  File image = await pickImage(ImageSource.camera);
                  if (image.path.isEmpty) {
                    return;
                  }
                  image3Controller.value = image;
                  attach3(image);
                },
                galleryCallBack: () async {
                  File image = await pickImage(ImageSource.gallery);
                  if (image.path.isEmpty) {
                    return;
                  }
                  image3Controller.value = image;
                  attach3(image);
                },
              );
            },
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/attach_placeholder.png",
                  width: 70,
                  height: 70,
                ),
                ValueListenableBuilder<File?>(
                    valueListenable: image3Controller,
                    builder: (context, snapshot, child) {
                      return snapshot != null
                          ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  snapshot,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container();
                    }),
              ],
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
