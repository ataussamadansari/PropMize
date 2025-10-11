class LikeModel {
  LikeModel({
      this.success, 
      this.liked, 
      this.message,});

  LikeModel.fromJson(dynamic json) {
    success = json['success'];
    liked = json['liked'];
    message = json['message'];
  }
  bool? success;
  bool? liked;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['liked'] = liked;
    map['message'] = message;
    return map;
  }
}