import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/models/https/home_response.dart';
import 'package:mentor_app/shared_widget/bottom_sheet_util.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/constants/constant.dart';

class StoriesHomePage extends StatelessWidget {
  final List<MainStory> listOfStories;
  final Function(int id) reportStory;
  final Function() onAddStory;

  const StoriesHomePage({required this.listOfStories, required this.reportStory, Key? key, required this.onAddStory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        children: [
          titleView(context),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listOfStories.length,
              itemBuilder: (context, index) {
                return storyWidget(
                  context: context,
                  story: listOfStories[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget storyWidget({required BuildContext context, required MainStory story}) {
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

  Widget titleView(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          CustomText(
            title: AppLocalizations.of(context)!.posts,
            fontSize: 16,
            textColor: const Color(0xff444444),
            fontWeight: FontWeight.bold,
          ),
          const Expanded(child: SizedBox()),
          IconButton(
              onPressed: () => onAddStory(),
              icon: Container(
                color: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: Color(0xff444444),
                ),
              ))
        ],
      ),
    );
  }
}
