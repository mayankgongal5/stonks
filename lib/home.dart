
import 'package:stonks/login.dart';
import 'package:flutter/material.dart';
import 'package:stonks/main_pages/credit/credit_score_page.dart';
import 'package:stonks/main_pages/expense/expense_page.dart';
import 'package:stonks/main_pages/invesmnet/investment_page.dart';


class HomeScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;

  const HomeScreen({Key? key, required this.onThemeToggle}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  bool isDarkMode = false;
  String userName = "User";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void _changeName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = userName;
        return AlertDialog(
          title: const Text('Change Name'),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
            controller: TextEditingController(text: userName),
            decoration: const InputDecoration(hintText: "Enter new name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  userName = newName;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    // Implement your logout logic here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(onThemeToggle: widget.onThemeToggle)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STONKS'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
              widget.onThemeToggle(isDarkMode);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'Change Name':
                  _changeName();
                  break;
                case 'Logout':
                  _logout();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Change Name',
                child: Text('Change Name'),
              ),
              const PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const <Widget>[
          ExpensePage(),
          InvestmentPage(),
          CreditScorePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Liabilities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Investment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_score),
            label: 'Credit Score',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}