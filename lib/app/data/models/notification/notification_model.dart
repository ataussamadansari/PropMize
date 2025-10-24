class NotificationModel {
  NotificationModel({
      this.success, 
      this.data, 
      this.pagination,});

  NotificationModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  bool? success;
  List<Data>? data;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

class Pagination {
  Pagination({
      this.page, 
      this.limit, 
      this.total, 
      this.pages,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    pages = json['pages'];
  }
  int? page;
  int? limit;
  int? total;
  int? pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['pages'] = pages;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.userId, 
      this.title, 
      this.message, 
      this.type, 
      this.read, 
      this.actionUrl, 
      this.metadata, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['userId'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    read = json['read'];
    actionUrl = json['actionUrl'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? userId;
  String? title;
  String? message;
  String? type;
  bool? read;
  String? actionUrl;
  Metadata? metadata;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userId'] = userId;
    map['title'] = title;
    map['message'] = message;
    map['type'] = type;
    map['read'] = read;
    map['actionUrl'] = actionUrl;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

class Metadata {
  Metadata({
      this.propertyId,
      this.propertyTitle,
  });

  Metadata.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    propertyTitle = json['propertyTitle'];
  }
  String? propertyId;
  String? propertyTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['propertyTitle'] = propertyTitle;
    return map;
  }

}