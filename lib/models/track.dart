import './fragments/primary_genres.dart';


class Track {
  Track({
    this.trackId,
    this.trackName,
    this.trackNameTranslationList,
    this.trackRating,
    this.commontrackId,
    this.instrumental,
    this.explicit,
    this.hasLyrics,
    this.hasSubtitles,
    this.hasRichsync,
    this.numFavourite,
    this.albumId,
    this.albumName,
    this.artistId,
    this.artistName,
    this.trackShareUrl,
    this.trackEditUrl,
    this.restricted,
    this.updatedTime,
    this.primaryGenres,
  });

  int trackId;
  String trackName;
  List<dynamic> trackNameTranslationList;
  int trackRating;
  int commontrackId;
  int instrumental;
  int explicit;
  int hasLyrics;
  int hasSubtitles;
  int hasRichsync;
  int numFavourite;
  int albumId;
  String albumName;
  int artistId;
  String artistName;
  String trackShareUrl;
  String trackEditUrl;
  int restricted;
  DateTime updatedTime;
  PrimaryGenres primaryGenres;

  Track.fromJson(Map<String, dynamic> json) {
    trackId = json["track_id"];
    trackName = json["track_name"];
    trackNameTranslationList =
        List<dynamic>.from(json["track_name_translation_list"].map((x) => x));
    trackRating = json["track_rating"];
    commontrackId = json["commontrack_id"];
    instrumental = json["instrumental"];
    explicit = json["explicit"];
    hasLyrics = json["has_lyrics"];
    hasSubtitles = json["has_subtitles"];
    hasRichsync = json["has_richsync"];
    numFavourite = json["num_favourite"];
    albumId = json["album_id"];
    albumName = json["album_name"];
    artistId = json["artist_id"];
    artistName = json["artist_name"];
    trackShareUrl = json["track_share_url"];
    trackEditUrl = json["track_edit_url"];
    restricted = json["restricted"];
    updatedTime = DateTime.parse(json["updated_time"]);
    primaryGenres = PrimaryGenres.fromJson(json["primary_genres"]);
  }

  Map<String, dynamic> toJson() => {
        "track_id": trackId,
        "track_name": trackName,
        "track_name_translation_list":
            List<dynamic>.from(trackNameTranslationList.map((x) => x)),
        "track_rating": trackRating,
        "commontrack_id": commontrackId,
        "instrumental": instrumental,
        "explicit": explicit,
        "has_lyrics": hasLyrics,
        "has_subtitles": hasSubtitles,
        "has_richsync": hasRichsync,
        "num_favourite": numFavourite,
        "album_id": albumId,
        "album_name": albumName,
        "artist_id": artistId,
        "artist_name": artistName,
        "track_share_url": trackShareUrl,
        "track_edit_url": trackEditUrl,
        "restricted": restricted,
        "updated_time": updatedTime.toIso8601String(),
        "primary_genres": primaryGenres.toJson(),
      };
}



