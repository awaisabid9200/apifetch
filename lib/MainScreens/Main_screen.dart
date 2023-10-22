import 'package:apifetch/MainScreens/Apple_screen.dart';
import 'package:apifetch/MainScreens/Tech_screen.dart';
import 'package:apifetch/MainScreens/Tesla_Screen.dart';
import 'package:apifetch/MainScreens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _HeadlinesState();
}

class _HeadlinesState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            RichText(
              text: TextSpan(
                  text: 'StepUp',
                  style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  children: [
                    TextSpan(
                        text: 'News',
                        style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.red)),
                  ]),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.red,
          tabs: [
            Tab(
              text: 'Headlines',
            ),
            Tab(
              text: 'Apple',
            ),
            Tab(
              text: 'Tesla',
            ),
            Tab(
              text: 'Tech',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          HomeScreen(),
          AppleScreen(),
          TeslaScreen(),
          TechScreen(),
        ],
      ),
    );
  }
}
