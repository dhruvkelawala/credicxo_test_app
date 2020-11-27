import 'package:credicxo_test_app/api/services.dart';
import 'package:credicxo_test_app/bloc/tracksBloc/tracks_bloc.dart';
import 'package:credicxo_test_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './screens/home.dart';
import 'bloc/LyricsBloc/lyrics_bloc.dart';
import 'bloc/trackDetailsBloc/track_details_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TrackDetailsBloc(
            tracksRepo: TrackServices(),
          ),
        ),
        BlocProvider(
          create: (context) => TracksBloc(
            tracksRepo: TrackServices(),
          ),
        ),
        BlocProvider(
          create: (context) => LyricsBloc(
            tracksRepo: TrackServices(),
          ),
        ),
      ],
      child: MaterialApp(
        home: Home(),
        theme: appTheme,
        title: "Test App",
      ),
    );
  }
}
