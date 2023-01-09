import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/https/countries_model.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/shimmers/shimmer_list.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/routes.dart';

class ListOfCountriesWidget extends StatelessWidget {
  final ValueNotifier<List<Country>> countriesListNotifier;
  const ListOfCountriesWidget({Key? key, required this.countriesListNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<Country>>(
          valueListenable: countriesListNotifier,
          builder: (context, data, child) {
            return data.isEmpty
                ? const ShimmerListView(count: 10)
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return countryTile(context, data[index]);
                    });
          }),
    );
  }

  Widget countryTile(BuildContext context, Country item) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: InkWell(
        onTap: () async {
          var box = await Hive.openBox(DatabaseBoxConstant.userInfo);

          box.put(DatabaseFieldConstant.countryId, item.id.toString());
          box.put(DatabaseFieldConstant.countryFlag, item.flagImage);
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil(RoutesConstants.mainContainer, (Route<dynamic> route) => false);
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 16,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                SizedBox(
                    width: 40,
                    height: 40,
                    child: FadeInImage(
                        placeholder: const AssetImage("assets/images/flagPlaceHolderImg.png"),
                        image: NetworkImage(item.flagImage!, scale: 1))),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomText(
                    title: item.name!,
                    fontSize: 16,
                    textColor: const Color(0xff034061),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
