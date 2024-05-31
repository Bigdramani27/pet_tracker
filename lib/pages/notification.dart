import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../pages/dashboard.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/colors.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({super.key});

  @override
  State<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? topNavigationBar(context, scaffoldKey, 'Notifications')
            : null,
        drawer: const BigNav(currentPage: 'notification'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context)
                    ? const BigNav(currentPage: 'notification')
                    : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context)
                    ? const SmallNav(currentPage: 'notification')
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
                          const Text('Notifications',
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
                            "Welcome to the Notification Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "In this phase, you will be getting consistent health issues of your pet and when your hardware battery is low",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: green,
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.cat,
                                          color: primary,
                                          size: 15,
                                        ),
                                        Text(
                                          "Healthy",
                                          style: TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        ResponsiveWidget.isLargeScreen(context)
                                            ? 50
                                            : 20),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: line,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.cat,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(
                                                  context)
                                              ? 20
                                              : 15,
                                        ),
                                        const Text(
                                          "Abnormal",
                                          style: TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        ResponsiveWidget.isLargeScreen(context)
                                            ? 50
                                            : 20),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: thirdly,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.cat,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(
                                                  context)
                                              ? 20
                                              : 15,
                                        ),
                                        const Text(
                                          "Danger",
                                          style: TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        ResponsiveWidget.isLargeScreen(context)
                                            ? 50
                                            : 20),
                                Container(
                                  height: 40,
                                  width: 128,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: darkfacebook,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.batteryQuarter,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(
                                                  context)
                                              ? 20
                                              : 15,
                                        ),
                                        const Text(
                                          " Low Battery",
                                          style: TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        ResponsiveWidget.isLargeScreen(context)
                                            ? 50
                                            : 20),
                                Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: active,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.batteryEmpty,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(
                                                  context)
                                              ? 20
                                              : 15,
                                        ),
                                        const Text(
                                          "Power Off",
                                          style: TextStyle(
                                              color: primary,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500),
                              text: '* The ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'healthy',
                                    style: TextStyle(
                                        color: green,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' sign indicates that your pet is in excellent condition.'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500),
                              text: '* The ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'abnormal',
                                    style: TextStyle(
                                        color: line,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' sign indicates that your pet is not well and we recommend you to check our health tips for some guidelines'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500),
                              text: '* The ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'danger',
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' sign indicates that your pet is in a bad condition so it is recommended to see a veterinarian. Navigate to Map of Verterinaran to see which one is around '),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500),
                              text: '* The ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'low battery',
                                    style: TextStyle(
                                        color: darkfacebook,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' sign indicates that your hardware device is currently low. We recommend you to charge it'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500),
                              text: '* The ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'power off',
                                    style: TextStyle(
                                        color: active,
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text:
                                        ' sign indicates that your hardware is off due to power. We highly recommend you to charge it or replace it'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
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
                                    blurRadius: 4.0,
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: red,
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.close,
                                                size: 15,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          height:
                                              ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? 170
                                                  : 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              !ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: green,
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .cat,
                                                                  color:
                                                                      primary,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  "Healthy",
                                                                  style: TextStyle(
                                                                      color:
                                                                          primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Row(
                                                          children: [
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color:
                                                                    secondary,
                                                                size: 15),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                "24 November 2022 at 9:30 AM")
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: green,
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .cat,
                                                                  color:
                                                                      primary,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  "Healthy",
                                                                  style: TextStyle(
                                                                      color:
                                                                          primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                         Row(
                                                          children: [
                                                            const Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color:
                                                                    secondary,
                                                                size: 15),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              constraints: const BoxConstraints(maxWidth: 140),
                                                              child: const Text(
                                                                maxLines: 2,
                                                                  "24 November 2022 at 9:30 AM", style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Pet Message",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const Text(
                                                  "Your pet is healthy and it is in an excellent condition")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: secondary,
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: red,
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.close,
                                                size: 15,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          height:
                                              ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ?  170
                                                  : 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              !ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: line,
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .cat,
                                                                  color:
                                                                      primary,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  "Abnormal",
                                                                  style: TextStyle(
                                                                      color:
                                                                          primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Row(
                                                          children: [
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color:
                                                                    secondary,
                                                                size: 15),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                "24 November 2022 at 9:30 AM")
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: line,
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .cat,
                                                                  color:
                                                                      primary,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  "Abnormal",
                                                                  style: TextStyle(
                                                                      color:
                                                                          primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),  const SizedBox(height:5),
                                                         Row(
                                                          children: [
                                                            const Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color:
                                                                    secondary,
                                                                size: 15),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              constraints: const BoxConstraints(maxWidth: 140),
                                                              child: const Text(
                                                                maxLines: 2,
                                                                  "24 November 2022 at 9:30 AM", style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Pet Message",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const Text(
                                                  "Your pet is abnormal and we recommend you to check out health tips")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: secondary,
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: red,
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.close,
                                                size: 15,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          height:
                                              ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ?  170
                                                  : 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              !ResponsiveWidget.isSmallScreen(
                                                      context)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: red,
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .cat,
                                                                  color:
                                                                      primary,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  "Danger",
                                                                  style: TextStyle(
                                                                      color:
                                                                          primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const Row(
                                                          children: [
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color:
                                                                    secondary,
                                                                size: 15),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                                "24 November 2022 at 9:30 AM")
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: red,
                                                          ),
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.0,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .cat,
                                                                  color:
                                                                      primary,
                                                                  size: 15,
                                                                ),
                                                                Text(
                                                                  "Danger",
                                                                  style: TextStyle(
                                                                      color:
                                                                          primary,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height:5),
                                                         Row(
                                                          children: [
                                                            const Icon(
                                                                FontAwesomeIcons
                                                                    .clock,
                                                                color:
                                                                    secondary,
                                                                size: 15),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              constraints: const BoxConstraints(maxWidth: 140),
                                                              child: const Text(
                                                                maxLines: 2,
                                                                  "24 November 2022 at 9:30 AM", style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Pet Message",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const Text(
                                                  "Your pet is unhealthy and it requires mediate attention")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: secondary,
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: red,
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.close,
                                                size: 15,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: ResponsiveWidget.isSmallScreen(
                                                      context) ?  170 :100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                           !ResponsiveWidget.isSmallScreen(
                                                      context) ?   Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    width: 128,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: darkfacebook,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0,
                                                              horizontal: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .batteryQuarter,
                                                            color: primary,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " Low Battery",
                                                            style: TextStyle(
                                                                color: primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          color: secondary,
                                                          size: 15),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "24 November 2022 at 9:30 AM")
                                                    ],
                                                  ),
                                                ],
                                              ) : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                     Container(
                                                    height: 35,
                                                    width: 128,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: darkfacebook,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0,
                                                              horizontal: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .batteryQuarter,
                                                            color: primary,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            " Low Battery",
                                                            style: TextStyle(
                                                                color: primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),const SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          color: secondary,
                                                          size: 15),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                              constraints: const BoxConstraints(maxWidth: 140),
                                                              child: const Text(
                                                                maxLines: 2,
                                                                  "24 November 2022 at 9:30 AM", style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),),
                                                            )
                                                    ],
                                                  ),
                                              ],),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Device Message",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const Text(
                                                  "Your monitoring device is low kindly charge it or replace the battery")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: secondary,
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: red,
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.close,
                                                size: 15,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: ResponsiveWidget.isSmallScreen(
                                                      context) ? 170 : 100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                             !ResponsiveWidget.isSmallScreen(
                                                      context) ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: active,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0,
                                                              horizontal: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .batteryEmpty,
                                                            color: primary,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            "Power Off",
                                                            style: TextStyle(
                                                                color: primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          color: secondary,
                                                          size: 15),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "24 November 2022 at 9:30 AM")
                                                    ],
                                                  ),
                                                ],
                                              ) : Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                        Container(
                                                    height: 35,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: active,
                                                    ),
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.0,
                                                              horizontal: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .batteryEmpty,
                                                            color: primary,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                            "Power Off",
                                                            style: TextStyle(
                                                                color: primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ), const SizedBox(height: 5,),
                                                 Row(
                                                    children: [
                                                      const Icon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          color: secondary,
                                                          size: 15),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                              constraints: const BoxConstraints(maxWidth: 140),
                                                              child: const Text(
                                                                maxLines: 2,
                                                                  "24 November 2022 at 9:30 AM", style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),),
                                                            )
                                                    ],
                                                  ),  
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Device Message",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const Text(
                                                  "Your device went off kindly charge it or replace the battery")
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: secondary,
                                    thickness: 0.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                )),
          ],
        ));
  }
}
