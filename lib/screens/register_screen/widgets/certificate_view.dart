import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/file_holder_field.dart';

class CertificateView extends StatefulWidget {
  final Function(List<File>) certificatesListCallBack;
  final double width;
  const CertificateView({super.key, required this.certificatesListCallBack, this.width = 64});

  @override
  State<CertificateView> createState() => _CertificateViewState();
}

class _CertificateViewState extends State<CertificateView> {
  ValueNotifier<int> countOfCertifictes = ValueNotifier<int>(1);
  List<File> certificatesList = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: countOfCertifictes,
        builder: (context, snapshot, child) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: countOfCertifictes.value,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  FileHolderField(
                    title: "Certificate (${index + 1})",
                    width: MediaQuery.of(context).size.width - widget.width,
                    onAddFile: (file) {
                      certificatesList.add(file);
                      widget.certificatesListCallBack(certificatesList);
                    },
                    onRemoveFile: () {
                      certificatesList.removeAt(index);
                      widget.certificatesListCallBack(certificatesList);
                    },
                  ),
                  IconButton(
                    icon: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.green[200] : Colors.red[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        index == 0 ? Icons.add : Icons.remove,
                        color: const Color(0xff444444),
                      ),
                    ),
                    onPressed: () {
                      // certificatesList = [];
                      // widget.certificatesListCallBack(certificatesList);
                      if (index == 0) {
                        countOfCertifictes.value = countOfCertifictes.value + 1;
                      } else {
                        countOfCertifictes.value = countOfCertifictes.value - 1;
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }
}
