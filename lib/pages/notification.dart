import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
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
  bool loading = false;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  List<String> serialNumber = [];
  Future<List<String>> getSerial() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("pet_table").where("user", isEqualTo: currentUser).get();
    List<String> rulers = [];
    snapshot.docs.forEach((doc) {
      rulers.add(doc['serial_number']);
    });
    serialNumber = rulers;

    return rulers;
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> temp;
  late Stream<QuerySnapshot<Map<String, dynamic>>> collar;
  late Stream<QuerySnapshot<Map<String, dynamic>>> heart;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeData();
    temp = FirebaseFirestore.instance.collection("temperature_reading").orderBy("time", descending: true).snapshots();
    collar = FirebaseFirestore.instance.collection("collar_battery").orderBy("time", descending: true).snapshots();
    heart = FirebaseFirestore.instance.collection("heart_rate").orderBy("time", descending: true).snapshots();
  }

  void _initializeData() async {
    await getSerial();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context) ? topNavigationBar(context, scaffoldKey, 'Notifications') : null,
        drawer: const BigNav(currentPage: 'notification'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context) ? const BigNav(currentPage: 'notification') : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context) ? const SmallNav(currentPage: 'notification') : null,
              )),
            if (ResponsiveWidget.isSmallScreen(context)) Container(),
            Expanded(
                flex: ResponsiveWidget.isLargeScreen(context) ? 5 : 7,
                child: SingleChildScrollView(
                  child: Container(
                      margin: ResponsiveWidget.isLargeScreen(context)
                          ? const EdgeInsets.symmetric(vertical: 50, horizontal: 120)
                          : ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context)
                              ? const EdgeInsets.symmetric(vertical: 50, horizontal: 100)
                              : ResponsiveWidget.isSmallScreen(context)
                                  ? const EdgeInsets.symmetric(vertical: 20, horizontal: 20)
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
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.temperatureHalf,
                                          color: primary,
                                          size: 15,
                                        ),
                                        Text(
                                          "Healthy",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveWidget.isLargeScreen(context) ? 50 : 20),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: line,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.temperatureLow,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(context) ? 20 : 15,
                                        ),
                                        const Text(
                                          "Abnormal",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveWidget.isLargeScreen(context) ? 50 : 20),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: thirdly,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.temperatureHigh,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(context) ? 20 : 15,
                                        ),
                                        const Text(
                                          "Danger",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveWidget.isLargeScreen(context) ? 50 : 20),
                                Container(
                                  height: 40,
                                  width: 128,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: darkfacebook,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.batteryQuarter,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(context) ? 20 : 15,
                                        ),
                                        const Text(
                                          " Low Battery",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveWidget.isLargeScreen(context) ? 50 : 20),
                                Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: active,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.batteryEmpty,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(context) ? 20 : 15,
                                        ),
                                        const Text(
                                          "Power low",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
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
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.solidHeart,
                                          color: primary,
                                          size: 15,
                                        ),
                                        Text(
                                          "Healthy",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveWidget.isLargeScreen(context) ? 50 : 20),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: line,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.solidHeart,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(context) ? 20 : 15,
                                        ),
                                        const Text(
                                          "Abnormal",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveWidget.isLargeScreen(context) ? 50 : 20),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: thirdly,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.solidHeart,
                                          color: primary,
                                          size: ResponsiveWidget.isLargeScreen(context) ? 20 : 15,
                                        ),
                                        const Text(
                                          "Danger",
                                          style: TextStyle(color: primary, fontWeight: FontWeight.w600),
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
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.temperatureHalf,
                                    color: green,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: ' healthy', style: TextStyle(color: green, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your pet  temperature is in an excellent condition. Its temperature is between 38-39.8'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: green,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: '  healthy', style: TextStyle(color: green, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your pet heart rate is in an excellent condition. Its heart rate is between 140-220'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.temperatureLow,
                                    color: line,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: '  abnormal', style: TextStyle(color: line, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your pet is not well and we recommend you to check our health tips for some guidelines. Its temperature is below 38'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: line,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: '  abnormal', style: TextStyle(color: line, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your pet  heart rate is not good and we recommend you to check our health tips for some guidelines. Its heart rate is below 140'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.temperatureHigh,
                                    color: red,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: '  danger', style: TextStyle(color: red, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your pet is in a bad condition so it is recommended to see a veterinarian. It temperature is above 40. Navigate to Map of Veterinarian to see which one is around '),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: red,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: '  danger', style: TextStyle(color: red, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your pet is in a bad condition so it is recommended to see a veterinarian. It heart rate is above 220. Navigate to Map of Veterinarian to see which one is around '),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.batteryQuarter,
                                    color: darkfacebook,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: '  low battery', style: TextStyle(color: darkfacebook, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your hardware device is currently low. We recommend you to charge it. The battery percentage is below 10'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.w500, color: tab),
                              text: '* The ',
                              children: <InlineSpan>[
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.batteryEmpty,
                                    color: active,
                                    size: 15,
                                  ),
                                ),
                                TextSpan(text: '  power low', style: TextStyle(color: active, fontWeight: FontWeight.w700)),
                                TextSpan(text: ' sign indicates that your hardware is about to go off due to power shortage. The battery percentage is below 2. We highly recommend you to charge it'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          StreamBuilder(
                            stream: temp,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: secondary,
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                return StreamBuilder(
                                  stream: collar,
                                  builder: (context, snapshots) {
                                    if (snapshots.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        color: secondary,
                                      ));
                                    }

                                    return StreamBuilder(
                                      stream: heart,
                                      builder: (context, snap) {
                                        if (snap.connectionState == ConnectionState.waiting) {
                                          return const Center(
                                              child: CircularProgressIndicator(
                                            color: secondary,
                                          ));
                                        }
                                        var temp = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && item['deleted'] == false).map((item) {
                                          var level = item['temperature'];

                                          String tempLevel;
                                          if (level < 38) {
                                            tempLevel = 'Abnormal';
                                          } else if (level >= 40) {
                                            tempLevel = 'Danger';
                                          } else {
                                            tempLevel = 'Healthy';
                                          }
                                          var formattedTime = DateFormat.yMMMMd().add_jm().format(item['time'].toDate());
                                          return {"temp": tempLevel, "time": formattedTime, "serial": item['serial_number'], "deleted": item['deleted'], "id": item.id};
                                        }).toList();

                                        var collar = snapshots.data!.docs.where((item) => serialNumber.contains(item['serial_number'])).map((item) {
                                          var formattedTime = DateFormat.yMMMMd().add_jm().format(item['time'].toDate());
                                          return {'level': item['level'], 'time': formattedTime, 'serial': item['serial_number'], "id": item.id};
                                        }).toList();

                                        var heart = snap.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && item['deleted'] == false).map((item) {
                                          var rate = item['heart_rate'];

                                          String heartLevel;
                                          if (rate < 220) {
                                            heartLevel = 'Abnormal';
                                          } else if (rate >= 140) {
                                            heartLevel = 'Danger';
                                          } else {
                                            heartLevel = 'Healthy';
                                          }
                                          var formattedTime = DateFormat.yMMMMd().add_jm().format(item['time'].toDate());
                                          return {"heart": heartLevel, "time": formattedTime, "serial": item['serial_number'], "deleted": item['deleted'], "id": item.id};
                                        }).toList();

                                        var collar_level = collar.where((item) {
                                          return item['level'] == "low" || item['level'] == "off";
                                        }).toList();
                                        var all = [...temp, ...heart, ...collar_level];
                                        all.sort((a, b) => b['time'].compareTo(a['time']));

                                        return Column(
                                          children: all.map((info) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                                              margin: const EdgeInsets.only(bottom: 10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: primary, boxShadow: [
                                                const BoxShadow(
                                                  color: active,
                                                  offset: Offset(
                                                    1.0,
                                                    1.0,
                                                  ),
                                                  blurRadius: 4.0,
                                                ),
                                              ]),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return StatefulBuilder(
                                                                builder: (context, setDialogState) {
                                                                  return AlertDialog(
                                                                    backgroundColor: Colors.white,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(5.0),
                                                                    ),
                                                                    content: Container(
                                                                      height: !ResponsiveWidget.isSmallScreen(context) ? 150 : 170,
                                                                      width: 400,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text("Delete Notification",
                                                                                  style: TextStyle(
                                                                                    fontSize: !ResponsiveWidget.isSmallScreen(context) ? 22 : 16,
                                                                                  )),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  context.pop();
                                                                                },
                                                                                child: const Icon(
                                                                                  Icons.close,
                                                                                  size: 30,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(height: 20),
                                                                          const Text(
                                                                            "Are you sure you want to delete this notification",
                                                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                                                          ),
                                                                          const SizedBox(height: 20),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  context.pop();
                                                                                },
                                                                                child: Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: !ResponsiveWidget.isSmallScreen(context) ? 25 : 15, vertical: 10),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: secondary),
                                                                                  child: const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Icon(Icons.block, color: primary, size: 15),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        "Cancel",
                                                                                        style: TextStyle(color: primary),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              MouseRegion(
                                                                                cursor: SystemMouseCursors.click,
                                                                                child: GestureDetector(
                                                                                  onTap: () async {
                                                                                    setDialogState(() {
                                                                                      loading = true;
                                                                                    });
                                                                                    if (info['level'] == "low" || info['level'] == "off") {
                                                                                      await FirebaseFirestore.instance.collection("collar_battery").doc(info['id']).update(
                                                                                        {"deleted": true},
                                                                                      );
                                                                                    } else {
                                                                                      await FirebaseFirestore.instance.collection("temperature_reading").doc(info['id']).update(
                                                                                        {"deleted": true},
                                                                                      );
                                                                                    }

                                                                                    setDialogState(() {
                                                                                      loading = false;
                                                                                    });

                                                                                    context.pop();
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: const Text("Notification successfully deleted",
                                                                                            style: TextStyle(
                                                                                              fontSize: 14,
                                                                                              color: notification,
                                                                                              fontWeight: FontWeight.w400,
                                                                                            )),
                                                                                        backgroundColor: snackbar,
                                                                                        behavior: SnackBarBehavior.floating,
                                                                                        margin: EdgeInsets.only(
                                                                                          bottom: MediaQuery.of(context).size.height - 100,
                                                                                          left: !ResponsiveWidget.isSmallScreen(context) ? 300 : 30,
                                                                                          right: !ResponsiveWidget.isSmallScreen(context) ? 300 : 30,
                                                                                        ),
                                                                                        action: SnackBarAction(
                                                                                          label: 'X',
                                                                                          textColor: secondary,
                                                                                          onPressed: () {
                                                                                            // Some code to undo the change.
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                       padding: EdgeInsets.symmetric(horizontal: !ResponsiveWidget.isSmallScreen(context) ? 25 : 15, vertical: 10),
                                                                                      decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(8)),
                                                                                      child: (loading == true)
                                                                                          ? const Row(
                                                                                              children: [
                                                                                                Text(
                                                                                                  "Please wait...",
                                                                                                  style: TextStyle(color: primary),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 20,
                                                                                                  height: 20,
                                                                                                  child: CircularProgressIndicator(
                                                                                                    color: primary,
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            )
                                                                                          : const Center(
                                                                                              child: Text(
                                                                                                "Remove",
                                                                                                style: TextStyle(color: primary),
                                                                                              ),
                                                                                            )),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(4),
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
                                                      height: ResponsiveWidget.isSmallScreen(context) ? 170 : 100,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          !ResponsiveWidget.isSmallScreen(context)
                                                              ? Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      height: 35,
                                                                      width: info['level'] == 'low' ? 128 : 110,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        color: info['level'] == 'low'
                                                                            ? darkfacebook
                                                                            : info['level'] == 'off'
                                                                                ? active
                                                                                : info['temp'] == "Danger" || info['heart'] == "Danger"
                                                                                    ? red
                                                                                    : info['temp'] == "Abnormal" || info['heart'] == "Abnormal"
                                                                                        ? line
                                                                                        : info['temp'] == "Healthy" || info['heart'] == "Healthy"
                                                                                            ? green
                                                                                            : null,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Icon(
                                                                              info['level'] == "low" || info['level'] == 'off'
                                                                                  ? FontAwesomeIcons.batteryQuarter
                                                                                  : info['temp'] == "Danger"
                                                                                      ? FontAwesomeIcons.temperatureHigh
                                                                                      : info['temp'] == "Abnormal"
                                                                                          ? FontAwesomeIcons.temperatureLow
                                                                                          : info['temp'] == "Healthy"
                                                                                              ? FontAwesomeIcons.temperatureHalf
                                                                                              : FontAwesomeIcons.solidHeart,
                                                                              color: primary,
                                                                              size: 15,
                                                                            ),
                                                                            Text(
                                                                              info['level'] == 'low'
                                                                                  ? 'Low Battery'
                                                                                  : info['level'] == 'off'
                                                                                      ? 'Power low'
                                                                                      : info['temp'] ?? info['heart'],
                                                                              style: const TextStyle(color: primary, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        const Icon(FontAwesomeIcons.clock, color: secondary, size: 15),
                                                                        const SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Text(info['time'])
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )
                                                              : Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Container(
                                                                      height: 35,
                                                                      width: info['level'] == 'low' ? 128 : 110,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        color: info['level'] == 'low'
                                                                            ? darkfacebook
                                                                            : info['level'] == 'off'
                                                                                ? active
                                                                                : info['temp'] == "Danger" || info['heart'] == "Danger"
                                                                                    ? red
                                                                                    : info['temp'] == "Abnormal" || info['heart'] == "Abnormal"
                                                                                        ? line
                                                                                        : info['temp'] == "Healthy" || info['heart'] == "Healthy"
                                                                                            ? green
                                                                                            : null,
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Icon(
                                                                              info['level'] == "low" || info['level'] == 'off'
                                                                                  ? FontAwesomeIcons.batteryQuarter
                                                                                  : info['temp'] == "Danger"
                                                                                      ? FontAwesomeIcons.temperatureHigh
                                                                                      : info['temp'] == "Abnormal"
                                                                                          ? FontAwesomeIcons.temperatureLow
                                                                                          : info['temp'] == "Healthy"
                                                                                              ? FontAwesomeIcons.temperatureHalf
                                                                                              : FontAwesomeIcons.solidHeart,
                                                                              color: primary,
                                                                              size: 15,
                                                                            ),
                                                                            Text(
                                                                              info['level'] == 'low'
                                                                                  ? 'Low Battery'
                                                                                  : info['level'] == 'off'
                                                                                      ? 'Power low'
                                                                                      : info['temp'] ?? info['heart'],
                                                                              style: const TextStyle(color: primary, fontWeight: FontWeight.w600),
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
                                                                        const Icon(FontAwesomeIcons.clock, color: secondary, size: 15),
                                                                        const SizedBox(
                                                                          width: 10,
                                                                        ),
                                                                        Container(
                                                                          constraints: const BoxConstraints(maxWidth: 140),
                                                                          child: Text(
                                                                            maxLines: 2,
                                                                            info['time'],
                                                                            style: const TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            info['level'] == "low" || info['level'] == 'off' ? "Device Message" : "Pet message",
                                                            style: const TextStyle(fontWeight: FontWeight.w700),
                                                          ),
                                                          Text(info['level'] == 'low'
                                                              ? "Your monitoring device is low kindly charge it or replace the battery. It is 10%"
                                                              : info['level'] == 'off'
                                                                  ? "Your device going off kindly charge it or replace the battery. It is 2%"
                                                                  : info['temp'] == "Danger"
                                                                      ? "Your pet temperature is unhealthy and requires mediate attention"
                                                                      : info['temp'] == "Abnormal"
                                                                          ? "Your pet's temperature is abnormal and it recommend you to check out health tips"
                                                                          : info['temp'] == "Healthy"
                                                                              ? "Your pet temperature is healthy and it is in an excellent condition"
                                                                              : info['heart'] == "Healthy"
                                                                                  ? "Your pet's heart rate is healthy and it is in an excellent condition"
                                                                                  : info['heart'] == "Abnormal"
                                                                                      ? "Your pet's heart rate is abnormal and it recommend you to check out health tips"
                                                                                      : info['heart'] == "Danger"
                                                                                          ? "Your pet's heart rate is unhealthy and requires mediate attention"
                                                                                          : "")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    "No Data Sent",
                                    style: TextStyle(color: secondary, fontWeight: FontWeight.w500),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      )),
                )),
          ],
        ));
  }
}
