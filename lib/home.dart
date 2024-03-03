import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:taskify/screens/homepage.dart';
import 'package:taskify/providers/page.dart';
import 'package:taskify/screens/profile.dart';
import 'package:taskify/utils/shared.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _activeIndex = 0;

  static final List<Widget> _pageOptions = <Widget>[
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => SafeArea(
        child: Scaffold(
          body: Center(
            child: _pageOptions.elementAt(pageProvider.page),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: primaryColour.withOpacity(0.15),
                  spreadRadius: 5,
                  blurRadius: 20,
                )
              ],
              color: backgroundColour,
            ),
            child: GNav(
              backgroundColor: backgroundColour,
              activeColor: primaryColour,
              gap: 8,
              selectedIndex: pageProvider.page,
              onTabChange: (index) {
                pageProvider.setPage(index);
                setState(() {
                  _activeIndex = index;
                });
              },
              tabs: [
                gButton(icon: [
                  Icons.home_filled,
                  Icons.home_filled,
                ], text: "Home"),
                gButton(icon: [
                  CupertinoIcons.person,
                  CupertinoIcons.person_fill,
                ], text: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GButton gButton({
    required List<IconData> icon,
    required String text,
  }) {
    return GButton(
      icon: _activeIndex == 1 ? icon[1] : icon[0],
      text: text,
      textStyle: defaultText.copyWith(
        color: primaryColour,
        fontWeight: FontWeight.w800,
      ),
      iconColor: primaryColour.withOpacity(0.5),
      textColor: primaryColour,
      iconSize: 32,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
    );
  }
}
