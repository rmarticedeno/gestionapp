import 'package:gestionuh/src/data/models/base_model.dart';

class Status extends BaseModel {
  bool? status;

  Status({this.status});

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
