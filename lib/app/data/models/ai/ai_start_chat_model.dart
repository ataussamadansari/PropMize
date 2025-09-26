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
  List<dynamic>? relatedProperties;
  List<dynamic>? relatedLeads;
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

class Messages {
  Messages({
      this.role, 
      this.content, 
      this.timestamp, 
      this.properties, 
      this.suggestions, 
      this.id,});

  Messages.fromJson(dynamic json) {
    role = json['role'];
    content = json['content'];
    timestamp = json['timestamp'];
    id = json['_id'];
  }
  String? role;
  String? content;
  String? timestamp;
  List<dynamic>? properties;
  List<dynamic>? suggestions;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    map['timestamp'] = timestamp;
    if (properties != null) {
      map['properties'] = properties?.map((v) => v.toJson()).toList();
    }
    if (suggestions != null) {
      map['suggestions'] = suggestions?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    return map;
  }

}
