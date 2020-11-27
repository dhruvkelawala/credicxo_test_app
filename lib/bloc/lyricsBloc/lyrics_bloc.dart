import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:credicxo_test_app/api/exceptions.dart';
import 'package:credicxo_test_app/api/services.dart';
import 'package:credicxo_test_app/models/track_lyrics.dart';
import 'package:equatable/equatable.dart';

part 'lyrics_event.dart';
part 'lyrics_state.dart';

class LyricsBloc extends Bloc<LyricsEvent, LyricsState> {
  LyricsBloc({this.tracksRepo}) : super(LyricsInitial());
  final TracksRepo tracksRepo;
  Lyrics lyrics;

  @override
  Stream<LyricsState> mapEventToState(
    LyricsEvent event,
  ) async* {
   if (event is FetchLyrics) {
      yield LyricsLoading();

      try {
        lyrics = await tracksRepo.fetchLyrics(event.id);
        yield LyricsLoaded(lyrics: lyrics);
      } on SocketException {
        yield LyricsError(error: NoInternetException("No Internet"));
      } on HttpException {
        yield LyricsError(error: NoServiceFoundException("No Service Found"));
      } on FormatException {
        yield LyricsError(
            error: InvalidFormatException("Invalid Response Format"));
      } catch (e) {
        print(e);
        yield LyricsError(error: UnknownException("Unknown Error"));
      }
    }
  }
}
