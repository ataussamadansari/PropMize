import 'package:prop_mize/app/data/models/ai/ai_list_model/messages.dart';
import 'package:prop_mize/app/data/models/ai/ai_list_model/related_leads.dart';
import 'package:prop_mize/app/data/models/ai/ai_list_model/related_properties.dart';

class Data {
  Data({
    this.id,
    this.user,
    this.sessionId,
    this.title,
    this.messages,
    this.status,
    this.relatedProperties,
    this.relatedLeads,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'];
    sessionId = json['sessionId'];
    title = json['title'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
    status = json['status'];
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
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? user;
  String? sessionId;
  String? title;
  List<Messages>? messages;
  String? status;
  List<RelatedProperties>? relatedProperties;
  List<RelatedLeads>? relatedLeads;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
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
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}