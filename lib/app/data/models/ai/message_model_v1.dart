class MessageModelV1 {
  MessageModelV1({
      this.success, 
      this.data,});

  MessageModelV1.fromJson(dynamic json) {
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
      this.role, 
      this.content, 
      this.timestamp, 
      this.properties, 
      this.suggestions,});

  Data.fromJson(dynamic json) {
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
  }
  String? role;
  String? content;
  String? timestamp;
  List<Properties>? properties;
  List<String>? suggestions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['role'] = role;
    map['content'] = content;
    map['timestamp'] = timestamp;
    if (properties != null) {
      map['properties'] = properties?.map((v) => v.toJson()).toList();
    }
    map['suggestions'] = suggestions;
    return map;
  }

}

class Properties {
  Properties({
      this.id, 
      this.title, 
      this.price, 
      this.images, 
      this.address, 
      this.likes, 
      this.views,});

  Properties.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    address = json['address'];
    likes = json['likes'];
    views = json['views'];
  }
  String? id;
  String? title;
  int? price;
  List<String>? images;
  String? address;
  int? likes;
  int? views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['images'] = images;
    map['address'] = address;
    map['likes'] = likes;
    map['views'] = views;
    return map;
  }

}