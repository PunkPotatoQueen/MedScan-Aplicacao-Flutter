import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:projeto3/pages/manager_alarm_page.dart';

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
              accountName: Text(
                'Carlos Silva',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              accountEmail: Text(
                'carlos.silva@gmail.com',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Menu'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text('Gerenciar Alarmes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManagerAlarmPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                print('logout');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Text(
                "Nenhum medicamento tomado",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}