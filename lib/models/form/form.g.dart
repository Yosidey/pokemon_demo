
part of'form.dart';

Form _$FormFromJson(Map<String, dynamic> json) => Form(

  name: json['name'] as String,
  url: json['url'] as String,
);