import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/colors.dart';

class SmallNav extends StatefulWidget {
  final String currentPage;

  const SmallNav({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  State<SmallNav> createState() => _SmallNavState();
}

class _SmallNavState extends State<SmallNav> {

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
          const Center(
            child: Text(
              "KelPet",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: primary),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            decoration: widget.currentPage == 'dashboard'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.dashboard,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
                context.go("/dashboard");
              },
            ),
          ),
          Container(
            margin: widget.currentPage == 'notification'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'notification'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.bell,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
                 context.go("/notification");
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: const Divider(
                color: primary,
              )),
          Container(
            margin: widget.currentPage == 'add_pet'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'add_pet'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.cat,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
                 context.go("/add_pet");
              },
            ),
          ),
          Container(
            margin: widget.currentPage == 'pet_location'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'pet_location'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.mapMarked,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
               context.go("/pet_location");
              },
            ),
          ),
          Container(
            margin: widget.currentPage == 'pet_update'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'pet_update'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.sync,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
                context.go("/pet_update");
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: const Divider(
                color: primary,
              )),
          Container(
            margin: widget.currentPage == 'veterinarian'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'veterinarian'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.globe,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
                  context.go("/map");
              },
            ),
          ),
          Container(
            margin: widget.currentPage == 'account_settings'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'account_settings'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.user,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
                 context.go("/account_settings");
              },
            ),
          ),
          Container(
            margin: widget.currentPage == 'health_tips'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'health_tips'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.medkit,
                  size: 16,
                  color: primary,
                ),
              ),
              onTap: () {
                context.go("/health_tips");
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: widget.currentPage == 'log_out'
                ? const EdgeInsets.symmetric(horizontal: 22, vertical: 22)
                : EdgeInsets
                    .zero, // Set margin to zero when not on the 'conversations' page
            decoration: widget.currentPage == 'log_out'
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: navactive,
                  )
                : null,
            child: ListTile(
              hoverColor: navactive.withOpacity(0.2),
              title: const Center(
                child: FaIcon(
                  FontAwesomeIcons.signOut,
                  size: 16,
                  color: primary,
                ),
              ),
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
