//@dart=2.9
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kokiku/common/navigation.dart';
import 'package:kokiku/data/api/api_service.dart';
import 'package:kokiku/data/db/favorite_database.dart';
import 'package:kokiku/provider/database_provider.dart';
import 'package:kokiku/provider/restaurant_provider.dart';
import 'package:kokiku/provider/schedulling_provider.dart';
import 'dart:async';
import 'package:kokiku/ui/splash_screen.dart';
import 'package:kokiku/utils/background_service.dart';
import 'package:kokiku/utils/notification_helper.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: MaterialApp(
        title: 'Kokiku',
        theme: ThemeData(),
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
