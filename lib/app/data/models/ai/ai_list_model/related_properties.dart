
class RelatedProperties {
  RelatedProperties({
    this.id,
    this.title,
    this.price,
    this.images,});

  RelatedProperties.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? id;
  String? title;
  int? price;
  List<String>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['images'] = images;
    return map;
  }

}