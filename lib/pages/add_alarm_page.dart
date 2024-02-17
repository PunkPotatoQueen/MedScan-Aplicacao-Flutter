import 'package:flutter/material.dart';
import 'package:projeto3/pages/view_alarm_page.dart';

import 'menu_page.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({super.key});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  String alarmName = '';
  String alarmDesc = '';

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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) {
                  alarmName = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nome do alarme',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                onChanged: (text) {
                  alarmDesc = text;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Descrição do alarme',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    print(alarmName);
                    print(alarmDesc);
                  },
                  child: Text('Adcionar Alarme')
              ),
            ],
          ),
        ),
      )
    );
  }
}
