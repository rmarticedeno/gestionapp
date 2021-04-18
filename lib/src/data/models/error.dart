import 'package:json_annotation/json_annotation.dart';

import 'package:gestionuh/src/data/models/base_model.dart';

part 'error.g.dart';

@JsonSerializable(explicitToJson: true)
class Error extends BaseModel {
  int? code;
  String? message;

  Error({this.code, this.message});

  static Error fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
}
