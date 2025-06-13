import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> permissionhandler(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Permission is Granted')));
    } else if (status.isDenied) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Permission is Denied')));
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission is Permanently Denied')),
      );
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset('assets/icon.png')),
            InkWell(
              onTap: () {
                permissionhandler(Permission.locationAlways);
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Get Location Permission',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 200,
                height: 50,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                permissionhandler(Permission.sms);
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Get Sms Permission',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 200,
                height: 50,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                permissionhandler(Permission.ignoreBatteryOptimizations);
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Battery Permission',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 200,
                height: 50,
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () async {
                await Workmanager().registerPeriodicTask(
                  'task-identifier',
                  'sendlocation',
                  frequency: Duration(minutes: 16),
                );
              },
              child: Container(
                child: Center(
                  child: Text(
                    'Send Coordinate',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 200,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
