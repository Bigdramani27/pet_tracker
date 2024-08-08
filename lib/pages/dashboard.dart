import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.date, this.sales);

  final String date;
  final double sales;
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late final TabController _tabController;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  late Stream<QuerySnapshot<Map<String, dynamic>>> temp;
  late Stream<QuerySnapshot<Map<String, dynamic>>> heart;
  late Stream<QuerySnapshot<Map<String, dynamic>>> activity;
  late Stream<QuerySnapshot<Map<String, dynamic>>> variability;
  String petType = "";

  Future<void> fetchSerial() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("pet_table").where("serial_number", isEqualTo: "kelpetNumber1").get();

      if (snapshot.docs.length == 1) {
        var doc = snapshot.docs[0];
        var userData = doc.data();
        petType = userData['type'];
      } else {
        petType = "";
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSerial();
    _initializeData();
    _tabController = TabController(length: 4, vsync: this);
    temp = FirebaseFirestore.instance.collection("temperature_reading").orderBy("time", descending: false).snapshots();
    heart = FirebaseFirestore.instance.collection("heart_rate").orderBy("time", descending: false).snapshots();
    activity = FirebaseFirestore.instance.collection("activity_level").orderBy("time", descending: false).snapshots();
    variability = FirebaseFirestore.instance.collection("heart_variability").orderBy("time", descending: false).snapshots();
  }

  void _initializeData() async {
    await getSerial();
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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

  final List<SalesData> chartData = [SalesData('Aug 27', 20), SalesData('Aug 28', 28), SalesData('Aug 29', 18), SalesData('Aug 30', 25), SalesData('Aug 31', 30), SalesData('Sep 1', 26), SalesData('Sep 2', 26)];

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context) ? topNavigationBar(context, scaffoldKey, 'Dashboard') : null,
        drawer: const BigNav(currentPage: 'dashboard'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context) ? const BigNav(currentPage: 'dashboard') : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context) ? const SmallNav(currentPage: 'dashboard') : null,
              )),
            Expanded(
                flex: ResponsiveWidget.isLargeScreen(context) ? 5 : 7,
                child: SingleChildScrollView(
                  child: Container(
                    margin: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context)
                        ? const EdgeInsets.symmetric(horizontal: 120, vertical: 50)
                        : ResponsiveWidget.isMediumScreen(context)
                            ? const EdgeInsets.symmetric(horizontal: 60, vertical: 30)
                            : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context)
                            ? const Text('Dashboard',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ))
                            : SizedBox(),
                        ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? const SizedBox(height: 20) : SizedBox(),
                        const Divider(),
                        ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? const SizedBox(height: 10) : SizedBox(),
                        ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context)
                            ? Row(
                                children: [
                                  Expanded(
                                    child: TabBar(
                                      isScrollable: false,
                                      indicatorPadding: ResponsiveWidget.isLargeScreen(context)
                                          ? const EdgeInsets.only(
                                              right: 50,
                                              top: 5,
                                              bottom: 5,
                                            )
                                          : ResponsiveWidget.isCustomSize(context)
                                              ? const EdgeInsets.only(right: 10, top: 5, bottom: 5)
                                              : ResponsiveWidget.isMediumScreen(context)
                                                  ? const EdgeInsets.only(top: 5, bottom: 5)
                                                  : EdgeInsets.zero,
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: activeTab,
                                      ),
                                      controller: _tabController,
                                      labelColor: tab,
                                      tabs: [
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.thermometerHalf,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Temperature',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.waveSquare,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Heart Rate',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.bolt,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Activity Level',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.heart,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Heart Variability',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    TabBar(
                                      isScrollable: true,
                                      indicatorPadding: const EdgeInsets.only(right: 1, top: 5, bottom: 5),
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: activeTab,
                                      ),
                                      controller: _tabController,
                                      labelColor: tab,
                                      tabs: [
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.thermometerHalf,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Temperature',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.waveSquare,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Heart Rate',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.bolt,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Activity Level',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Tab(
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.heart,
                                                size: 16,
                                                color: secondary,
                                              ),
                                              const SizedBox(width: 5),
                                              Text('Heart Rate Variability',
                                                  style: TextStyle(
                                                    color: secondary,
                                                    fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        const Divider(),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                                height: 500,
                                padding: EdgeInsets.symmetric(vertical: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 22 : 10, horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 35 : 15),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: primary, boxShadow: [
                                  const BoxShadow(
                                    color: active,
                                    offset: Offset(
                                      1.0,
                                      1.0,
                                    ),
                                    blurRadius: 10.0,
                                  ),
                                ]),
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Temperature Overview',
                                            style: TextStyle(
                                              fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 20 : 17,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        const SizedBox(
                                          height: 30,
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

                                              var now = DateTime.now();
                                              var today = DateTime(now.year, now.month, now.day); // Today's date without time
                                              var yesterday = today.subtract(const Duration(days: 1)); // Yesterday's date without time

                                              bool isSameDay(Timestamp timestamp, DateTime day) {
                                                var itemDate = (timestamp as Timestamp).toDate();
                                                return itemDate.year == day.year && itemDate.month == day.month && itemDate.day == day.day;
                                              }

                                              double calculateAverageTemperature(List data) {
                                                if (data.isEmpty) return 0.0;
                                                double sum = data.map((item) => item['temperature']).fold(0, (prev, temp) => prev + temp);
                                                return sum / data.length;
                                              }

                                              var todayData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && isSameDay(item['time'], today)).toList();

                                              var yesterdayData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && isSameDay(item['time'], yesterday)).toList();

                                              var overallData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number'])).toList();
                                              var averageTemperatureToday = calculateAverageTemperature(todayData);
                                              var averageTemperatureYesterday = calculateAverageTemperature(yesterdayData);
                                              averageTemperatureToday = double.parse(averageTemperatureToday.toStringAsFixed(2));
                                              averageTemperatureYesterday = double.parse(averageTemperatureYesterday.toStringAsFixed(2));
                                              double averageTemperatureOverall = calculateAverageTemperature(overallData);
                                              averageTemperatureOverall = double.parse(averageTemperatureOverall.toStringAsFixed(2));
                                              String tempLevel;

                                              if (petType == "Dog") {
                                                if (averageTemperatureOverall >= 38.3 && averageTemperatureOverall <= 39.2) {
                                                  tempLevel = 'Healthy';
                                                } else if (averageTemperatureOverall < 39.3) {
                                                  tempLevel = 'Abnormal';
                                                } else {
                                                  tempLevel = 'Danger';
                                                }
                                              } else if (petType == "Cat") {
                                                if (averageTemperatureOverall >= 38.1 && averageTemperatureOverall <= 39.2) {
                                                  tempLevel = 'Healthy';
                                                } else if (averageTemperatureOverall < 39.3) {
                                                  tempLevel = 'Abnormal';
                                                } else {
                                                  tempLevel = 'Danger';
                                                }
                                              } else {
                                                tempLevel = "";
                                              }

                                              List<SalesData> chartTemp = [];
                                              Map<String, List<double>> dailyAverages = {};

                                              overallData.forEach((item) {
                                                DateTime itemDate = (item['time'] as Timestamp).toDate();
                                                String formattedDate = '${_getMonthAbbreviation(itemDate.month)} ${itemDate.day}'; // Format like 'Aug 24'

                                                if (!dailyAverages.containsKey(formattedDate)) {
                                                  dailyAverages[formattedDate] = [];
                                                }

                                                dailyAverages[formattedDate]!.add(item['temperature'].toDouble());
                                              });

                                              dailyAverages.forEach((date, tempRates) {
                                                double averageTempRate = tempRates.isNotEmpty ? tempRates.reduce((a, b) => a + b) / tempRates.length : 0.0;
                                                chartTemp.add(SalesData(date, averageTempRate));
                                              });

                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureYesterday deg',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Yesterday",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureToday deg',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text('Today',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureOverall deg',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Overall",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(height: 40),
                                                      ],
                                                    ),
                                                  ),
                                                  ResponsiveWidget.isMediumScreen(context) ? const SizedBox(height: 10) : const SizedBox(height: 0),
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 50),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('Daily',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w700,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 200,
                                                        padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                        child: SfCartesianChart(primaryXAxis: CategoryAxis(), series: <ChartSeries>[
                                                          // Renders line chart
                                                          LineSeries<SalesData, String>(dataSource: chartTemp, xValueMapper: (SalesData sales, _) => sales.date, color: line, yValueMapper: (SalesData sales, _) => sales.sales)
                                                        ]),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(left: 80),
                                                            height: 10,
                                                            width: 20,
                                                            color: tempLevel == "Healthy"
                                                                ? green
                                                                : tempLevel == "Abnormal"
                                                                    ? line
                                                                    : tempLevel == "Danger"
                                                                        ? red
                                                                        : null,
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Text(tempLevel),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Heart Rate Overview',
                                            style: TextStyle(
                                              fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 20 : 17,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        StreamBuilder(
                                            stream: heart,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return const Center(
                                                  child: CircularProgressIndicator(
                                                    color: secondary,
                                                  ),
                                                );
                                              }

                                              var now = DateTime.now();
                                              var today = DateTime(now.year, now.month, now.day); // Today's date without time
                                              var yesterday = today.subtract(const Duration(days: 1)); // Yesterday's date without time

                                              bool isSameDay(Timestamp timestamp, DateTime day) {
                                                var itemDate = (timestamp as Timestamp).toDate();
                                                return itemDate.year == day.year && itemDate.month == day.month && itemDate.day == day.day;
                                              }

                                              double calculateAverageTemperature(List data) {
                                                if (data.isEmpty) return 0.0;
                                                double sum = data.map((item) => item['heart_rate']).fold(0, (prev, temp) => prev + temp);
                                                return sum / data.length;
                                              }

                                              var todayData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && isSameDay(item['time'], today)).toList();

                                              var yesterdayData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && isSameDay(item['time'], yesterday)).toList();

                                              var overallData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number'])).toList();
                                              var averageTemperatureToday = calculateAverageTemperature(todayData);
                                              var averageTemperatureYesterday = calculateAverageTemperature(yesterdayData);
                                              averageTemperatureToday = double.parse(averageTemperatureToday.toStringAsFixed(2));
                                              averageTemperatureYesterday = double.parse(averageTemperatureYesterday.toStringAsFixed(2));
                                              double averageTemperatureOverall = calculateAverageTemperature(overallData);
                                              averageTemperatureOverall = double.parse(averageTemperatureOverall.toStringAsFixed(2));
                                              String heartLevel;

                                              if (petType == "Dog") {
                                                if (averageTemperatureOverall < 120) {
                                                  heartLevel = 'Abnormal';
                                                } else if (averageTemperatureOverall >= 180) {
                                                  heartLevel = 'Danger';
                                                } else {
                                                  heartLevel = 'Healthy';
                                                }
                                              } else if (petType == "Cat") {
                                                if (averageTemperatureOverall < 140) {
                                                  heartLevel = 'Abnormal';
                                                } else if (averageTemperatureOverall >= 220) {
                                                  heartLevel = 'Danger';
                                                } else {
                                                  heartLevel = 'Healthy';
                                                }
                                              } else {
                                                heartLevel = "";
                                              }

                                              List<SalesData> chartHeart = [];
                                              Map<String, List<double>> dailyAverages = {};

                                              overallData.forEach((item) {
                                                DateTime itemDate = (item['time'] as Timestamp).toDate();
                                                String formattedDate = '${_getMonthAbbreviation(itemDate.month)} ${itemDate.day}';

                                                if (!dailyAverages.containsKey(formattedDate)) {
                                                  dailyAverages[formattedDate] = [];
                                                }

                                                dailyAverages[formattedDate]!.add(item['heart_rate'].toDouble());
                                              });

                                              dailyAverages.forEach((date, heartRates) {
                                                double averageHeartRate = heartRates.isNotEmpty ? heartRates.reduce((a, b) => a + b) / heartRates.length : 0.0;
                                                chartHeart.add(SalesData(date, averageHeartRate));
                                              });
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureYesterday bpm',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Yesterday",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureToday bpm',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text('Today',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureOverall bpm',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Overall",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(height: 40),
                                                      ],
                                                    ),
                                                  ),
                                                  ResponsiveWidget.isMediumScreen(context) ? const SizedBox(height: 10) : const SizedBox(height: 0),
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 50),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('Daily',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w700,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 200,
                                                        padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                        child: SfCartesianChart(primaryXAxis: CategoryAxis(), series: <ChartSeries>[
                                                          // Renders line chart
                                                          LineSeries<SalesData, String>(dataSource: chartHeart, xValueMapper: (SalesData sales, _) => sales.date, color: line, yValueMapper: (SalesData sales, _) => sales.sales)
                                                        ]),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(left: 80),
                                                            height: 10,
                                                            width: 20,
                                                            color: heartLevel == "Healthy"
                                                                ? green
                                                                : heartLevel == "Abnormal"
                                                                    ? line
                                                                    : heartLevel == "Danger"
                                                                        ? red
                                                                        : null,
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Text(heartLevel),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Activity Level Overview',
                                            style: TextStyle(
                                              fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 20 : 17,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        StreamBuilder(
                                            stream: activity,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return const Center(
                                                  child: CircularProgressIndicator(
                                                    color: secondary,
                                                  ),
                                                );
                                              }

                                              var now = DateTime.now();
                                              var today = DateTime(now.year, now.month, now.day);
                                              var yesterday = today.subtract(Duration(days: 1));

                                              bool isSameDay(Timestamp timestamp, DateTime day) {
                                                var itemDate = (timestamp as Timestamp).toDate();
                                                return itemDate.year == day.year && itemDate.month == day.month && itemDate.day == day.day;
                                              }

                                              List<Map<String, dynamic>> activity = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number'])).map((item) {
                                                double x = item['activity_x'] as double;
                                                double y = item['activity_y'] as double;
                                                double z = item['activity_z'] as double;

                                                // Calculate magnitude
                                                double magnitude = sqrt(x * x + y * y + z * z);
                                                String formattedMagnitude = magnitude.toStringAsFixed(2);

                                                return {
                                                  "x": x,
                                                  "y": y,
                                                  "z": z,
                                                  "time": item['time'],
                                                  "magnitude": double.parse(formattedMagnitude),
                                                };
                                              }).toList();

                                              List<Map<String, dynamic>> todayData = activity.where((item) => isSameDay(item['time'], today)).toList();
                                              List<Map<String, dynamic>> yesterdayData = activity.where((item) => isSameDay(item['time'], yesterday)).toList();

                                              List<Map<String, dynamic>> overallData = activity;

                                              double calculateAverageMagnitude(List<Map<String, dynamic>> data) {
                                                if (data.isEmpty) return 0.0;
                                                double sum = data.map((item) => item['magnitude']).reduce((value, element) => value + element);
                                                return sum / data.length;
                                              }

                                              double averageMagnitudeToday = calculateAverageMagnitude(todayData);
                                              double averageMagnitudeYesterday = calculateAverageMagnitude(yesterdayData);
                                              averageMagnitudeToday = double.parse(averageMagnitudeToday.toStringAsFixed(2));
                                              averageMagnitudeYesterday = double.parse(averageMagnitudeYesterday.toStringAsFixed(2));
                                              double averageMagnitudeOverall = calculateAverageMagnitude(overallData);

                                              averageMagnitudeOverall = double.parse(averageMagnitudeOverall.toStringAsFixed(2));

                                              String activityLevel;

                                              if (averageMagnitudeOverall >= 0.5 && averageMagnitudeOverall < 1.5) {
                                                activityLevel = 'Mini-Active';
                                              } else if (averageMagnitudeOverall >= 0 && averageMagnitudeOverall < 0.5) {
                                                activityLevel = 'Inactive';
                                              } else if (averageMagnitudeOverall >= 1.5) {
                                                activityLevel = 'Active';
                                              } else {
                                                activityLevel = '';
                                              }

                                              List<SalesData> chartActivity = [];
                                              Map<String, List<double>> dailyAverages = {};

                                              activity.forEach((item) {
                                                DateTime itemDate = (item['time'] as Timestamp).toDate();
                                                String formattedDate = '${_getMonthAbbreviation(itemDate.month)} ${itemDate.day}';

                                                if (!dailyAverages.containsKey(formattedDate)) {
                                                  dailyAverages[formattedDate] = [];
                                                }

                                                dailyAverages[formattedDate]!.add(item['magnitude']);
                                              });

                                              dailyAverages.forEach((date, magnitudes) {
                                                double averageMagnitude = magnitudes.isNotEmpty ? magnitudes.reduce((a, b) => a + b) / magnitudes.length : 0.0;
                                                chartActivity.add(SalesData(date, averageMagnitude));
                                              });

                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageMagnitudeYesterday mag',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Yesterday",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageMagnitudeToday mag',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text('Today',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageMagnitudeOverall mag',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Overall",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(height: 40),
                                                      ],
                                                    ),
                                                  ),
                                                  ResponsiveWidget.isMediumScreen(context) ? const SizedBox(height: 10) : const SizedBox(height: 0),
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 50),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('Daily',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w700,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 200,
                                                        padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                        child: SfCartesianChart(primaryXAxis: CategoryAxis(), series: <ChartSeries>[
                                                          // Renders line chart
                                                          LineSeries<SalesData, String>(dataSource: chartActivity, xValueMapper: (SalesData sales, _) => sales.date, color: line, yValueMapper: (SalesData sales, _) => sales.sales)
                                                        ]),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(left: 80),
                                                            height: 10,
                                                            width: 20,
                                                            color: activityLevel == "Active"
                                                                ? green
                                                                : activityLevel == "Mini-Active"
                                                                    ? line
                                                                    : activityLevel == "Inactive"
                                                                        ? red
                                                                        : null,
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Text(activityLevel),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Heart Rate Variability Overview',
                                            style: TextStyle(
                                              fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 20 : 17,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        StreamBuilder(
                                            stream: variability,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return const Center(
                                                  child: CircularProgressIndicator(
                                                    color: secondary,
                                                  ),
                                                );
                                              }

                                              var now = DateTime.now();
                                              var today = DateTime(now.year, now.month, now.day); // Today's date without time
                                              var yesterday = today.subtract(const Duration(days: 1)); // Yesterday's date without time

                                              bool isSameDay(Timestamp timestamp, DateTime day) {
                                                var itemDate = (timestamp as Timestamp).toDate();
                                                return itemDate.year == day.year && itemDate.month == day.month && itemDate.day == day.day;
                                              }

                                              double calculateAverageTemperature(List data) {
                                                if (data.isEmpty) return 0.0;
                                                double sum = data.map((item) => item['hrv']).fold(0, (prev, temp) => prev + temp);
                                                return sum / data.length;
                                              }

                                              var todayData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && isSameDay(item['time'], today)).toList();

                                              var yesterdayData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number']) && isSameDay(item['time'], yesterday)).toList();

                                              var overallData = snapshot.data!.docs.where((item) => serialNumber.contains(item['serial_number'])).toList();
                                              var averageTemperatureToday = calculateAverageTemperature(todayData);
                                              var averageTemperatureYesterday = calculateAverageTemperature(yesterdayData);
                                              averageTemperatureToday = double.parse(averageTemperatureToday.toStringAsFixed(2));
                                              averageTemperatureYesterday = double.parse(averageTemperatureYesterday.toStringAsFixed(2));
                                              double averageTemperatureOverall = calculateAverageTemperature(overallData);
                                              averageTemperatureOverall = double.parse(averageTemperatureOverall.toStringAsFixed(2));

                                              String hrvLevel;

                                              if (petType == "Dog") {
                                                if (averageTemperatureOverall < 60) {
                                                  hrvLevel = 'Abnormal';
                                                } else if (averageTemperatureOverall >= 140) {
                                                  hrvLevel = 'Danger';
                                                } else {
                                                  hrvLevel = 'Healthy';
                                                }
                                              } else if (petType == "Cat") {
                                                if (averageTemperatureOverall < 159) {
                                                  hrvLevel = 'Abnormal';
                                                } else if (averageTemperatureOverall >= 206) {
                                                  hrvLevel = 'Danger';
                                                } else {
                                                  hrvLevel = 'Healthy';
                                                }
                                              } else {
                                                hrvLevel = "";
                                              }

                                              List<SalesData> chartHeart = [];
                                              Map<String, List<double>> dailyAverages = {};

                                              overallData.forEach((item) {
                                                DateTime itemDate = (item['time'] as Timestamp).toDate();
                                                String formattedDate = '${_getMonthAbbreviation(itemDate.month)} ${itemDate.day}';

                                                if (!dailyAverages.containsKey(formattedDate)) {
                                                  dailyAverages[formattedDate] = [];
                                                }

                                                dailyAverages[formattedDate]!.add(item['hrv'].toDouble());
                                              });

                                              dailyAverages.forEach((date, heartRates) {
                                                double averageHeartRate = heartRates.isNotEmpty ? heartRates.reduce((a, b) => a + b) / heartRates.length : 0.0;
                                                chartHeart.add(SalesData(date, averageHeartRate));
                                              });
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureYesterday ms',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Yesterday",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureToday ms',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text('Today',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Text('$averageTemperatureOverall ms',
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 24 : 20,
                                                                        fontWeight: FontWeight.w700,
                                                                      )),
                                                                  Text("Overall",
                                                                      style: TextStyle(
                                                                        fontSize: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 14 : 12,
                                                                      ))
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(height: 40),
                                                      ],
                                                    ),
                                                  ),
                                                  ResponsiveWidget.isMediumScreen(context) ? const SizedBox(height: 10) : const SizedBox(height: 0),
                                                  Container(
                                                    padding: const EdgeInsets.only(right: 50),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text('Daily',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w700,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 200,
                                                        padding: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isCustomSize(context) ? 40 : 0),
                                                        child: SfCartesianChart(primaryXAxis: CategoryAxis(), series: <ChartSeries>[
                                                          // Renders line chart
                                                          LineSeries<SalesData, String>(dataSource: chartHeart, xValueMapper: (SalesData sales, _) => sales.date, color: line, yValueMapper: (SalesData sales, _) => sales.sales)
                                                        ]),
                                                      ),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(left: 80),
                                                            height: 10,
                                                            width: 20,
                                                            color: hrvLevel == "Healthy"
                                                                ? green
                                                                : hrvLevel == "Abnormal"
                                                                    ? line
                                                                    : hrvLevel == "Danger"
                                                                        ? red
                                                                        : null,
                                                          ),
                                                          const SizedBox(width: 5),
                                                          Text(hrvLevel),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }

  // Helper function to get month abbreviation
  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
