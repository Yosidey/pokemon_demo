
part 'stat.g.dart';

class StatDetail {
  final String name;
  final String url;

  StatDetail({
    required this.name,
    required this.url,
  });


  factory StatDetail.fromJson(Map<String, dynamic> json) => _$StatDetailFromJson(json);
}
class Stat {
  final int baseStat;
  final int effort;
  final StatDetail stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
}


