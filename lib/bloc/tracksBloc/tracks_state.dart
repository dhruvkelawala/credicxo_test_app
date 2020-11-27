part of 'tracks_bloc.dart';

abstract class TracksState extends Equatable {
  const TracksState();

  @override
  List<Object> get props => [];
}

class TracksInitial extends TracksState {}

class TracksLoading extends TracksState {}

class TracksLoaded extends TracksState {
  final List<Track> tracks;

  TracksLoaded({this.tracks});
}

class TracksError extends TracksState {
  final error;

  TracksError({this.error});
}
