import 'package:flutter/material.dart';
import 'package:tb_pemrograman/screens/admin/katalogsepatu_screen.dart';
import 'package:tb_pemrograman/screens/admin/list_katalosepatu.dart';
import 'package:tb_pemrograman/screens/admin/list_user.dart';
import 'package:tb_pemrograman/screens/profile_screen.dart';

class DynamicBottomNavBar extends StatefulWidget {
  const DynamicBottomNavBar({super.key});

  @override
  State<DynamicBottomNavBar> createState() => _DynamicBottomNavBarState();
}

class _DynamicBottomNavBarState extends State<DynamicBottomNavBar> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    // const ListUser(),
    const KatalogSepatuScreen(),
    const ListKatalogSepatu(),
    const ProfileScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: onTabTapped,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_2),
          //   label: 'List User',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Sepatu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Detail Sepatu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red.shade300,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
