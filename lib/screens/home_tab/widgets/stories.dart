import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/constants/constant.dart';

class StoriesHomePage extends StatelessWidget {
  final List<MainStory> listOfStories;
  final Function(int id) openMentorProfile;
  final Function(int id) reportStory;
  const StoriesHomePage(
      {required this.listOfStories, required this.openMentorProfile, required this.reportStory, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listOfStories.length,
        itemBuilder: (context, index) {
          return storyWidget(context: context, story: listOfStories[index], openProfile: (id) => openMentorProfile(id));
        },
      ),
    );
  }

  Widget storyWidget({required BuildContext context, required MainStory story, required Function(int) openProfile}) {
    return InkWell(
      onTap: () async {
        await BottomSheetsUtil().showStoryFullView(
            profileId: story.owner!.id!,
            profileName: story.owner!.firstName! + story.owner!.lastName!,
            profileImg: (story.owner!.profileImg != null && story.owner!.profileImg != "")
                ? AppConstant.imagesBaseURLForMentors + story.owner!.profileImg!
                : "",
            context: context,
            assets: story.assets!,
            openProfile: (id) => openProfile(id),
            reportStory: (id) async {
              await BottomSheetsUtil().areYouShoureButtomSheet(
                context: context,
                message: AppLocalizations.of(context)!.reportstory,
                sure: () => reportStory(story.owner!.id!),
              );
            });
      },
      child: SizedBox(
        width: 110,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xff034061),
                radius: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: story.owner!.profileImg! != ""
                      ? FadeInImage(
                          placeholder: const AssetImage("assets/images/avatar.jpeg"),
                          image: NetworkImage(AppConstant.imagesBaseURLForMentors + story.owner!.profileImg!, scale: 1),
                        )
                      : Image.asset(
                          'assets/images/avatar.jpeg',
                          width: 70,
                          height: 70,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              CustomText(
                title: story.owner!.firstName! + story.owner!.lastName!,
                fontSize: 12,
                maxLins: 4,
                textAlign: TextAlign.center,
                textColor: const Color(0xff444444),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
