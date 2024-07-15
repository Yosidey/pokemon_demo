part of 'stat.dart';

StatDetail _$StatDetailFromJson(Map<String, dynamic> json) => StatDetail(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Stat _$StatFromJson(Map<String, dynamic> json) => Stat(
      stat: StatDetail.fromJson(json["stat"]),
      baseStat: json["base_stat"] as int,
      effort: json["effort"] as int,
    );
