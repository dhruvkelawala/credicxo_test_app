import 'package:credicxo_test_app/bloc/LyricsBloc/lyrics_bloc.dart';
import 'package:credicxo_test_app/models/track_lyrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'error_text.dart';
import 'loading.dart';

class LyricsWidget extends StatefulWidget {
  final int id;

  LyricsWidget(this.id);
  @override
  _LyricsWidgetState createState() => _LyricsWidgetState();
}

class _LyricsWidgetState extends State<LyricsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadLyrics();
  }

  _loadLyrics() {
    BlocProvider.of<LyricsBloc>(context).add(FetchLyrics(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<LyricsBloc, LyricsState>(
          builder: (BuildContext context, LyricsState state) {
        if (state is LyricsError) {
          final error = state.error;
          String message = '${error.message}';
          return ErrorTxt(
            text: message,
          );
        }
        if (state is LyricsLoaded) {
          Lyrics lyrics = state.lyrics;
          return Text(lyrics.lyricsBody);
        }
        return Loading();
      }),
    );
  }
}
