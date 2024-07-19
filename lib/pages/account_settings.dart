import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../helpers/responsiveness.dart';
import '../navigator/big_nav.dart';
import '../navigator/small_nav.dart';
import '../widgets/top_layout_mobile.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  var user = FirebaseAuth.instance.currentUser!.uid;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String formatDate(dateData) {
    var tempDate = DateFormat.yMMMd().add_jm().format(dateData.toDate());
    var limboDate = tempDate.split(' ');
    var date = "${limboDate[0]} ${limboDate[1]} ${limboDate[2]}";
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: ResponsiveWidget.isSmallScreen(context)
            ? topNavigationBar(context, scaffoldKey, 'Account Settings')
            : null,
        drawer: const BigNav(currentPage: 'account_settings'),
        body: Row(
          children: [
            if (ResponsiveWidget.isLargeScreen(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isLargeScreen(context) 
                    ? const BigNav(currentPage: 'account_settings')
                    : null,
              )),
            if (ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context))
              Expanded(
                  child: Container(
                child: ResponsiveWidget.isMediumScreen(context)|| ResponsiveWidget.isCustomSize(context)
                    ? const SmallNav(currentPage: 'account_settings')
                    : null,
              )),
            Expanded(
                flex: ResponsiveWidget.isLargeScreen(context) ? 5 : 7,
                child: SingleChildScrollView(
                  child: Container(
                    margin: ResponsiveWidget.isLargeScreen(context)
                        ? const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 150)
                        : ResponsiveWidget.isMediumScreen(context) || ResponsiveWidget.isCustomSize(context)
                            ? const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 120)
                            : ResponsiveWidget.isSmallScreen(context)
                                ? const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20)
                                : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text('Account Settings',
                                style: TextStyle(color: tab, fontSize: 24))
                          ],
                        ),
                        SizedBox(
                            height: ResponsiveWidget.isSmallScreen(context)
                                ? 10
                                : 50),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child:
                                      CircularProgressIndicator(color: primary),
                                );
                              }
                              // print(snapshot.data?.docs.map((doc) => doc.data()));

                              var profiles = snapshot.data!.docs.map((item) {
                                return {
                                  'first_name': item['first_name'],
                                  'last_name': item['last_name'],
                                  'time': item['time'],
                                  'id': item.id,
                                };
                              }).toList();
                              var names = profiles.where((item) {
                                return item['id'] == user;
                              }).toList();

                              return Column(
                                children: names.map((all) {
                                  fnameController.text = all['first_name'];
                                  lnameController.text = all['last_name'];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: Form(
                                      key: formKey,
                                      child: Container(
                                        height: 530,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Center(
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: ResponsiveWidget
                                                                .isSmallScreen(
                                                                    context)
                                                            ? 30
                                                            : 60,
                                                        backgroundColor:
                                                            profile,
                                                        child: Text(
                                                          'C',
                                                          style: TextStyle(
                                                            fontSize: ResponsiveWidget
                                                                    .isSmallScreen(
                                                                        context)
                                                                ? 20
                                                                : 50,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: secondary,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ResponsiveWidget
                                                              .isSmallScreen(
                                                                  context)
                                                          ? Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxWidth:
                                                                          200),
                                                              child: Text(
                                                                  "${all['first_name']} ${all['last_name']}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          ResponsiveWidget.isSmallScreen(context)
                                                                              ? 16
                                                                              : 30,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color:
                                                                          name)),
                                                            )
                                                          : Text(
                                                              "${all['first_name']} ${all['last_name']}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ResponsiveWidget.isSmallScreen(
                                                                              context)
                                                                          ? 16
                                                                          : 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: name)),
                                                      Text(
                                                          "Member since ${formatDate(all['time'])}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            const Divider(),
                                            SizedBox(
                                                height: !ResponsiveWidget
                                                        .isSmallScreen(context)
                                                    ? 50
                                                    : 30),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      child: !ResponsiveWidget
                                                              .isSmallScreen(
                                                                  context)
                                                          ? Row(
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                          'First Name'),
                                                                      TextFormField(
                                                                        controller:
                                                                            fnameController,
                                                                        validator:
                                                                            (text) {
                                                                          if (text == null ||
                                                                              text.isEmpty) {
                                                                            return "First Name is empty";
                                                                          } else {
                                                                            return null;
                                                                          }
                                                                        },
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          border:
                                                                              UnderlineInputBorder(),
                                                                          hintText:
                                                                              'Enter your first name',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 100),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                          'Last Name'),
                                                                      TextFormField(
                                                                        controller:
                                                                            lnameController,
                                                                        validator:
                                                                            (text) {
                                                                          if (text == null ||
                                                                              text.isEmpty) {
                                                                            return "Last Name is empty";
                                                                          } else {
                                                                            return null;
                                                                          }
                                                                        },
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          border:
                                                                              UnderlineInputBorder(),
                                                                          hintText:
                                                                              'Enter your last name',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                    'First Name'),
                                                                TextFormField(
                                                                  controller:
                                                                      fnameController,
                                                                  validator:
                                                                      (text) {
                                                                    if (text ==
                                                                            null ||
                                                                        text.isEmpty) {
                                                                      return "First Name is empty";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(),
                                                                    hintText:
                                                                        'Enter your first name',
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 14,
                                                                ),
                                                                const Text(
                                                                    'Last Name'),
                                                                TextFormField(
                                                                  controller:
                                                                      lnameController,
                                                                  validator:
                                                                      (text) {
                                                                    if (text ==
                                                                            null ||
                                                                        text.isEmpty) {
                                                                      return "Last Name is empty";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    border:
                                                                        UnderlineInputBorder(),
                                                                    hintText:
                                                                        'Enter your last name',
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                  const SizedBox(height: 20),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: ResponsiveWidget
                                                        .isSmallScreen(context)
                                                    ? 20
                                                    : 50),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          secondary,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: ResponsiveWidget
                                                                  .isSmallScreen(
                                                                      context)
                                                              ? 80
                                                              : 130,
                                                          vertical: 20),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5))),
                                                  onPressed: () async {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("users")
                                                          .doc(user)
                                                          .update({
                                                        'first_name':
                                                            fnameController
                                                                .text,
                                                        'last_name':
                                                            lnameController.text
                                                      }).then((_) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: const Text(
                                                                "Profile Updated Successfully",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color:
                                                                      notification,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                )),
                                                            backgroundColor:
                                                                snackbar,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            margin: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height -
                                                                    100,
                                                                left:  !ResponsiveWidget.isSmallScreen(context) ? 200 : 30,
                                                                right: ! ResponsiveWidget.isSmallScreen(context) ? 200 : 30,),
                                                            action:
                                                                SnackBarAction(
                                                              label: 'X',
                                                              textColor:
                                                                  secondary,
                                                              onPressed: () {
                                                                // Some code to undo the change.
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      });

                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    }
                                                  },
                                                  child: (isLoading == true)
                                                      ? const Row(
                                                          children: [
                                                            Text(
                                                              "Please Wait...",
                                                              style: TextStyle(
                                                                  color:
                                                                      primary),
                                                            ),
                                                            SizedBox(
                                                                height: 20,
                                                                width: 20,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color:
                                                                      primary,
                                                                )),
                                                          ],
                                                        )
                                                      : const Text(
                                                          'Update Changes',
                                                          style: TextStyle(
                                                              color: primary),
                                                        ),
                                                ),
                                              ],
                                            ),
                                        
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            })
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
