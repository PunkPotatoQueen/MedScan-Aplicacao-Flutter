import 'package:alarm/alarm.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projeto3/pages/camera_page.dart';

class ExampleAlarmRingScreen extends StatelessWidget {
  final AlarmSettings alarmSettings;

  const ExampleAlarmRingScreen({Key? key, required this.alarmSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  alarmSettings.notificationBody,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )
              ),
              const Text("🔔", style: TextStyle(fontSize: 50)),
              RawMaterialButton(
                fillColor: Colors.greenAccent,
                onPressed: () async {
                  Alarm.stop(alarmSettings.id);

                  await availableCameras().then((value) => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
                },
                child: const Text(
                  "Tomar Medicamento",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
