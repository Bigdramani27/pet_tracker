import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kelpet/widgets/form_dropdown.dart';

import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ManagePets extends StatefulWidget {
  const ManagePets({super.key});

  @override
  State<ManagePets> createState() => _ManagePetsState();
}

class _ManagePetsState extends State<ManagePets> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var user = FirebaseAuth.instance.currentUser!.uid;
  final formKey = GlobalKey<FormState>();
  String formatDate(dateData) {
    var tempDate = DateFormat.yMMMd().add_jm().format(dateData.toDate());
    var limboDate = tempDate.split(' ');
    var date = "${limboDate[0]} ${limboDate[1]} ${limboDate[2]}";
    return date;
  }

  var position = ['Cat', 'Dog'];
  String selectedPosition = '';
  bool uploading = false;

  Future<Map<String, dynamic>> fetchPetData(String petId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('pet_table').doc(petId).get();

    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      throw Exception('Pet with ID $petId not found');
    }
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSerial();
  }

  Future<void> dataDisplay(StateSetter setDialogState, String petId, TextEditingController petAgeController, TextEditingController petNameController, TextEditingController petBreedController, TextEditingController petGenderController, String selectedPosition, TextEditingController petSerialController) async {
    await FirebaseFirestore.instance.collection('pet_table').doc(petId).update({
      'age': petAgeController.text,
      'name': petNameController.text,
      'breed': petBreedController.text,
      'serial_number': petSerialController.text,
      'gender': petGenderController.text,
      'type': selectedPosition,
    });
  }

  void dialogueShow(String petName, String petId) async {
    TextEditingController petNameController = TextEditingController();
    TextEditingController petAgeController = TextEditingController();
    TextEditingController petBreedController = TextEditingController();
    TextEditingController petGenderController = TextEditingController();
    TextEditingController petSerialController = TextEditingController();
    String selectedPosition = '';
    var petData = await fetchPetData(petId);
    petNameController.text = petData['name'];
    petAgeController.text = petData['age'];
    petBreedController.text = petData['breed'];
    petGenderController.text = petData['gender'];
    selectedPosition = petData['type'];
    petSerialController.text = petData['serial_number'];
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              content: Container(
                height: !ResponsiveWidget.isSmallScreen(context) ? 400 : 450,
                width: 600,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            !ResponsiveWidget.isSmallScreen(context)
                                ? Text(
                                    "Updating $petName",
                                    style: TextStyle(color: secondary, fontSize: !ResponsiveWidget.isSmallScreen(context) ? 22 : 16),
                                  )
                                : Container(
                                    constraints: BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      "Updating $petName",
                                      style: TextStyle(color: secondary, fontSize: 16, overflow: TextOverflow.ellipsis),
                                    )),
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(
                                Icons.close,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        !ResponsiveWidget.isSmallScreen(context)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
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
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
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
                                ],
                              )
                            : Column(
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
                                  SizedBox(
                                    height: 10,
                                  ),
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
                        const SizedBox(
                          height: 10,
                        ),
                        !ResponsiveWidget.isSmallScreen(context)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
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
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Pet Gender'),
                                        TextFormField(
                                          controller: petGenderController,
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return "Pet gender is empty";
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
                                ],
                              )
                            : Column(
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Text('Pet Gender'),
                                  TextFormField(
                                    controller: petGenderController,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return "Pet gender is empty";
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
                        const SizedBox(
                          height: 10,
                        ),
                        !ResponsiveWidget.isSmallScreen(context)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
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
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Pet Collar Serial Number'),
                                        TextFormField(
                                          controller: petSerialController,
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return "Pet Collar Serial Number is empty";
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
                                  ),
                                ],
                              )
                            : Column(
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
                        const SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                if (serialNumber.contains(petSerialController.text)) {
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
                                }
                                setDialogState(() {
                                  uploading = true;
                                });

                                await dataDisplay(setDialogState, petId, petAgeController, petNameController, petBreedController, petGenderController, selectedPosition, petSerialController);

                                setDialogState(() {
                                  uploading = false;
                                });
                                context.pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text("Pet Successfully Updated",
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
                              }
                            },
                            child: Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(color: secondary, borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: (uploading == true)
                                    ? const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                        "Update Pet",
                                        style: TextStyle(color: primary),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
      },
    );
  }

  Future<void> deletePet(StateSetter setDialogState,String petId) async {
    try {
      setDialogState(() {
        uploading = true;
      });
      await FirebaseFirestore.instance.collection('pet_table').doc(petId).delete();

      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Pet Successfully Deleted",
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
      setDialogState(() {
        uploading = false;
      });
    } catch (e) {
      print('Error deleting Pet: $e');
    }
  }

  void deletionPet(String petName, String petId) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              content: Container(
                width: 600,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Deleting ${petName}",
                              style: TextStyle(color: secondary, fontSize: !ResponsiveWidget.isSmallScreen(context) ? 22 : 16),
                            ),
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: const Icon(
                                Icons.close,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Are you sure you want to delete ${petName}? if you click yes you cannot undo it",
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
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
                        InkWell(
                          onTap: () async {
                            await deletePet(setDialogState, petId);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: !ResponsiveWidget.isSmallScreen(context) ? 25 : 15, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: thirdly),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(Icons.delete, color: primary, size: 15),
                                const SizedBox(
                                  width: 10,
                                ),
                                uploading == true
                                    ? const Row(
                                        children: [
                                          Text(
                                            "Please Wait...",
                                            style: TextStyle(color: primary),
                                          ),
                                          SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                                        ],
                                      )
                                    : const Text(
                                        "Yes Delete",
                                        style: TextStyle(color: primary),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context) ? topNavigationBar(context, scaffoldKey, 'Manage Pets') : null,
        drawer: const BigNav(currentPage: 'pet_update'),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context) ? const BigNav(currentPage: 'pet_update') : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context) ? const SmallNav(currentPage: 'pet_update') : null,
              )),
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
                        const Text('Manage Pets Update',
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
                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("pet_table").orderBy("date", descending: true).snapshots(),
                            builder: ((context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: secondary,
                                  ),
                                );
                              }
                              var pets = snapshot.data!.docs.map((item) {
                                return {
                                  'name': item['name'],
                                  'age': item['age'],
                                  'breed': item['breed'],
                                  'gender': item['gender'],
                                  'type': item['type'],
                                  'date': item['date'],
                                  'user': item['user'],
                                  'serial_number': item['serial_number'],
                                  'id': item.id,
                                };
                              }).toList();
                              var pet = pets.where((item) {
                                return item['user'] == user;
                              }).toList();

                              if (pets.isEmpty) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height - 200,
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "No Pet has been added yet",
                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                        ),
                                      ],
                                    ));
                              }

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: [
                                    DataTable(
                                        headingRowColor: MaterialStateColor.resolveWith((states) => secondary),
                                        dataRowHeight: 100,
                                        columns: const [
                                          DataColumn(
                                            label: Text('Pet name', style: TextStyle(fontSize: 16, color: primary)),
                                          ),
                                          DataColumn(
                                            label: Text('Pet age', style: TextStyle(color: primary, fontSize: 16)),
                                          ),
                                          DataColumn(
                                            label: Text('Pet type', style: TextStyle(color: primary, fontSize: 16)),
                                          ),
                                          DataColumn(
                                            label: Text('Pet gender', style: TextStyle(color: primary, fontSize: 16)),
                                          ),
                                          DataColumn(
                                            label: Text('Pet breed', style: TextStyle(color: primary, fontSize: 16)),
                                          ),
                                          DataColumn(
                                            label: Text('Pet collar serial number', style: TextStyle(color: primary, fontSize: 16)),
                                          ),
                                          DataColumn(
                                            label: Text('Date Created', style: TextStyle(color: primary, fontSize: 16)),
                                          ),
                                          DataColumn(
                                            label: Text('Action', style: TextStyle(color: primary, fontSize: 16)),
                                          ),
                                          DataColumn(
                                            label: Text(''),
                                          ),
                                        ],
                                        rows: pet.map((users) {
                                          selectedPosition = users['type'];
                                          return DataRow(
                                            cells: [
                                              DataCell(Text(
                                                users['name'],
                                                style: const TextStyle(fontWeight: FontWeight.w600),
                                              )),
                                              DataCell(Text(users['age'])),
                                              DataCell(Text(users['type'])),
                                              DataCell(Text(users['gender'])),
                                              DataCell(Text(users['breed'])),
                                              DataCell(Text(users['serial_number'])),
                                              DataCell(Text(formatDate(users['date']))),
                                              DataCell(
                                                InkWell(
                                                  onTap: () async {
                                                    dialogueShow(users['name'], users['id']);
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        color: Color(0xFF585858),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        'Edit User',
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                InkWell(
                                                  onTap: () async {
                                                    deletionPet(users['name'], users['id']);
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        'Delete User',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList()),
                                  ],
                                ),
                              );
                            })),
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
