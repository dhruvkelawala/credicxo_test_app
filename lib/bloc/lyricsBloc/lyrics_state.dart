part of 'lyrics_bloc.dart';

abstract class LyricsState extends Equatable {
  const LyricsState();
  
  @override
  List<Object> get props => [];
}

class LyricsInitial extends LyricsState {}

class LyricsLoading extends LyricsState {}

class LyricsLoaded extends LyricsState {
  final Lyrics lyrics;

  LyricsLoaded({this.lyrics});
}

class LyricsError extends LyricsState {
  final error;

  LyricsError({this.error});
}
