import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/colors.dart';

class BigNav extends StatefulWidget {
  final String currentPage;

  const BigNav({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  State<BigNav> createState() => _BigNavState();
}

class _BigNavState extends State<BigNav> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
      ),
      backgroundColor: secondary,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
        children: [
          Row(
            children: [
              Image.asset('images/logo.png', width: 40, height: 40),
              const Text(
                'KelPet Dashboard',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: primary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: widget.currentPage == 'dashboard'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.dashboard,
                size: 16,
                color: primary,
              ),
              title: 'Dashboard',
              onTap: () {
               context.go("/dashboard");
              },
            ),
          ),
          Container(
            decoration: widget.currentPage == 'notification'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.bell,
                size: 16,
                color: primary,
              ),
              title: 'Notifications',
              onTap: () {
               context.go("/notification");
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: const Divider(
                color: primary,
              )),
          Container(
            alignment: Alignment.topLeft,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 20),
              child: Text(
                'Pet Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: active,
                ),
              ),
            ),
          ),
          Container(
            decoration: widget.currentPage == 'add_pet'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.cat,
                size: 16,
                color: primary,
              ),
              title: 'Add Pet',
              onTap: () {
                context.go("/add_pet");
              },
            ),
          ),
          Container(
            decoration: widget.currentPage == 'pet_location'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.mapMarker,
                size: 16,
                color: primary,
              ),
              title: 'Pet Location',
              onTap: () {
               context.go("/pet_location");
              },
            ),
          ),
          Container(
            decoration: widget.currentPage == 'pet_update'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.sync,
                size: 16,
                color: primary,
              ),
              title: 'Pet update',
              onTap: () {
               context.go("/pet_update");
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: const Divider(
                color: primary,
              )),
          Container(
            alignment: Alignment.topLeft,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 20),
              child: Text(
                'Extra Resources',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: active,
                ),
              ),
            ),
          ),
          Container(
            decoration: widget.currentPage == 'veterinarian'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.globe,
                size: 16,
                color: primary,
              ),
              title: 'Map of veterinarian',
              onTap: () {
                context.go("/map");
              },
            ),
          ),
          Container(
            decoration: widget.currentPage == 'account_settings'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.user,
                size: 16,
                color: primary,
              ),
              title: 'Account Settings',
              onTap: () {
                context.go("/account_settings");
              },
            ),
          ),
          Container(
            decoration: widget.currentPage == 'health_tips'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.medkit,
                size: 16,
                color: primary,
              ),
              title: 'Health Tips',
              onTap: () {
               context.go("/health_tips");
              },
            ),
          ),SizedBox(height: 35,),
          Container(
            decoration: widget.currentPage == 'log_out'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: MenuList(
              icon: const FaIcon(
                FontAwesomeIcons.signOut,
                size: 16,
                color: primary,
              ),
              title: 'Logout',
              onTap: () {
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
 context.go("/");
  }
}

class MenuList extends StatelessWidget {
  const MenuList({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final FaIcon icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: navactive.withOpacity(0.2),
      horizontalTitleGap: 0,
      onTap: onTap,
      leading: icon,
      title: Text(title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w900, color: primary)),
    );
  }
}
