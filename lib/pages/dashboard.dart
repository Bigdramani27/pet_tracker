import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
  final List<SalesData> chartData = [
    SalesData('Aug 27', 20),
    SalesData('Aug 28', 28),
    SalesData('Aug 29', 18),
    SalesData('Aug 30', 25),
    SalesData('Aug 31', 30),
    SalesData('Sep 1', 26),
    SalesData('Sep 2', 26)
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? topNavigationBar(context, scaffoldKey, 'Dashboard')
            : null,
        drawer: const BigNav(currentPage: 'dashboard'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context)
                    ? const BigNav(currentPage: 'dashboard')
                    : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context)
                    ? const SmallNav(currentPage: 'dashboard')
                    : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context) ||
                ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isCustomSize(context))
              Expanded(
                  flex: ResponsiveWidget.isLargeScreen(context) ? 5 : 7,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: ResponsiveWidget.isLargeScreen(context) ||
                              ResponsiveWidget.isCustomSize(context)
                          ? const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 50)
                          : ResponsiveWidget.isMediumScreen(context)
                              ? const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 30)
                              : EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Dashboard',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TabBar(
                                  isScrollable: false,
                                  indicatorPadding:
                                      ResponsiveWidget.isLargeScreen(context)
                                          ? const EdgeInsets.only(
                                              right: 50,
                                              top: 5,
                                              bottom: 5,
                                            )
                                          : ResponsiveWidget.isCustomSize(
                                                  context)
                                              ? const EdgeInsets.only(
                                                  right: 10, top: 5, bottom: 5)
                                              : ResponsiveWidget.isMediumScreen(
                                                      context)
                                                  ? const EdgeInsets.only(
                                                      top: 5, bottom: 5)
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
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 14
                                                    : 13,
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
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 14
                                                    : 13,
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
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 14
                                                    : 13,
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
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 14
                                                    : 13,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Container(
                                  height: 500,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 22, horizontal: 35),
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
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Temperature Overview',
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 20
                                                    : 17,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('85',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Incoming',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('30',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Open',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('190',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Resolved',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
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
                                          ResponsiveWidget.isMediumScreen(
                                                  context)
                                              ? const SizedBox(height: 10)
                                              : const SizedBox(height: 0),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 50),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text('Daily',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Weekly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Monthly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                child: SfCartesianChart(
                                                    primaryXAxis:
                                                        CategoryAxis(),
                                                    series: <ChartSeries>[
                                                      // Renders line chart
                                                      LineSeries<SalesData,
                                                              String>(
                                                          dataSource: chartData,
                                                          xValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.date,
                                                          color: line,
                                                          yValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.sales)
                                                    ]),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    height: 10,
                                                    width: 20,
                                                    color: line,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text('resolved'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Heart Rate Overview',
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 20
                                                    : 17,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('85',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Incoming',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('30',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Open',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('190',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Resolved',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
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
                                          ResponsiveWidget.isMediumScreen(
                                                  context)
                                              ? const SizedBox(height: 10)
                                              : const SizedBox(height: 0),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 50),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text('Daily',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Weekly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Monthly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                child: SfCartesianChart(
                                                    primaryXAxis:
                                                        CategoryAxis(),
                                                    series: <ChartSeries>[
                                                      // Renders line chart
                                                      LineSeries<SalesData,
                                                              String>(
                                                          dataSource: chartData,
                                                          xValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.date,
                                                          color: line,
                                                          yValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.sales)
                                                    ]),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    height: 10,
                                                    width: 20,
                                                    color: line,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text('resolved'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Activity Level Overview',
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 20
                                                    : 17,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('85',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Incoming',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('30',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Open',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('190',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Resolved',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
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
                                          ResponsiveWidget.isMediumScreen(
                                                  context)
                                              ? const SizedBox(height: 10)
                                              : const SizedBox(height: 0),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 50),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text('Daily',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Weekly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Monthly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                child: SfCartesianChart(
                                                    primaryXAxis:
                                                        CategoryAxis(),
                                                    series: <ChartSeries>[
                                                      // Renders line chart
                                                      LineSeries<SalesData,
                                                              String>(
                                                          dataSource: chartData,
                                                          xValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.date,
                                                          color: line,
                                                          yValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.sales)
                                                    ]),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    height: 10,
                                                    width: 20,
                                                    color: line,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text('resolved'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Heart Rate Variability Overview',
                                              style: TextStyle(
                                                fontSize: ResponsiveWidget
                                                            .isLargeScreen(
                                                                context) ||
                                                        ResponsiveWidget
                                                            .isCustomSize(
                                                                context)
                                                    ? 20
                                                    : 17,
                                                fontWeight: FontWeight.w700,
                                              )),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('85',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Incoming',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('30',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Open',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text('190',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 24
                                                                    : 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          Text('Resolved',
                                                              style: TextStyle(
                                                                fontSize: ResponsiveWidget.isLargeScreen(
                                                                            context) ||
                                                                        ResponsiveWidget.isCustomSize(
                                                                            context)
                                                                    ? 14
                                                                    : 12,
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
                                          ResponsiveWidget.isMediumScreen(
                                                  context)
                                              ? const SizedBox(height: 10)
                                              : const SizedBox(height: 0),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 50),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text('Daily',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Weekly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                                SizedBox(width: 5),
                                                Text('Monthly',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                child: SfCartesianChart(
                                                    primaryXAxis:
                                                        CategoryAxis(),
                                                    series: <ChartSeries>[
                                                      // Renders line chart
                                                      LineSeries<SalesData,
                                                              String>(
                                                          dataSource: chartData,
                                                          xValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.date,
                                                          color: line,
                                                          yValueMapper:
                                                              (SalesData sales,
                                                                      _) =>
                                                                  sales.sales)
                                                    ]),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    height: 10,
                                                    width: 20,
                                                    color: line,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text('resolved'),
                                                ],
                                              ),
                                            ],
                                          ),
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
            if (ResponsiveWidget.isSmallScreen(context))
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Column(
                      children: [
                        const Divider(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              TabBar(
                                isScrollable: true,
                                indicatorPadding: const EdgeInsets.only(
                                    right: 1, top: 5, bottom: 5),
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
                                              fontSize: ResponsiveWidget
                                                          .isLargeScreen(
                                                              context) ||
                                                      ResponsiveWidget
                                                          .isCustomSize(context)
                                                  ? 14
                                                  : 13,
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
                                              fontSize: ResponsiveWidget
                                                          .isLargeScreen(
                                                              context) ||
                                                      ResponsiveWidget
                                                          .isCustomSize(context)
                                                  ? 14
                                                  : 13,
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
                                              fontSize: ResponsiveWidget
                                                          .isLargeScreen(
                                                              context) ||
                                                      ResponsiveWidget
                                                          .isCustomSize(context)
                                                  ? 14
                                                  : 13,
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
                                              fontSize: ResponsiveWidget
                                                          .isLargeScreen(
                                                              context) ||
                                                      ResponsiveWidget
                                                          .isCustomSize(context)
                                                  ? 14
                                                  : 13,
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
                        const SizedBox(height: 10),
                        Container(
                          height: 450,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                children: [
                                  Container(
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
                                    child: Column(children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 7),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Daily',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Weekly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Monthly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            series: <ChartSeries>[
                                              // Renders line chart
                                              LineSeries<SalesData, String>(
                                                  dataSource: chartData,
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.date,
                                                  color: line,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.sales)
                                            ]),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 10,
                                            width: 15,
                                            color: line,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('resolved'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  const Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('85',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Incoming',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('30',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Open',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('190',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Resolved',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ]),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
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
                                    child: Column(children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 7),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Daily',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Weekly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Monthly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            series: <ChartSeries>[
                                              // Renders line chart
                                              LineSeries<SalesData, String>(
                                                  dataSource: chartData,
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.date,
                                                  color: line,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.sales)
                                            ]),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 10,
                                            width: 15,
                                            color: line,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('resolved'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  const Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('85',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Incoming',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('30',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Open',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('190',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Resolved',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ]),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
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
                                    child: Column(children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 7),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Daily',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Weekly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Monthly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            series: <ChartSeries>[
                                              // Renders line chart
                                              LineSeries<SalesData, String>(
                                                  dataSource: chartData,
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.date,
                                                  color: line,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.sales)
                                            ]),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 10,
                                            width: 15,
                                            color: line,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('resolved'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  const Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('85',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Incoming',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('30',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Open',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('190',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Resolved',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ]),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
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
                                    child: Column(children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 7),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Daily',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Weekly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Monthly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            series: <ChartSeries>[
                                              // Renders line chart
                                              LineSeries<SalesData, String>(
                                                  dataSource: chartData,
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.date,
                                                  color: line,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.sales)
                                            ]),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 10,
                                            width: 15,
                                            color: line,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('resolved'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  const Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('85',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Incoming',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('30',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Open',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('190',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Resolved',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ]),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
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
                                    child: Column(children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 7),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Daily',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Weekly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            SizedBox(width: 5),
                                            Text('Monthly',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(),
                                            series: <ChartSeries>[
                                              // Renders line chart
                                              LineSeries<SalesData, String>(
                                                  dataSource: chartData,
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.date,
                                                  color: line,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.sales)
                                            ]),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 10,
                                            width: 15,
                                            color: line,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('resolved'),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  const Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('85',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Incoming',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('30',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Open',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text('190',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              Text('Resolved',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ))
          ],
        ));
  }
}
