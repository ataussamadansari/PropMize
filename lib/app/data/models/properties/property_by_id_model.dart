import 'package:prop_mize/app/data/models/properties/data.dart';

class PropertyByIdModel {
  PropertyByIdModel({
      this.success, 
      this.data,});

  PropertyByIdModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}











