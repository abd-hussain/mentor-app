import 'package:flutter/material.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/screens/main_contaner/main_container_bloc.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/constants/constant.dart';

class HeaderHomePage extends StatefulWidget {
  final bool showRefresh;
  const HeaderHomePage({super.key, this.showRefresh = false});

  @override
  State<HeaderHomePage> createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          const CustomText(
            title: AppConstant.appName,
            fontSize: 30,
            textColor: Color(0xff444444),
            fontWeight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          widget.showRefresh
              ? IconButton(
                  onPressed: () => locator<MainContainerBloc>()
                      .getMentorAppointments(context),
                  icon: const Icon(
                    Icons.refresh,
                    color: Color(0xff034061),
                    size: 30,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
