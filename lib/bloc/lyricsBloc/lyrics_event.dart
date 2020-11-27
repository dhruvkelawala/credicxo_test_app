part of 'lyrics_bloc.dart';

abstract class LyricsEvent extends Equatable {
  const LyricsEvent();

  @override
  List<Object> get props => [];
}

class FetchLyrics extends LyricsEvent {
  final int id;

  FetchLyrics(this.id);

  @override
  List<Object> get props => [id];
}
