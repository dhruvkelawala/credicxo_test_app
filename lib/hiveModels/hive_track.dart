import 'package:hive/hive.dart';

part 'hive_track.g.dart';

@HiveType(typeId: 1)
class HiveTrack extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  HiveTrack({this.id, this.name});
}
