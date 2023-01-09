import 'package:flutter/material.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);
  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F7),
      resizeToAvoidBottomInset: false,
    );
  }
}
