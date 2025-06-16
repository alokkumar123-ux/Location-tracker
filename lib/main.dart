import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/home.dart';
import 'package:telephony/telephony.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() async {
  Workmanager().executeTask((taskName, inputData) async {
    print("WorkManager running task: $taskName");

    if (taskName == 'sendlocation') {
      print('task is called');
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        String message = 'Lat=${position.latitude}, Long=${position.longitude}';
        print("Fetched location: $message");

        await Telephony.backgroundInstance.sendSms(
          to: '9954666437',
          message: message,
        );

        print("SMS sent to 9954666437: $message");
      } catch (e) {
        print("Error in sendlocation task: $e");
      }
    }

    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode:
        true, // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  Workmanager().registerPeriodicTask(
    "task-identifier",
    "sendlocation",
    frequency: Duration(minutes: 15),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
    );
  }
}
