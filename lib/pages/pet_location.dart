import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PetLocation extends StatefulWidget {
  const PetLocation({super.key});

  @override
  State<PetLocation> createState() => _PetLocationState();
}

class _PetLocationState extends State<PetLocation> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late GoogleMapController mapController;
  var user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? topNavigationBar(context, scaffoldKey, 'Pet Location')
            : null,
        drawer: const BigNav(currentPage: 'pet_location'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context)
                    ? const BigNav(currentPage: 'pet_location')
                    : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context)
                    ? const SmallNav(currentPage: 'pet_location')
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
                          const Text('Pet Location',
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
                            "Welcome to the Pet Location Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              text: 'This red ',
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\"Icon\"',
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                TextSpan(
                                    text:
                                        ' will tell you the location of your pet.',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("pet_table")
                                .snapshots(),
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: secondary,
                                  ),
                                );
                              }
                              var pets = snapshot.data!.docs.map((item) {
                                return {
                                  'name': item['name'],
                                  'long': item['long'],
                                  'lat': item['lat'],
                                  'user': item['user'],
                                  'id': item.id
                                };
                              }).toList();

                              var pet = pets.where((item) {
                                return item['user'] == user;
                              }).toList();

                              if (pet.isEmpty) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No Pet has been added yet",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              Set<Marker> all = {};
                              pet.forEach((item) {
                                all.add(Marker(
                                  markerId: MarkerId(item['id']),
                                  position: LatLng(item['long'], item['lat']),
                                  infoWindow: InfoWindow(title: item['name']),
                                ));
                              });
                              final initial = pet.first;
                              CameraPosition initialPosition = CameraPosition(
                                target: LatLng(
                                    initial['long'], initial['lat']),
                                zoom: 13,
                              );

                              return Container(
                                height: 500,
                                child: GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    mapController = controller;
                                  },
                                  initialCameraPosition: initialPosition,
                                  markers: all,
                                ),
                              );
                            }),
                          ),
                        ],
                      )),
                )),
          ],
        ));
  }
}
