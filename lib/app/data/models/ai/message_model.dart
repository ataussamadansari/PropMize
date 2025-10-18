class MessageModel {
  final bool? success;
  final Data? data;

  MessageModel({this.success, this.data});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Data {
  final Chat? chat;

  Data({this.chat});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      chat: json['chat'] != null ? Chat.fromJson(json['chat']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat': chat?.toJson(),
    };
  }
}

class AiMetadata {
  final String? model;
  final int? tokensUsed;
  final int? responseTime;
  final double? confidence;

  AiMetadata({this.model, this.tokensUsed, this.responseTime, this.confidence});

  factory AiMetadata.fromJson(Map<String, dynamic> json) {
    return AiMetadata(
      model: json['model'],
      tokensUsed: json['tokensUsed'],
      responseTime: json['responseTime'],
      confidence: json['confidence']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'tokensUsed': tokensUsed,
      'responseTime': responseTime,
      'confidence': confidence,
    };
  }
}


class Chat {
  final Context? context;
  final String? id;
  final String? user;
  final String? sessionId;
  final String? title;
  final List<ChatMessage>? messages;
  final String? status;
  final List<String>? relatedProperties;
  final List<dynamic>? relatedLeads;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Chat({
    this.context,
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
    this.v,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      context: json['context'] != null ? Context.fromJson(json['context']) : null,
      id: json['_id'],
      user: json['user'],
      sessionId: json['sessionId'],
      title: json['title'],
      messages: json['messages'] != null
          ? List<ChatMessage>.from(json['messages'].map((x) => ChatMessage.fromJson(x)))
          : null,
      status: json['status'],
      relatedProperties: json['relatedProperties'] != null
          ? List<String>.from(json['relatedProperties'])
          : null,
      relatedLeads: json['relatedLeads'] != null
          ? List<dynamic>.from(json['relatedLeads'])
          : null,
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'context': context?.toJson(),
      '_id': id,
      'user': user,
      'sessionId': sessionId,
      'title': title,
      'messages': messages?.map((x) => x.toJson()).toList(),
      'status': status,
      'relatedProperties': relatedProperties,
      'relatedLeads': relatedLeads,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class ChatMessage {
  final String? role;
  final String? content;
  final String? timestamp;
  final List<dynamic>? properties;
  final List<dynamic>? suggestions;
  final String? id;

  ChatMessage({
    this.role,
    this.content,
    this.timestamp,
    this.properties,
    this.suggestions,
    this.id,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      role: json['role'],
      content: json['content'],
      timestamp: json['timestamp'],
      properties: json['properties'] != null
          ? (json['properties'] as List).map((e) {
        if (e is Map<String, dynamic>) {
          // agar full object aaya to wahi forward kar do
          return e;
        } else {
          // agar sirf ek string/id aayi to safe Map bana do
          return {"_id": e.toString(), "title": e.toString()};
        }
      }).toList()
          : [],
      suggestions: json['suggestions'] != null
          ? List<String>.from(json['suggestions'])
          : [],
      id: json['_id'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp,
      'properties': properties,
      'suggestions': suggestions,
      '_id': id,
    };
  }
}

extension MessagesMapper on ChatMessage {
  ChatMessage toChatMessage() {
    return ChatMessage(
      role: role,
      content: content,
      timestamp: timestamp,
      properties: properties,
      suggestions: suggestions,
      id: id,
    );
  }
}


class Context {
  final PropertySearch? propertySearch;
  final UserPreferences? userPreferences;
  final String? conversationType;

  Context({this.propertySearch, this.userPreferences, this.conversationType});

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      propertySearch: json['propertySearch'] != null
          ? PropertySearch.fromJson(json['propertySearch'])
          : null,
      userPreferences: json['userPreferences'] != null
          ? UserPreferences.fromJson(json['userPreferences'])
          : null,
      conversationType: json['conversationType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertySearch': propertySearch?.toJson(),
      'userPreferences': userPreferences?.toJson(),
      'conversationType': conversationType,
    };
  }
}

class PropertySearch {
  final List<dynamic>? amenities;

  PropertySearch({this.amenities});

  factory PropertySearch.fromJson(Map<String, dynamic> json) {
    return PropertySearch(
      amenities: json['amenities'] != null
          ? List<dynamic>.from(json['amenities'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amenities': amenities,
    };
  }
}

class UserPreferences {
  final List<dynamic>? preferredLocations;
  final List<dynamic>? propertyTypes;
  final List<dynamic>? mustHaveAmenities;

  UserPreferences({
    this.preferredLocations,
    this.propertyTypes,
    this.mustHaveAmenities,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      preferredLocations: json['preferredLocations'] != null
          ? List<dynamic>.from(json['preferredLocations'])
          : null,
      propertyTypes: json['propertyTypes'] != null
          ? List<dynamic>.from(json['propertyTypes'])
          : null,
      mustHaveAmenities: json['mustHaveAmenities'] != null
          ? List<dynamic>.from(json['mustHaveAmenities'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preferredLocations': preferredLocations,
      'propertyTypes': propertyTypes,
      'mustHaveAmenities': mustHaveAmenities,
    };
  }
}



