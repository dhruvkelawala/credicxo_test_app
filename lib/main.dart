import 'package:credicxo_test_app/hiveModels/hive_track.dart';
import 'package:flutter/material.dart';
import './app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveTrackAdapter());
  await Hive.openBox<HiveTrack>('tracks');
  runApp(MyApp());
}
