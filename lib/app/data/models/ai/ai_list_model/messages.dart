import 'package:prop_mize/app/data/models/ai/ai_list_model/properties.dart';

class Messages {
  Messages({
    this.role,
    this.content,
    this.timestamp,
    this.suggestions,
    this.id,
    this.properties,
  });

  Messages.fromJson(dynamic json) {
    role = json['role'];
    content = json['content'];
    timestamp = json['timestamp'];
    if (json['properties'] != null) {
      properties = [];
      json['properties'].forEach((v) {
        properties?.add(Properties.fromJson(v));
      });
    }
    suggestions = json['suggestions'] != null ? json['suggestions'].cast<String>() : [];
    id = json['_id'];
  }
  String? role;
  String? content;
  String? timestamp;
  List<Properties>? properties;
  List<String>? suggestions;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    map['timestamp'] = timestamp;
    if (properties != null) {
      map['properties'] = properties?.map((v) => v.toJson()).toList();
    }
    map['suggestions'] = suggestions;
    map['_id'] = id;
    return map;
  }
}