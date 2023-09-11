import 'package:flutter/material.dart';
import 'package:mentor_app/screens/versioning/versioning_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/screens/versioning/widgets/list_version_widget.dart';
import 'package:mentor_app/shared_widget/custom_appbar.dart';

class VersioningScreen extends StatefulWidget {
  const VersioningScreen({super.key});

  @override
  State<VersioningScreen> createState() => _VersioningScreenState();
}

class _VersioningScreenState extends State<VersioningScreen> {
  final _bloc = VersioningBloc();

  @override
  void didChangeDependencies() {
    _bloc.getVerionsDetails();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(title: AppLocalizations.of(context)!.version_details),
      body: RefreshIndicator(
        onRefresh: _bloc.pullRefresh,
        child: VersionsList(versionsListNotifier: _bloc.versionsListNotifier),
      ),
    );
  }
}
