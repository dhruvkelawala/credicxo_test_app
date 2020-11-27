part of 'tracks_bloc.dart';

abstract class TracksEvent extends Equatable {
  const TracksEvent();

  @override
  List<Object> get props => [];
}

class FetchTracks extends TracksEvent {}

// class FetchTrackDetails extends TracksEvent {
//   final int trackId;

//   FetchTrackDetails(this.trackId);

//   @override
//   List<Object> get props => [trackId];
// }

// class FetchTrackLyrics extends TracksEvent {
//   final int trackId;

//   FetchTrackLyrics(this.trackId);

//   @override
//   List<Object> get props => [trackId];
// }
