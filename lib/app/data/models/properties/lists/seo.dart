
class Seo
{
  Seo({
    this.metaTitle,
    this.metaDescription,
    this.slug});

  Seo.fromJson(dynamic json)
  {
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
    slug = json['slug'];
  }
  String? metaTitle;
  String? metaDescription;
  String? slug;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['metaTitle'] = metaTitle;
    map['metaDescription'] = metaDescription;
    map['slug'] = slug;
    return map;
  }

}
