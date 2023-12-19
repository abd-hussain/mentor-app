import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';

class TutView extends StatelessWidget {
  final String title;
  final String image;

  const TutView({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: CustomText(
                title: title,
                fontSize: 24,
                textAlign: TextAlign.center,
                maxLins: 4,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    (MediaQuery.of(context).size.width - 16) / 2),
                child: Image.asset(
                  image,
                  height: MediaQuery.of(context).size.width - 16,
                  width: MediaQuery.of(context).size.width - 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
