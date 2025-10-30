class LeadsModel {
  LeadsModel({
      this.success, 
      this.count, 
      this.meta, 
      this.data,});

  LeadsModel.fromJson(dynamic json) {
    success = json['success'];
    count = json['count'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  int? count;
  Meta? meta;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['count'] = count;
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
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
    seller = json['seller'];
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
  String? seller;
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
    map['seller'] = seller;
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

class Buyer {
  Buyer({
      this.id, 
      this.phone, 
      this.avatar, 
      this.email, 
      this.name,});

  Buyer.fromJson(dynamic json) {
    id = json['_id'];
    phone = json['phone'];
    avatar = json['avatar'];
    email = json['email'];
    name = json['name'];
  }
  String? id;
  String? phone;
  String? avatar;
  String? email;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['phone'] = phone;
    map['avatar'] = avatar;
    map['email'] = email;
    map['name'] = name;
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

class Meta {
  Meta({
      this.page, 
      this.limit, 
      this.total, 
      this.totalPages,});

  Meta.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['totalPages'] = totalPages;
    return map;
  }

}