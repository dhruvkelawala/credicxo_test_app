import 'music_genre.dart';

class PrimaryGenres {
  PrimaryGenres({
    this.musicGenreList,
  });

  List<MusicGenreList> musicGenreList;

  factory PrimaryGenres.fromJson(Map<String, dynamic> json) => PrimaryGenres(
        musicGenreList: List<MusicGenreList>.from(
            json["music_genre_list"].map((x) => MusicGenreList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "music_genre_list":
            List<dynamic>.from(musicGenreList.map((x) => x.toJson())),
      };
}
