import 'package:flutter/material.dart';
import '../pages/Home/home_page.dart';
import '../pages/Account/profile_page.dart';
import '../pages/Chat/chat_page.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  _PageNavigation createState() => _PageNavigation();
}

class _PageNavigation extends State<PageNavigation> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (newPage) {
            setState(() {
              _selectedIndex = newPage;
            });
          },
          children: [
            Container(child: HomePage()),
            Container(child: ChatPage()),
            Container(
              child: const Text(
                'Search Page',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: ProfilePage(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.blueGrey,
          onTap: onTapped,
        ),
      ),
    );
  }
}
