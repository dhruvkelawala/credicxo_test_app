import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../api/exceptions.dart';
import '../../api/services.dart';
import '../../models/track_details.dart';


part 'track_details_event.dart';
part 'track_details_state.dart';

class TrackDetailsBloc extends Bloc<TrackDetailsEvent, TrackDetailsState> {
  TrackDetailsBloc({this.tracksRepo}) : super(TrackDetailsInitial());
  final TracksRepo tracksRepo;
  TrackDetails trackDetails;

  @override
  Stream<TrackDetailsState> mapEventToState(
    TrackDetailsEvent event,
  ) async* {
    if (event is FetchTrackDetails) {
      yield TrackDetailsLoading();
      print("loading");
      try {
        trackDetails = await tracksRepo.fetchTrackDetails(event.id);
        yield TrackDetailsLoaded(trackDetails: trackDetails);
      } on SocketException {
        yield TrackDetailsError(error: NoInternetException("No Internet"));
      } on HttpException {
        yield TrackDetailsError(
            error: NoServiceFoundException("No Service Found"));
      } on FormatException {
        yield TrackDetailsError(
            error: InvalidFormatException("Invalid Response Format"));
      }
      catch (e) {
        print(e);
        yield TrackDetailsError(error: UnknownException("Unknown Error"));
      }
    }
  }
}
