class LeadDetailsModel {
  LeadDetailsModel({
      this.success, 
      this.data,});

  LeadDetailsModel.fromJson(dynamic json) {
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
      this.buyerContact, 
      this.conversion, 
      this.id, 
      this.property, 
      this.buyer, 
      this.seller, 
      this.status, 
      this.source, 
      this.message, 
      this.leadScore, 
      this.priority, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    buyerContact = json['buyerContact'] != null ? BuyerContact.fromJson(json['buyerContact']) : null;
    conversion = json['conversion'] != null ? Conversion.fromJson(json['conversion']) : null;
    id = json['_id'];
    property = json['property'] != null ? Property.fromJson(json['property']) : null;
    buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    status = json['status'];
    source = json['source'];
    message = json['message'];
    leadScore = json['leadScore'];
    priority = json['priority'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  BuyerContact? buyerContact;
  Conversion? conversion;
  String? id;
  Property? property;
  Buyer? buyer;
  Seller? seller;
  String? status;
  String? source;
  String? message;
  int? leadScore;
  String? priority;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (buyerContact != null) {
      map['buyerContact'] = buyerContact?.toJson();
    }
    if (conversion != null) {
      map['conversion'] = conversion?.toJson();
    }
    map['_id'] = id;
    if (property != null) {
      map['property'] = property?.toJson();
    }
    if (buyer != null) {
      map['buyer'] = buyer?.toJson();
    }
    if (seller != null) {
      map['seller'] = seller?.toJson();
    }
    map['status'] = status;
    map['source'] = source;
    map['message'] = message;
    map['leadScore'] = leadScore;
    map['priority'] = priority;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

class Seller {
  Seller({
      this.id, 
      this.name, 
      this.email, 
      this.avatar, 
      this.phone,});

  Seller.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    phone = json['phone'];
  }
  String? id;
  String? name;
  String? email;
  String? avatar;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    map['phone'] = phone;
    return map;
  }

}

class Buyer {
  Buyer({
      this.id, 
      this.phone, 
      this.avatar, 
      this.name, 
      this.email,});

  Buyer.fromJson(dynamic json) {
    id = json['_id'];
    phone = json['phone'];
    avatar = json['avatar'];
    name = json['name'];
    email = json['email'];
  }
  String? id;
  String? phone;
  String? avatar;
  String? name;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['phone'] = phone;
    map['avatar'] = avatar;
    map['name'] = name;
    map['email'] = email;
    return map;
  }

}

class Property {
  Property({
      this.address, 
      this.id, 
      this.title, 
      this.price, 
      this.images,});

  Property.fromJson(dynamic json) {
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  Address? address;
  String? id;
  String? title;
  int? price;
  List<String>? images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['_id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['images'] = images;
    return map;
  }

}

class Address {
  Address({
      this.street, 
      this.area, 
      this.city, 
      this.state, 
      this.zipCode, 
      this.country, 
      this.landmark,});

  Address.fromJson(dynamic json) {
    street = json['street'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    country = json['country'];
    landmark = json['landmark'];
  }
  String? street;
  String? area;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  String? landmark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['street'] = street;
    map['area'] = area;
    map['city'] = city;
    map['state'] = state;
    map['zipCode'] = zipCode;
    map['country'] = country;
    map['landmark'] = landmark;
    return map;
  }

}

class Conversion {
  Conversion({
      this.isConverted,});

  Conversion.fromJson(dynamic json) {
    isConverted = json['isConverted'];
  }
  bool? isConverted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isConverted'] = isConverted;
    return map;
  }

}

class BuyerContact {
  BuyerContact({
      this.phone, 
      this.contactMethod,});

  BuyerContact.fromJson(dynamic json) {
    phone = json['phone'];
    contactMethod = json['contactMethod'];
  }
  String? phone;
  String? contactMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['contactMethod'] = contactMethod;
    return map;
  }

}