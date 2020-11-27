import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/track_details.dart';
import '../models/track_lyrics.dart';

import '../models/track.dart';

abstract class TracksRepo {
  Future<List<Track>> fetchTracks();
  Future<TrackDetails> fetchTrackDetails(int id);
  Future<Lyrics> fetchLyrics(int id);
}

class TrackServices implements TracksRepo {
  static const BASE_URL = "https://api.musixmatch.com";
  static const API_KEY = "2d782bc7a52a41ba2fc1ef05b9cf40d7";
  static const TRACKS_URL = "/ws/1.1/chart.tracks.get?apikey=";
  static const LYRICS_URL =
      "/ws/1.1/track.lyrics.get?track_id=201234497&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";

  @override
  Future<List<Track>> fetchTracks() async {
    final http.Response resp = await http.get(BASE_URL + TRACKS_URL + API_KEY);

    final data = json.decode(resp.body);

    final List<Track> tracks = data["message"]["body"]["track_list"]
        .map<Track>((track) => Track.fromJson(track["track"]))
        .toList();

    return tracks;
  }

  @override
  Future<TrackDetails> fetchTrackDetails(int id) async {
    final String trackId_URL = "&track_id=$id";

    print(id);

    final http.Response resp = await http.get(
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&apikey=$API_KEY");

    final data = json.decode(resp.body);
    print(data);

    return TrackDetails.fromJson(data["message"]["body"]["track"]);
  }

  @override
  Future<Lyrics> fetchLyrics(int id) async {
    final String trackId_URL = "&track_id=$id";

    final http.Response resp = await http
        .get("$BASE_URL/ws/1.1/track.lyrics.get?apikey=$API_KEY&track_id=$id");

    final data = json.decode(resp.body);

    return Lyrics.fromJson(data["message"]["body"]["lyrics"]);
  }
}
