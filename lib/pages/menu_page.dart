import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto3/pages/view_alarm_page.dart';

import 'add_alarm_page.dart';


class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MenuPageState();
  }
}

class MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MedScan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Usuário'),
              accountEmail: Text('user@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Menu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add_alarm),
              title: Text('Adcionar Alarme'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAlarmPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Ver Alarmes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewAlarmPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                print('logout');
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Text("Menu"),
          ],
        ),
      ),
    );
  }
}