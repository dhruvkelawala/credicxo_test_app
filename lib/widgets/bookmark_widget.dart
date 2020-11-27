import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../hiveModels/hive_track.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkWidget extends StatefulWidget {
  BookmarkWidget({this.id, this.name});

  final int id;
  final String name;

  @override
  _BookmarkWidgetState createState() => _BookmarkWidgetState();
}

class _BookmarkWidgetState extends State<BookmarkWidget> {
  Box<HiveTrack> hiveTracksBox;

  @override
  void initState() {
    super.initState();
    hiveTracksBox = Hive.box('tracks');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      child: ValueListenableBuilder(
        valueListenable: hiveTracksBox.listenable(),
        builder: (context, Box<HiveTrack> box, _) => Container(
          child: GestureDetector(
            child: getIcon(box),
            onTap: () async {
              if (box.containsKey(widget.id)) {
                print(box.get(widget.id).name + " deleted");
                await box.delete(widget.id);
              } else {
                await box.put(
                    widget.id, HiveTrack(id: widget.id, name: widget.name));
                print(box.get(widget.id).name + " added");
              }
            },
          ),
        ),
      ),
    );
  }

  Widget getIcon(Box<HiveTrack> box) {
    if (box.containsKey(widget.id)) {
      return Icon(Icons.bookmark, color: Colors.redAccent,);
    }
    return Icon(Icons.bookmark_border);
  }
}
