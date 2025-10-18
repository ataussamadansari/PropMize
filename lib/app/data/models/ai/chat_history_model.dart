import '../properties/lists/pagination.dart';
import 'ai_list_model/messages.dart';

class ChatHistoryModel {
  ChatHistoryModel({
      this.success, 
      this.data
  });

  ChatHistoryModel.fromJson(dynamic json) {
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
      this.chats, 
      this.pagination,
  });

  Data.fromJson(dynamic json) {
    if (json['chats'] != null) {
      chats = [];
      json['chats'].forEach((v) {
        chats?.add(Chats.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Chats>? chats;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (chats != null) {
      map['chats'] = chats?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

  // ✅ Add copyWith
  Data copyWith({
    List<Chats>? chats,
    Pagination? pagination,
  }) {
    return Data(
      chats: chats ?? this.chats,
      pagination: pagination ?? this.pagination,
    );
  }

}

class Chats {
  Chats({
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

  Chats.fromJson(dynamic json) {
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

extension ChatsCopyWith on Chats {
  Chats copyWith({
    String? id,
    String? user,
    String? sessionId,
    String? title,
    List<Messages>? messages,
    String? status,
    List<RelatedProperties>? relatedProperties,
    List<RelatedLeads>? relatedLeads,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return Chats(
      id: id ?? this.id,
      user: user ?? this.user,
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      status: status ?? this.status,
      relatedProperties: relatedProperties ?? this.relatedProperties,
      relatedLeads: relatedLeads ?? this.relatedLeads,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }
}


class RelatedLeads {
  RelatedLeads({
    this.id,
  });

  RelatedLeads.fromJson(dynamic json) {
    id = json['_id'];
  }
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    return map;
  }
}

class RelatedProperties {
  RelatedProperties({
      this.id, 
      this.title, 
      this.price,});

  RelatedProperties.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    price = json['price'];
  }
  String? id;
  String? title;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['price'] = price;
    return map;
  }
}