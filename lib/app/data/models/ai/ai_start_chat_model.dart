import 'ai_list_model/data.dart';

class AiStartChatModel {
  AiStartChatModel({
    this.success,
    this.data,
  });

  AiStartChatModel.fromJson(dynamic json) {
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






/*
import 'package:prop_mize/app/data/models/ai/chat_history_model.dart';

import 'messages.dart';

class AiStartChatModel {
  AiStartChatModel({
      this.success, 
      this.data
  });

  AiStartChatModel.fromJson(dynamic json) {
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

class Data {
  Data({
      this.user, 
      this.sessionId, 
      this.title,
      this.messages, 
      this.status,
      this.isActive, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    user = json['user'];
    sessionId = json['sessionId'];
    title = json['title'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
    if (json['relatedProperties'] != null) {
      relatedProperties = [];
      json['relatedProperties'].forEach((v) {
        relatedProperties?.add(RelatedProperties.fromJson(v));
      });
    }
    if (json['relatedLeads'] != null) {
      relatedLeads = [];
      json['relatedLeads'].forEach((v) {
        relatedLeads?.add(RelatedLeads.fromJson(v));
      });
    }
    status = json['status'];
    isActive = json['isActive'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? user;
  String? sessionId;
  String? title;
  List<Messages>? messages;
  String? status;
  List<RelatedProperties>? relatedProperties;
  List<RelatedLeads>? relatedLeads;
  bool? isActive;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['sessionId'] = sessionId;
    map['title'] = title;
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    if (relatedProperties != null) {
      map['relatedProperties'] = relatedProperties?.map((v) => v.toJson()).toList();
    }
    if (relatedLeads != null) {
      map['relatedLeads'] = relatedLeads?.map((v) => v.toJson()).toList();
    }
    map['isActive'] = isActive;
    map['_id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

*/
