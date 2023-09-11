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
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 50, left: 16, right: 16),
              child: CustomText(
                title: title,
                fontSize: 24,
                textAlign: TextAlign.center,
                maxLins: 4,
                fontWeight: FontWeight.bold,
                textColor: const Color(0xff444444),
              ),
            ),
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                child: Image.asset(image),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
