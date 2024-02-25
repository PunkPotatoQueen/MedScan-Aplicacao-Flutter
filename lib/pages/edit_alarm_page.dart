import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:projeto3/widgets/date_time_picker.dart';

class ExampleAlarmEditScreen extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const ExampleAlarmEditScreen({Key? key, this.alarmSettings})
      : super(key: key);

  @override
  State<ExampleAlarmEditScreen> createState() => _ExampleAlarmEditScreenState();
}

class _ExampleAlarmEditScreenState extends State<ExampleAlarmEditScreen> {
  bool loading = false;

  late bool creating;
  late DateTime selectedDateTime;
  late bool loopAudio;
  late bool vibrate;
  late double? volume;
  late String assetAudio;

  String alarmTitle = '';
  String alarmDescription = '';

  @override
  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;

    if (creating) {
      selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
      selectedDateTime = selectedDateTime.copyWith(second: 0, millisecond: 0);
      loopAudio = true;
      vibrate = true;
      volume = null;
      assetAudio = 'assets/audios/marimba.mp3';
    } else {
      selectedDateTime = widget.alarmSettings!.dateTime;
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      volume = widget.alarmSettings!.volume;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  String getDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = selectedDateTime.difference(today).inDays;

    switch (difference) {
      case 0:
        return 'Hoje';
      case 1:
        return 'Amanhã';
      case 2:
        return 'Depois de amanhã';
      default:
        return 'Em $difference dia(s)';
    }
  }

  Future<void> pickTime() async {
    final res = await showDateTimePicker(
      context: context,
    );

    if (res != null) {
      setState(() {
        final DateTime now = DateTime.now();
        selectedDateTime = now.copyWith(
          hour: res.hour,
          minute: res.minute,
          second: 0,
          millisecond: 0,
          microsecond: 0,
        );
        if (selectedDateTime.isBefore(now)) {
          selectedDateTime = selectedDateTime.add(const Duration(days: 1));
        }
      });
    }
  }

  AlarmSettings buildAlarmSettings() {
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 10000
        : widget.alarmSettings!.id;

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: selectedDateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volume: volume,
      assetAudioPath: assetAudio,
      notificationTitle: alarmTitle,
      notificationBody: alarmDescription,
    );
    return alarmSettings;
  }

  void saveAlarm() {
    if (loading) return;
    setState(() => loading = true);
    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) Navigator.pop(context, true);
      setState(() => loading = false);
    });
  }

  void deleteAlarm() {
    Alarm.stop(widget.alarmSettings!.id).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      "Cancelar",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: saveAlarm,
                    child: loading
                        ? const CircularProgressIndicator()
                        : Text(
                      "Salvar",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.green[900]),
                    ),
                  ),
                ],
              ),
              Text(
                getDay(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black.withOpacity(0.8)),
              ),
              const SizedBox(height: 10,),
              RawMaterialButton(
                onPressed: pickTime,
                fillColor: Colors.greenAccent,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    TimeOfDay.fromDateTime(selectedDateTime).format(context),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                onChanged: (text) {
                  alarmTitle = text;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Título do alarme',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                onChanged: (text) {
                  alarmDescription = text;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Descrição do alarme',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Repetir',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch(
                    value: loopAudio,
                    onChanged: (value) => setState(() => loopAudio = value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vibrar',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch(
                    value: vibrate,
                    onChanged: (value) => setState(() => vibrate = value),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Som do alarme',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  DropdownButton(
                    value: assetAudio,
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'assets/audios/marimba.mp3',
                        child: Text('Marimba'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'assets/audios/nokia.mp3',
                        child: Text('Nokia'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'assets/audios/mozart.mp3',
                        child: Text('Mozart'),
                      ),
                    ],
                    onChanged: (value) => setState(() => assetAudio = value!),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Customizar volume',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch(
                    value: volume != null,
                    onChanged: (value) =>
                        setState(() => volume = value ? 0.5 : null),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                child: volume != null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      volume! > 0.7
                          ? Icons.volume_up_rounded
                          : volume! > 0.1
                          ? Icons.volume_down_rounded
                          : Icons.volume_mute_rounded,
                    ),
                    Expanded(
                      child: Slider(
                        value: volume!,
                        onChanged: (value) {
                          setState(() => volume = value);
                        },
                      ),
                    ),
                  ],
                )
                    : const SizedBox(),
              ),
              if (!creating)
                TextButton(
                  onPressed: deleteAlarm,
                  child: Text(
                    'Excluir Alarme',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                  ),
                ),
              const SizedBox(),
            ],
          ),
        )
      );
  }
}
