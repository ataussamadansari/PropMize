import 'lists/pagination.dart';
import 'data.dart';

class PropertiesModel {
  PropertiesModel({
    this.success,
    this.count,
    this.pagination,
    this.data
  });

  PropertiesModel.fromJson(dynamic json) {
    success = json['success'];
    count = json['count'];
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  int? count;
  Pagination? pagination;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['count'] = count;
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
