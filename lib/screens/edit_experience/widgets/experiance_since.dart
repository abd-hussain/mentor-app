import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_app/shared_widget/custom_text.dart';
import 'package:mentor_app/shared_widget/custom_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExperianceSinceField extends StatefulWidget {
  final TextEditingController controller;
  final bool isEnable;
  final EdgeInsets padding;
  final VoidCallback onSelected;
  const ExperianceSinceField(
      {required this.controller,
      this.padding = const EdgeInsets.only(left: 16, right: 16),
      this.isEnable = true,
      required this.onSelected,
      super.key});

  @override
  State<ExperianceSinceField> createState() => _ExperianceSinceFieldState();
}

class _ExperianceSinceFieldState extends State<ExperianceSinceField> {
  @override
  void initState() {
    widget.controller.addListener(() {
      widget.onSelected();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextField(
          readOnly: true,
          enabled: widget.isEnable,
          controller: widget.controller,
          hintText: AppLocalizations.of(context)!.experience_since,
          padding: widget.padding,
          keyboardType: TextInputType.name,
          inputFormatters: [
            LengthLimitingTextInputFormatter(45),
          ],
        ),
        InkWell(
          onTap: widget.isEnable
              ? () async {
                  await experianceSinceBottomSheet(context, (selected) {
                    widget.controller.text = selected;
                  });
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55,
            ),
          ),
        ),
      ],
    );
  }

  Future experianceSinceBottomSheet(BuildContext context, Function(String) selectedYear) {
    List<String> listOfYears = [
      "2023",
      "2022",
      "2021",
      "2020",
      "2019",
      "2018",
      "2017",
      "2016",
      "2015",
      "2014",
      "2013",
      "2012",
      "2011",
      "2010",
      "2009",
      "2008",
      "2007",
      "2006",
      "2005",
      "2004",
      "2003",
      "2002",
      "2001",
      "2000",
      "1999",
      "1998",
      "1997",
      "1996",
      "1995",
      "1994",
      "1993",
      "1992",
      "1991",
      "1990",
      "1989",
      "1988",
      "1987",
      "1986",
      "1985",
      "1984",
      "1983",
      "1982",
      "1981",
      "1980",
      "1979",
      "1978",
      "1977",
      "1976",
      "1975",
      "1974",
    ];
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title: AppLocalizations.of(context)!.experience_since,
                textColor: Colors.black,
                fontSize: 20,
              ),
              const SizedBox(height: 27.0),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: listOfYears.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        selectedYear(listOfYears[index]);
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomText(
                                title: listOfYears[index],
                                fontSize: 16,
                                textColor: const Color(0xff444444),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
