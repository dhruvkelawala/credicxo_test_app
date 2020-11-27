import 'package:credicxo_test_app/models/track.dart';
import 'package:credicxo_test_app/screens/track_details_screen.dart';
import 'package:flutter/material.dart';

class TrackListWidget extends StatelessWidget {
  final List<Track> tracks;

  TrackListWidget(this.tracks);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Container(
            child: Text(
              tracks[index].trackName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Container(
            child: Text(tracks[index].artistName),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => TrackDetailsScreen(
                  id: tracks[index].trackId,
                  name: tracks[index].trackName,
                ),
              ),
            );
          },
        );
      },
      itemCount: tracks.length,
    );
  }
}
