import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/file_holder_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CertificateView extends StatefulWidget {
  final Function(File?, File?, File?) onChange;

  const CertificateView({
    super.key,
    required this.onChange,
  });

  @override
  State<CertificateView> createState() => _CertificateViewState();
}

class _CertificateViewState extends State<CertificateView> {
  ValueNotifier<File?> certificate1 = ValueNotifier<File?>(null);
  ValueNotifier<File?> certificate2 = ValueNotifier<File?>(null);
  ValueNotifier<File?> certificate3 = ValueNotifier<File?>(null);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<File?>(
            valueListenable: certificate1,
            builder: (context, snapshot, child) {
              return certView(
                  index: 1,
                  file: snapshot,
                  onAddFile: (file) {
                    certificate1.value = file;
                    widget.onChange(certificate1.value, certificate2.value, certificate3.value);
                  },
                  onRemove: () {
                    certificate1.value = null;
                    widget.onChange(certificate1.value, certificate2.value, certificate3.value);
                  });
            }),
        ValueListenableBuilder<File?>(
            valueListenable: certificate2,
            builder: (context, snapshot, child) {
              return certView(
                  index: 2,
                  file: snapshot,
                  onAddFile: (file) {
                    certificate2.value = file;
                    widget.onChange(certificate1.value, certificate2.value, certificate3.value);
                  },
                  onRemove: () {
                    certificate2.value = null;
                    widget.onChange(certificate1.value, certificate2.value, certificate3.value);
                  });
            }),
        ValueListenableBuilder<File?>(
            valueListenable: certificate3,
            builder: (context, snapshot, child) {
              return certView(
                  index: 3,
                  file: snapshot,
                  onAddFile: (file) {
                    certificate3.value = file;
                    widget.onChange(certificate1.value, certificate2.value, certificate3.value);
                  },
                  onRemove: () {
                    certificate3.value = null;
                    widget.onChange(certificate1.value, certificate2.value, certificate3.value);
                  });
            }),
      ],
    );
  }

  Widget certView({
    required int index,
    required File? file,
    required Function(File) onAddFile,
    required Function() onRemove,
  }) {
    return Row(
      children: [
        FileHolderField(
          title: "${AppLocalizations.of(context)!.certificate} $index",
          width: MediaQuery.of(context).size.width - 16,
          currentFile: file,
          onAddFile: (file) {
            onAddFile(file);
          },
          onRemoveFile: () => onRemove(),
        ),
      ],
    );
  }
}
