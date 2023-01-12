import 'package:flutter/material.dart';
import 'package:mentor_app/models/profile_options.dart';
import 'package:mentor_app/shared_widget/admob_banner.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/utils/constants/constant.dart';
import 'package:mentor_app/utils/routes.dart';
import 'package:mentor_app/utils/version.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListOfOptions extends StatelessWidget {
  final List<ProfileOptions> listOfSettingsOptions;
  final List<ProfileOptions> listOfReachOutUsOptions;
  final List<ProfileOptions> listOfSupportOptions;
  final List<ProfileOptions> listOfAccountOptions;

  const ListOfOptions(
      {required this.listOfSettingsOptions,
      required this.listOfReachOutUsOptions,
      required this.listOfSupportOptions,
      required this.listOfAccountOptions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AddMobBanner(),
            titleOptionCollection(title: AppLocalizations.of(context)!.accountsettings),
            optionCollectionItem(listOfAccountOptions, containerHight: 260),
            titleOptionCollection(title: AppLocalizations.of(context)!.generalsettings),
            optionCollectionItem(listOfSettingsOptions, containerHight: 125),
            titleOptionCollection(title: AppLocalizations.of(context)!.reachouttous),
            optionCollectionItem(listOfReachOutUsOptions, containerHight: 125),
            titleOptionCollection(title: AppLocalizations.of(context)!.support),
            optionCollectionItem(listOfSupportOptions, containerHight: 125),
            const SizedBox(height: 8),
            const AddMobBanner(),
            footerView(context),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget titleOptionCollection({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 16),
      child: CustomText(
        title: title,
        fontSize: 14,
        textColor: const Color(0xff444444),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget optionCollectionItem(List<ProfileOptions> listOfOptions, {required double containerHight}) {
    return Container(
      height: containerHight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: const Offset(0, 0.1),
          ),
        ],
      ),
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listOfOptions.length,
          separatorBuilder: (BuildContext context, int index) => const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Divider(),
              ),
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () => listOfOptions[index].onTap(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      listOfOptions[index].icon,
                      size: 20,
                      color: listOfOptions[index].iconColor,
                    ),
                    const SizedBox(width: 8),
                    CustomText(
                        title: listOfOptions[index].name,
                        fontSize: 16,
                        textColor: listOfOptions[index].nameColor,
                        fontWeight: FontWeight.w500),
                    Expanded(child: Container()),
                    listOfOptions[index].selectedItem != ""
                        ? CustomText(
                            title: listOfOptions[index].selectedItem,
                            fontSize: 14,
                            textColor: const Color(0xffFFA200),
                          )
                        : Container(),
                    listOfOptions[index].selectedItemImage != null
                        ? listOfOptions[index].selectedItemImage!
                        : Container(),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                      color: Color(0xffBFBFBF),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget footerView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen,
                    arguments: {
                      AppConstant.webViewPageUrl: AppConstant.facebookLink,
                      AppConstant.pageTitle: AppLocalizations.of(context)!.facebook
                    }),
                child: const Icon(
                  Icons.facebook,
                  color: Color(0xff444444),
                ),
              ),
              const CustomText(
                title: "|",
                fontSize: 16,
                textColor: Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () => _launchWhatsapp(context),
                child: const Icon(
                  Icons.whatsapp,
                  color: Color(0xff444444),
                ),
              ),
              const CustomText(
                title: "|",
                fontSize: 16,
                textColor: Color(0xff444444),
                fontWeight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen,
                    arguments: {
                      AppConstant.webViewPageUrl: AppConstant.linkedinLink,
                      AppConstant.pageTitle: AppLocalizations.of(context)!.linkedin
                    }),
                child: Image.asset(
                  "assets/images/linkedinLogo.png",
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                RateMyApp().showRateDialog(context, noButton: "test");
              });
            },
            child: _footerTextWidget(AppLocalizations.of(context)!.rateapp),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
              AppConstant.webViewPageUrl: AppConstant.termsLink,
              AppConstant.pageTitle: AppLocalizations.of(context)!.termsandconditions
            }),
            child: _footerTextWidget(AppLocalizations.of(context)!.termsandconditions),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context, rootNavigator: true).pushNamed(RoutesConstants.webViewScreen, arguments: {
              AppConstant.webViewPageUrl: AppConstant.privacypolicyLink,
              AppConstant.pageTitle: AppLocalizations.of(context)!.privacypolicy
            }),
            child: _footerTextWidget(AppLocalizations.of(context)!.privacypolicy),
          ),
          const SizedBox(height: 16),
          FutureBuilder<String>(
              initialData: "",
              future: Version().getApplicationVersion(),
              builder: (context, snapshot) {
                return CustomText(
                  title: "${AppLocalizations.of(context)!.version} ${snapshot.data}",
                  fontSize: 12,
                  textColor: const Color(0xffBFBFBF),
                );
              }),
          const SizedBox(height: 20),
          CustomText(
            title: AppLocalizations.of(context)!.rightsreserved,
            fontSize: 10,
            textColor: const Color(0xff707070),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _footerTextWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: title,
          fontSize: 10,
          textColor: const Color(0xff444444),
        ),
        const Icon(
          Icons.arrow_forward_rounded,
          size: 10,
          color: Color(0xff444444),
        )
      ],
    );
  }

  void _launchWhatsapp(BuildContext context) async {
    var whatsapp = AppConstant.whatsappNumber;
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.whatsappnotinstalled),
        ),
      );
    }
  }
}
