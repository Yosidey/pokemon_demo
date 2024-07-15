part 'type.g.dart';

class TypeDetail {
  String name;
  String url;

  TypeDetail({
    required this.name,
    required this.url,
  });

  factory TypeDetail.fromJson(Map<String, dynamic> json) => _$TypeDetailFromJson(json);
}

class Type {
  int slot;
  TypeDetail type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
}
