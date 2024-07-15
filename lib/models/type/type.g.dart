part of 'type.dart';

TypeDetail _$TypeDetailFromJson(Map<String, dynamic> json) => TypeDetail(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      type: TypeDetail.fromJson(json["type"]),
      slot: json["slot"],
    );
