import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connectivity/connectivity.dart';
import '../bloc/tracksBloc/tracks_bloc.dart';
import '../models/track.dart';
import '../screens/bookmark_screen.dart';
import '../widgets/error_text.dart';
import '../widgets/loading.dart';
import '../widgets/track_list_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTracks();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _loadTracks();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  _loadTracks() async {
    BlocProvider.of<TracksBloc>(context).add(FetchTracks());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Credicxo Test App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                text: "Top Charts",
              ),
              Tab(
                icon: Icon(
                  Icons.bookmarks,
                  color: Colors.black,
                ),
                text: "Bookmarks",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [buildTracksList(), BookmarksScreen()],
        ),
      ),
    );
  }

  Container buildTracksList() {
    return Container(
      child: BlocBuilder<TracksBloc, TracksState>(
          builder: (BuildContext context, TracksState state) {
        if (state is TracksError) {
          final error = state.error;
          String message = '${error.message}';
          return ErrorTxt(
            text: message,
          );
        }
        if (state is TracksLoaded) {
          List<Track> tracks = state.tracks;
          return TrackListWidget(tracks);
        }
        return Loading();
      }),
    );
  }
}
