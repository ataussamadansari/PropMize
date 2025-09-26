class UserModel {
  UserModel({
      this.success, 
      this.data,
  });

  UserModel.fromJson(dynamic json) {
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
      this.tokens, 
      this.cookieSettings,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    cookieSettings = json['cookieSettings'] != null ? CookieSettings.fromJson(json['cookieSettings']) : null;
  }
  User? user;
  Tokens? tokens;
  CookieSettings? cookieSettings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    if (cookieSettings != null) {
      map['cookieSettings'] = cookieSettings?.toJson();
    }
    return map;
  }

}

class CookieSettings {
  CookieSettings({
      this.expires, 
      this.httpOnly, 
      this.sameSite, 
      this.secure, 
      this.path,});

  CookieSettings.fromJson(dynamic json) {
    expires = json['expires'];
    httpOnly = json['httpOnly'];
    sameSite = json['sameSite'];
    secure = json['secure'];
    path = json['path'];
  }
  String? expires;
  bool? httpOnly;
  String? sameSite;
  bool? secure;
  String? path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expires'] = expires;
    map['httpOnly'] = httpOnly;
    map['sameSite'] = sameSite;
    map['secure'] = secure;
    map['path'] = path;
    return map;
  }

}

class Tokens {
  Tokens({
      this.accessToken, 
      this.refreshToken,});

  Tokens.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.role, 
      this.avatar, 
      this.isEmailVerified, 
      this.isPhoneVerified, 
      this.isPremium, 
      this.premiumExpiresAt, 
      this.address, 
      this.preferences, 
      this.lastLogin, 
      this.createdAt,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    avatar = json['avatar'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    isPremium = json['isPremium'];
    premiumExpiresAt = json['premiumExpiresAt'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    preferences = json['preferences'] != null ? Preferences.fromJson(json['preferences']) : null;
    lastLogin = json['lastLogin'];
    createdAt = json['createdAt'];
  }
  String? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  dynamic avatar;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  bool? isPremium;
  dynamic premiumExpiresAt;
  Address? address;
  Preferences? preferences;
  String? lastLogin;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['role'] = role;
    map['avatar'] = avatar;
    map['isEmailVerified'] = isEmailVerified;
    map['isPhoneVerified'] = isPhoneVerified;
    map['isPremium'] = isPremium;
    map['premiumExpiresAt'] = premiumExpiresAt;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (preferences != null) {
      map['preferences'] = preferences?.toJson();
    }
    map['lastLogin'] = lastLogin;
    map['createdAt'] = createdAt;
    return map;
  }

}


class Preferences {
  PriceRange? priceRange;
  Notifications? notifications;
  List<String>? propertyTypes;
  List<String>? locations;

  Preferences({this.priceRange, this.notifications, this.propertyTypes, this.locations});

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      priceRange: json['priceRange'] != null ? PriceRange.fromJson(json['priceRange']) : null,
      notifications: json['notifications'] != null ? Notifications.fromJson(json['notifications']) : null,
      propertyTypes: json['propertyTypes'] != null
          ? List<String>.from((json['propertyTypes'] as List).map((e) => e.toString()))
          : null,
      locations: json['locations'] != null
          ? List<String>.from((json['locations'] as List).map((e) => e.toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'priceRange': priceRange?.toJson(),
    'notifications': notifications?.toJson(),
    'propertyTypes': propertyTypes,
    'locations': locations,
  };
}

class Notifications {
  Notifications({
      this.email, 
      this.sms, 
      this.push,});

  Notifications.fromJson(dynamic json) {
    email = json['email'];
    sms = json['sms'];
    push = json['push'];
  }
  bool? email;
  bool? sms;
  bool? push;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['sms'] = sms;
    map['push'] = push;
    return map;
  }

}

class PriceRange {
  PriceRange({
      this.min, 
      this.max,});

  PriceRange.fromJson(dynamic json) {
    min = json['min'];
    max = json['max'];
  }
  int? min;
  int? max;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['min'] = min;
    map['max'] = max;
    return map;
  }

}

class Address {
  Address({
      this.country,
      this.city,
      this.state,
      this.street,
      this.zipCode,
  });

  Address.fromJson(dynamic json) {
    country = json['country'];
    city = json['city'];
    state = json['state'];
    street = json['street'];
    zipCode = json['zipCode'];
  }
  String? country;
  String? city;
  String? state;
  String? street;
  String? zipCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country'] = country;
    map['city'] = city;
    map['state'] = state;
    map['street'] = street;
    map['zipCode'] = zipCode;
    return map;
  }

}