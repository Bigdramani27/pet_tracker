import '../helpers/responsiveness.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key,
        String currentPage) =>
    AppBar(
        backgroundColor: secondary,
        leading: IconButton(
            color: primary,
            onPressed: () {
              key.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  currentPage,
                  style: TextStyle(color: primary),
                ),
              ),
            ),
          ],
        ),
        );
