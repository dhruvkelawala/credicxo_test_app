import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api/exceptions.dart';
import '../../models/track.dart';
import '../../api/services.dart';

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  TracksBloc({this.tracksRepo}) : super(TracksInitial());

  final TracksRepo tracksRepo;
  List<Track> tracks;

  @override
  Stream<TracksState> mapEventToState(
    TracksEvent event,
  ) async* {
    if (event is FetchTracks) {
      yield TracksLoading();

      try {
        tracks = await tracksRepo.fetchTracks();
        yield TracksLoaded(tracks: tracks);
      } on SocketException {
        yield TracksError(error: NoInternetException("No Internet"));
      } on HttpException {
        yield TracksError(error: NoServiceFoundException("No Service Found"));
      } on FormatException {
        yield TracksError(
            error: InvalidFormatException("Invalid Response Format"));
      } catch (e) {
        print(e);
        yield TracksError(error: UnknownException("Unknown Error"));
      }
    }
  }
}
