import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../screens/track_details_screen.dart';
import '../hiveModels/hive_track.dart';

class BookmarksScreen extends StatefulWidget {
  @override
  _BookmarksScreenState createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  Box<HiveTrack> hiveTracksBox;

  @override
  void initState() {
    super.initState();
    hiveTracksBox = Hive.box('tracks');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hiveTracksBox.listenable(),
      builder: (context, Box<HiveTrack> box, _) => ListView.builder(
        itemCount: box.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(box.getAt(index).name),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TrackDetailsScreen(
                  id: box.getAt(index).id,
                  name: box.getAt(index).name,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
