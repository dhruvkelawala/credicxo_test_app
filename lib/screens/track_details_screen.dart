import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:credicxo_test_app/bloc/trackDetailsBloc/track_details_bloc.dart';
import 'package:credicxo_test_app/models/track.dart';
import 'package:credicxo_test_app/models/track_details.dart';
import 'package:credicxo_test_app/widgets/bookmark_widget.dart';
import 'package:credicxo_test_app/widgets/error_text.dart';
import 'package:credicxo_test_app/widgets/loading.dart';
import 'package:credicxo_test_app/widgets/lyrics_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackDetailsScreen extends StatefulWidget {
  final int id;
  final String name;

  TrackDetailsScreen({this.id, this.name});
  @override
  _TrackDetailsScreenState createState() => _TrackDetailsScreenState();
}

class _TrackDetailsScreenState extends State<TrackDetailsScreen> {
  StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    _loadTrackDetails();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(widget.id);
      _loadTrackDetails();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  _loadTrackDetails() async {
    BlocProvider.of<TrackDetailsBloc>(context)
        .add(FetchTrackDetails(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          BookmarkWidget(
            id: widget.id,
            name: widget.name,
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<TrackDetailsBloc, TrackDetailsState>(
          builder: (BuildContext ctx, TrackDetailsState state) {
            if (state is TrackDetailsError) {
              final error = state.error;
              String message = '${error.message}';
              return ErrorTxt(
                text: message,
              );
            }
            if (state is TrackDetailsLoaded) {
              TrackDetails trackDetails = state.trackDetails;
              return _trackDetailsBody(trackDetails);
            }
            return Loading();
          },
        ),
      ),
    );
  }

  Widget _trackDetailsBody(TrackDetails trackDetails) {
    return Container(
      child: ListView(
        children: [
          Text(trackDetails.trackName),
          Text(trackDetails.artistName),
          Text(trackDetails.albumName),
          Text(trackDetails.trackRating.toString()),
          if (trackDetails.explicit == 1) Text("Explicit"),
          Text(trackDetails.trackShareUrl),
          // Text(trackDetails
          //     .primaryGenres.musicGenreList[0].musicGenre.musicGenreName),
          SizedBox(height: 100),
          Text(
            "Lyrics",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          LyricsWidget(widget.id),
        ],
      ),
    );
  }
}
