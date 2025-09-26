import 'user_model.dart';

class UserMe {
  UserMe({
      this.success, 
      this.data,});

  UserMe.fromJson(dynamic json) {
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
      this.address, 
      this.preferences, 
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.role, 
      this.avatar, 
      this.isEmailVerified, 
      this.isPhoneVerified, 
      this.isActive, 
      this.isPremium, 
      this.premiumExpiresAt, 
      this.bio, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.emailVerificationExpire, 
      this.emailVerificationToken, 
      this.lastLogin, 
      this.phoneVerificationExpire, 
      this.phoneVerificationToken,});

  Data.fromJson(dynamic json) {
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    preferences = json['preferences'] != null ? Preferences.fromJson(json['preferences']) : null;
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    avatar = json['avatar'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    isActive = json['isActive'];
    isPremium = json['isPremium'];
    premiumExpiresAt = json['premiumExpiresAt'];
    bio = json['bio'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    emailVerificationExpire = json['emailVerificationExpire'];
    emailVerificationToken = json['emailVerificationToken'];
    lastLogin = json['lastLogin'];
    phoneVerificationExpire = json['phoneVerificationExpire'];
    phoneVerificationToken = json['phoneVerificationToken'];
  }
  Address? address;
  Preferences? preferences;
  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  dynamic avatar;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  bool? isActive;
  bool? isPremium;
  dynamic premiumExpiresAt;
  String? bio;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? emailVerificationExpire;
  String? emailVerificationToken;
  String? lastLogin;
  String? phoneVerificationExpire;
  String? phoneVerificationToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (preferences != null) {
      map['preferences'] = preferences?.toJson();
    }
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['avatar'] = avatar;
    map['isEmailVerified'] = isEmailVerified;
    map['isPhoneVerified'] = isPhoneVerified;
    map['isActive'] = isActive;
    map['isPremium'] = isPremium;
    map['premiumExpiresAt'] = premiumExpiresAt;
    map['bio'] = bio;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['emailVerificationExpire'] = emailVerificationExpire;
    map['emailVerificationToken'] = emailVerificationToken;
    map['lastLogin'] = lastLogin;
    map['phoneVerificationExpire'] = phoneVerificationExpire;
    map['phoneVerificationToken'] = phoneVerificationToken;
    return map;
  }

}
