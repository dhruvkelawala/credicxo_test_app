import 'package:flutter/material.dart';

import '../models/track.dart';
import '../screens/track_details_screen.dart';

class TrackListWidget extends StatelessWidget {
  final List<Track> tracks;

  TrackListWidget(this.tracks);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
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
            ),
            SizedBox(
              height: 0,
              child: Divider(
                color: Colors.white,
                thickness: 0,
              ),
            )
          ],
        );
      },
      itemCount: tracks.length,
    );
  }
}
