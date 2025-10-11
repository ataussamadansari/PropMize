class MyInquiriesV0 {
  MyInquiriesV0({
      this.success, 
      this.count, 
      this.pagination, 
      this.data,});

  MyInquiriesV0.fromJson(dynamic json) {
    success = json['success'];
    count = json['count'];
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  int? count;
  Pagination? pagination;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['count'] = count;
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
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
      this.tags, 
      this.notes, 
      this.priority, 
      this.followUps, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    buyerContact = json['buyerContact'] != null ? BuyerContact.fromJson(json['buyerContact']) : null;
    conversion = json['conversion'] != null ? Conversion.fromJson(json['conversion']) : null;
    id = json['_id'];
    property = json['property'] != null ? Property.fromJson(json['property']) : null;
    buyer = json['buyer'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    status = json['status'];
    source = json['source'];
    message = json['message'];
    leadScore = json['leadScore'];
    // if (json['tags'] != null) {
    //   tags = [];
    //   json['tags'].forEach((v) {
    //     tags?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['notes'] != null) {
    //   notes = [];
    //   json['notes'].forEach((v) {
    //     notes?.add(Dynamic.fromJson(v));
    //   });
    // }
    priority = json['priority'];
    // if (json['followUps'] != null) {
    //   followUps = [];
    //   json['followUps'].forEach((v) {
    //     followUps?.add(Dynamic.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  BuyerContact? buyerContact;
  Conversion? conversion;
  String? id;
  Property? property;
  String? buyer;
  Seller? seller;
  String? status;
  String? source;
  String? message;
  int? leadScore;
  List<dynamic>? tags;
  List<dynamic>? notes;
  String? priority;
  List<dynamic>? followUps;
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
    map['buyer'] = buyer;
    if (seller != null) {
      map['seller'] = seller?.toJson();
    }
    map['status'] = status;
    map['source'] = source;
    map['message'] = message;
    map['leadScore'] = leadScore;
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    if (notes != null) {
      map['notes'] = notes?.map((v) => v.toJson()).toList();
    }
    map['priority'] = priority;
    if (followUps != null) {
      map['followUps'] = followUps?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

class Seller {
  Seller({
      this.id, 
      this.phone, 
      this.avatar, 
      this.email, 
      this.name,});

  Seller.fromJson(dynamic json) {
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
      this.images, 
      this.status,});

  Property.fromJson(dynamic json) {
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    status = json['status'];
  }
  Address? address;
  String? id;
  String? title;
  int? price;
  List<String>? images;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['_id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['images'] = images;
    map['status'] = status;
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

class Pagination {
  Pagination({
      this.page, 
      this.limit, 
      this.total, 
      this.pages,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    pages = json['pages'];
  }
  int? page;
  int? limit;
  int? total;
  int? pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['pages'] = pages;
    return map;
  }

}