part 'form.g.dart';

class Form {
  String name;
  String url;

  Form({required this.name, required this.url});

  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);
}
