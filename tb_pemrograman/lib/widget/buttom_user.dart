import 'package:flutter/material.dart';
import 'package:tb_pemrograman/screens/login_page.dart';
import 'package:tb_pemrograman/screens/profile_screen.dart';
import 'package:tb_pemrograman/screens/user/home_page.dart';
import 'package:tb_pemrograman/services/auth_manager.dart';

class DynamicBottomNavBarUser extends StatefulWidget {
  const DynamicBottomNavBarUser({Key? key}) : super(key: key);

  @override
  State<DynamicBottomNavBarUser> createState() =>
      _DynamicBottomNavBarUserState();
}

class _DynamicBottomNavBarUserState extends State<DynamicBottomNavBarUser> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          if (index == 2) {
            _showLogoutConfirmationDialog(context);
          } else {
            setState(() {
              _currentPageIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red.shade300,
        unselectedItemColor: Colors.black,
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton.icon(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('Tidak', style: TextStyle(color: Colors.red)),
            ),
            TextButton.icon(
              onPressed: () async {
                await AuthManager.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.check, color: Colors.green),
              label: const Text('Ya', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
