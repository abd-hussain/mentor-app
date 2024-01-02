import 'package:flutter/material.dart';

class HeaderHomePage extends StatefulWidget {
  final Function()? refreshCallBack;
  const HeaderHomePage({super.key, this.refreshCallBack});

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
          Image.asset(
            "assets/images/logo.png",
            width: 100,
          ),
          Expanded(child: Container()),
          widget.refreshCallBack != null
              ? IconButton(
                  onPressed: () => widget.refreshCallBack!(),
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
