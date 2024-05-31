import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kelpet/constants/colors.dart';
import 'package:kelpet/helpers/responsiveness.dart';
import 'package:kelpet/navigator/big_nav.dart';
import 'package:kelpet/navigator/small_nav.dart';
import 'package:kelpet/widgets/top_layout_mobile.dart';

class HealthTips extends StatelessWidget {
  HealthTips({super.key});

  @override
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? topNavigationBar(context, scaffoldKey, 'Health Tips')
            : null,
        drawer: const BigNav(currentPage: 'health_tips'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context)
                    ? const BigNav(currentPage: 'health_tips')
                    : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context)
                    ? const SmallNav(currentPage: 'add_pet')
                    : null,
              )),
            if (ResponsiveWidget.isSmallScreen(context)) Container(),
            Expanded(
                flex: ResponsiveWidget.isLargeScreen(context) ? 5 : 7,
                child: SingleChildScrollView(
                  child: Container(
                      margin: ResponsiveWidget.isLargeScreen(context)
                          ? const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 120)
                          : ResponsiveWidget.isMediumScreen(context)
                              ? const EdgeInsets.symmetric(
                                  vertical: 50, horizontal: 100)
                              : ResponsiveWidget.isSmallScreen(context)
                                  ? const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20)
                                  : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Health Tips',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 5),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Welcome to the Health Tips Board",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "In this phase, we will providing you with some information that will make you caucious",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primary,
                                boxShadow: [
                                  const BoxShadow(
                                    color: active,
                                    offset: Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 10.0,
                                  ),
                                ]),
                            child:  const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: const Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.lightbulb, color: Colors.amber,), SizedBox(width: 10,),
                                      Expanded(child: Text("How is Jacinta like in person? ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600 ),)),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 2,),
                                Padding(
                                  padding: const EdgeInsets.symmetric( horizontal: 32),
                                  child: Text("She is sweet but sometimes, we leave it to God to help us"),
                                )
                              ],
                            ),
                          ),
                           const SizedBox(
                            height: 10,
                          ),
                             Container(
                               padding: const EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primary,
                                boxShadow: [
                                  const BoxShadow(
                                    color: active,
                                    offset: Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 10.0,
                                  ),
                                ]),
                            child:  const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.lightbulb, color: Colors.amber,), SizedBox(width: 10,),
                                      Expanded(child: Text("Why does Jacinta get angry and annoying? ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600 ),)),
                                    ],
                                  ),
                                ),
                                Divider(thickness: 2,),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                                  child: Text("She doesn't communicate well and expect her boyfriend to know what is going well"),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                )),
          ],
        ));
  }
}
