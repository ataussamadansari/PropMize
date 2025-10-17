
class LikedBy {
  LikedBy({
    this.user,
    this.likedAt,
    this.id,});

  LikedBy.fromJson(dynamic json) {
    user = json['user'];
    likedAt = json['likedAt'];
    id = json['_id'];
  }
  String? user;
  String? likedAt;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['likedAt'] = likedAt;
    map['_id'] = id;
    return map;
  }

}