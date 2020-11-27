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
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
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
      margin: EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          infoText(key: "Track Name", value: trackDetails.trackName),
          infoText(key: "Artist", value: trackDetails.artistName),
          infoText(key: "Album", value: trackDetails.albumName),
          infoText(key: "Ratings", value: trackDetails.trackRating.toString()),
          infoText(
              key: "Track Url", value: trackDetails.trackShareUrl, isUrl: true),
          // Text(trackDetails
          //     .primaryGenres.musicGenreList[0].musicGenre.musicGenreName),
          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Lyrics",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          LyricsWidget(widget.id),
        ],
      ),
    );
  }

  Widget infoText(
      {@required String key, @required String value, bool isUrl = false}) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
      child: RichText(
          text: TextSpan(
              text: key + ": ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              children: [
            isUrl
                ? TextSpan(
                    text: value,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Color(0xBFFFFFFF)),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunch(value)) {
                          await launch(value);
                        } else {
                          throw 'Could not launch $value';
                        }
                      },
                  )
                : TextSpan(
                    text: value,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Color(0xBFFFFFFF)),
                  )
          ])),
    );
  }
}
