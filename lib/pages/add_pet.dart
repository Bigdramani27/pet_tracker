import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelpet/widgets/form_dropdown.dart';

import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/colors.dart';

class AddNewPet extends StatefulWidget {
  const AddNewPet({super.key});

  @override
  State<AddNewPet> createState() => _AddNewPetState();
}

class _AddNewPetState extends State<AddNewPet> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final petNameController = TextEditingController();
  final petAgeController = TextEditingController();
  final petBreedController = TextEditingController();
  final petGenderController = TextEditingController();
  final petSerialController = TextEditingController();
  var position = ['Cat', 'Dog'];
  String selectedPosition = 'Cat';
  bool uploading = false;
  PlatformFile? pickedFile;
  var user = FirebaseAuth.instance.currentUser!.uid;
  final formKey = GlobalKey<FormState>();

  int number = 0;
  Future<bool> fetchNumber() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("pet_table").where("user", isEqualTo: user).get();

      // Count the number of documents in the snapshot
      number = snapshot.size;

      return true;
    } catch (error) {
      print("Error fetching number: $error");
      return false;
    }
  }

  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  List<String> serialNumber = [];
  Future<List<String>> getSerial() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("pet_table").get();
    List<String> rulers = [];
    snapshot.docs.forEach((doc) {
      rulers.add(doc['serial_number']);
    });
    serialNumber = rulers;
    return rulers;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNumber().then((success) {
      setState(() {});
    });
    getSerial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context) ? topNavigationBar(context, scaffoldKey, 'Add Pet') : null,
        drawer: const BigNav(currentPage: 'add_pet'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context) ? const BigNav(currentPage: 'add_pet') : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context) ? const SmallNav(currentPage: 'add_pet') : null,
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
                                ? const EdgeInsets.symmetric(vertical: 20, horizontal: 10)
                                : null,
                    height: 520,
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
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isLargeScreen(context))
                              Expanded(
                                  child: Container(
                                child: const Text(
                                  'Add new pet',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )),
                            if (ResponsiveWidget.isSmallScreen(context))
                              Expanded(
                                  child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Add new pet',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Container(
                                      child: const Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundColor: profile,
                                                child: FaIcon(FontAwesomeIcons.cat, color: secondary, size: 15),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                            Expanded(
                                flex: 7,
                                child: Container(
                                  child: Row(
                                    children: [
                                      if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isLargeScreen(context))
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                alignment: Alignment.bottomRight,
                                                children: [
                                                  CircleAvatar(
                                                    radius: ResponsiveWidget.isMediumScreen(context) ? 40 : 60,
                                                    backgroundColor: profile,
                                                    child: FaIcon(FontAwesomeIcons.cat, color: secondary, size: ResponsiveWidget.isMediumScreen(context) ? 40 : 50),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                      Expanded(
                                          flex: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context) ? 2 : 1,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Pet Name'),
                                                    TextFormField(
                                                      controller: petNameController,
                                                      validator: (text) {
                                                        if (text == null || text.isEmpty) {
                                                          return "Pet name is empty";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: const InputDecoration(
                                                        border: UnderlineInputBorder(),
                                                        hintText: 'Enter your pet name',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Pet Age'),
                                                    TextFormField(
                                                      controller: petAgeController,
                                                      validator: (text) {
                                                        if (text == null || text.isEmpty) {
                                                          return "Pet age is empty";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: const InputDecoration(
                                                        border: UnderlineInputBorder(),
                                                        hintText: 'Enter your pet age',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Pet Collar Serial Number'),
                                                    TextFormField(
                                                      controller: petSerialController,
                                                      validator: (text) {
                                                        if (text == null || text.isEmpty) {
                                                          return "Pet Collar is empty";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: const InputDecoration(
                                                        border: UnderlineInputBorder(),
                                                        hintText: 'Enter your pet collar serial number',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                      const SizedBox(width: 30),
                                      Expanded(
                                          flex: ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context) ? 2 : 1,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('Type of Breed'),
                                                      TextFormField(
                                                        controller: petBreedController,
                                                        validator: (text) {
                                                          if (text == null || text.isEmpty) {
                                                            return "Type of breed is empty";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration: const InputDecoration(
                                                          border: UnderlineInputBorder(),
                                                          hintText: 'Enter your pet breed',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('Pet Gender'),
                                                      TextFormField(
                                                        controller: petGenderController,
                                                        validator: (text) {
                                                          if (text == null || text.isEmpty) {
                                                            return "pet gender is empty";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        decoration: const InputDecoration(
                                                          border: UnderlineInputBorder(),
                                                          hintText: 'Enter your pet gender',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Type of Pet'),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    FormDropDown(
                                                      Icon: const Icon(FontAwesomeIcons.angleDown, size: 16, color: primary),
                                                      fontSize: 16,
                                                      dropColor: secondary,
                                                      value: selectedPosition,
                                                      items: position.map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(
                                                            items,
                                                            style: const TextStyle(color: primary),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      selectedItemBuilder: (BuildContext context) {
                                                        return position.map((String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child: Container(
                                                              padding: const EdgeInsets.only(left: 4),
                                                              child: Text(
                                                                items,
                                                                style: const TextStyle(color: primary),
                                                              ),
                                                            ),
                                                          );
                                                        }).toList();
                                                      },
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          selectedPosition = newValue.toString();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                )),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: secondary, padding: ResponsiveWidget.isSmallScreen(context) ? const EdgeInsets.symmetric(horizontal: 80, vertical: 20) : const EdgeInsets.symmetric(horizontal: 130, vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        if (number == 3) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text("You can only add 3 Pets",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: red,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              backgroundColor: spot_red,
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
                                          return;
                                        } else if (serialNumber.contains(petSerialController.text)) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text("Serial Number already Exists",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: red,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              backgroundColor: spot_red,
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
                                          return;
                                        } else {
                                          await FirebaseFirestore.instance.collection('pet_table').doc().set({
                                            'name': petNameController.text,
                                            'age': petAgeController.text,
                                            'breed': petBreedController.text,
                                            'gender': petGenderController.text,
                                            'type': selectedPosition,
                                            'date': FieldValue.serverTimestamp(),
                                            'user': user,
                                            'serial_number': petSerialController.text,
                                            'long': number == 0
                                                ? 5.760542060690686
                                                : number == 1
                                                    ? 5.76036767208318
                                                    : number >= 2
                                                        ? 5.760282274802908
                                                        : null,
                                            'lat': number == 0
                                                ? -0.21992320329155166
                                                : number == 1
                                                    ? -0.21964030686779001
                                                    : number >= 2
                                                        ? -0.22006946030168506
                                                        : null,
                                          }).then((_) {
                                            petNameController.clear();
                                            petAgeController.clear();
                                            petBreedController.clear();
                                            petSerialController.clear();
                                            pickedFile = null;
                                            petGenderController.clear();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: const Text("Pet Successfully Added. Go to Pet Update for details",
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
                                          });
                                        }
                                      }
                                    },
                                    child: (uploading == true)
                                        ? const Row(
                                            children: [
                                              Text(
                                                "Please Wait...",
                                                style: TextStyle(color: primary),
                                              ),
                                              SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: CircularProgressIndicator(
                                                    color: primary,
                                                  )),
                                            ],
                                          )
                                        : const Text(
                                            'Add new pet',
                                            style: TextStyle(color: primary),
                                          ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}
