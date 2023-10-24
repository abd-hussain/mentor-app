import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/screens/tutorials/widgets/dot_indicator_view.dart';
import 'package:mentor_app/screens/tutorials/widgets/tut_view1.dart';

class TutorialsScreen extends StatefulWidget {
  const TutorialsScreen({super.key});

  @override
  State<TutorialsScreen> createState() => _TutorialsScreenState();
}

class _TutorialsScreenState extends State<TutorialsScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //TODO: put prober images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: [
              TutView(
                title: AppLocalizations.of(context)!.tutorial1,
                image: "assets/images/tutorials/tutorials1.jpg",
              ),
              TutView(
                title: AppLocalizations.of(context)!.tutorial2,
                image: "assets/images/tutorials/tutorials.png",
              ),
              TutView(
                title: AppLocalizations.of(context)!.tutorial3,
                image: "assets/images/tutorials/tutorials.png",
              ),
              TutView(
                title: AppLocalizations.of(context)!.tutorial4,
                image: "assets/images/tutorials/tutorials.png",
              ),
              TutView(
                title: AppLocalizations.of(context)!.tutorial5,
                image: "assets/images/tutorials/tutorials.png",
              ),
            ],
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 75,
              color: Colors.grey[800],
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: DotsIndicator(
                  controller: controller,
                  onPageSelected: (int page) {
                    controller.animateToPage(
                      page,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  skipPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
