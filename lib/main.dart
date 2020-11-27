import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './hiveModels/hive_track.dart';
import './app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveTrackAdapter());
  await Hive.openBox<HiveTrack>('tracks');
  runApp(MyApp());
}
