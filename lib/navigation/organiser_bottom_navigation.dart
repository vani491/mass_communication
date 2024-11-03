import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../features/auth/presentation/pages/attendee/my_events_page.dart';
import '../features/auth/presentation/pages/attendee/notification_list_page.dart';
import '../features/auth/presentation/pages/organiser/event_create_page.dart';
import '../features/auth/presentation/pages/organiser/organiser_event_list.dart';
import '../features/auth/presentation/pages/attendee/profile_page.dart';

class OrganiserBottomNavigation extends StatefulWidget {
  const OrganiserBottomNavigation({Key? key}) : super(key: key);

  @override
  State<OrganiserBottomNavigation> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OrganiserBottomNavigation> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  int maxCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// widget list
    final List<Widget> bottomBarPages = [

      EventCreatePage(controller: _controller),
      const OrganiserEventListPage(),
      const NotificationPage(userId: '123456',),
      const ProfilePage(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount) ? AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: const Color(0xFFb8c7d4),
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 15.0,

        notchColor: const Color(0xFF04224c),
        /// restart app if you change removeMargins
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 300,
        itemLabelStyle: const TextStyle(fontSize: 10),
        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_filled, color: Colors.blueGrey,),
            activeItem: Icon(Icons.home_filled, color: Colors.white,),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.star, color: Colors.blueGrey),
            activeItem: Icon(Icons.star, color: Colors.white,),
            itemLabel: 'My Events',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.notification_important, color: Colors.blueGrey,),
            activeItem: Icon(Icons.notification_important, color: Colors.white,),
            itemLabel: 'Notification',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person, color: Colors.blueGrey,),
            activeItem: Icon(Icons.person, color: Colors.white,),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          log('current selected index $index');
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      )
          : null,
    );
  }
}