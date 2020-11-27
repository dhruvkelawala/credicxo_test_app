part of 'track_details_bloc.dart';

abstract class TrackDetailsState extends Equatable {
  const TrackDetailsState();
  
  @override
  List<Object> get props => [];
}

class TrackDetailsInitial extends TrackDetailsState {}

class TrackDetailsLoading extends TrackDetailsState {}

class TrackDetailsLoaded extends TrackDetailsState {
  final TrackDetails trackDetails;

  TrackDetailsLoaded({this.trackDetails});
}

class TrackDetailsError extends TrackDetailsState {
  final error;

  TrackDetailsError({this.error});
}
