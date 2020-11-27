part of 'track_details_bloc.dart';

abstract class TrackDetailsEvent extends Equatable {
  const TrackDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchTrackDetails extends TrackDetailsEvent {
  final int id;

  FetchTrackDetails(this.id);

  @override
  List<Object> get props => [id];
}
