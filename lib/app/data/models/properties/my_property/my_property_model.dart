class MyPropertyModel {
  MyPropertyModel({
      this.success, 
      this.count, 
      this.pagination, 
      this.data,});

  MyPropertyModel.fromJson(dynamic json) {
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
      this.area,
      this.address,
      this.pricing,
      this.features,
      this.nearbyPlaces,
      this.id, 
      this.title, 
      this.description, 
      this.propertyType, 
      this.listingType,
      this.status,
      this.price, 
      this.currency,
      this.images, 
      this.videos,
      this.featured, 
      this.premium, 
      this.views,
      this.approvalStatus,
      this.expiresAt, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});

  Data.fromJson(dynamic json) {
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    features = json['features'] != null ? Features.fromJson(json['features']) : null;
    nearbyPlaces = json['nearbyPlaces'] != null ? NearbyPlaces.fromJson(json['nearbyPlaces']) : null;
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    propertyType = json['propertyType'];
    listingType = json['listingType'];
    price = json['price'];
    currency = json['currency'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    videos = json['videos'] != null ? json['videos'].cast<String>() : [];
    featured = json['featured'];
    premium = json['premium'];
    status = json['status'];
    views = json['views'];
    approvalStatus = json['approvalStatus'];
    expiresAt = json['expiresAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  Area? area;
  Address? address;
  Pricing? pricing;
  Features? features;
  NearbyPlaces? nearbyPlaces;
  String? id;
  String? title;
  String? description;
  String? propertyType;
  String? listingType;
  int? price;
  String? currency;
  List<String>? images;
  List<String>? videos;
  bool? featured;
  bool? premium;
  int? views;
  String? status;
  String? approvalStatus;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (area != null) {
      map['area'] = area?.toJson();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }

    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
    if (features != null) {
      map['features'] = features?.toJson();
    }
    map['status'] = status;
    if (nearbyPlaces != null) {
      map['nearbyPlaces'] = nearbyPlaces?.toJson();
    }
    map['_id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['propertyType'] = propertyType;
    map['listingType'] = listingType;
    map['price'] = price;
    map['currency'] = currency;
    map['images'] = images;
    map['videos'] = videos;
    map['featured'] = featured;
    map['premium'] = premium;
    map['views'] = views;
    map['approvalStatus'] = approvalStatus;
    map['expiresAt'] = expiresAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

class ContactedBy {
  ContactedBy({
      this.user, 
      this.contactedAt, 
      this.id,});

  ContactedBy.fromJson(dynamic json) {
    user = json['user'];
    contactedAt = json['contactedAt'];
    id = json['_id'];
  }
  String? user;
  String? contactedAt;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['contactedAt'] = contactedAt;
    map['_id'] = id;
    return map;
  }

}

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

class ViewedBy {
  ViewedBy({
      this.user, 
      this.viewedAt, 
      this.id,});

  ViewedBy.fromJson(dynamic json) {
    user = json['user'];
    viewedAt = json['viewedAt'];
    id = json['_id'];
  }
  String? user;
  String? viewedAt;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['viewedAt'] = viewedAt;
    map['_id'] = id;
    return map;
  }

}

class NearbyPlaces {
  NearbyPlaces({
      this.schools, 
      this.hospitals, 
      this.malls, 
      this.transport,});

  NearbyPlaces.fromJson(dynamic json) {
    if (json['schools'] != null) {
      schools = [];
      json['schools'].forEach((v) {
        schools?.add(Schools.fromJson(v));
      });
    }
    if (json['hospitals'] != null) {
      hospitals = [];
      json['hospitals'].forEach((v) {
        hospitals?.add(Hospitals.fromJson(v));
      });
    }
    if (json['malls'] != null) {
      malls = [];
      json['malls'].forEach((v) {
        malls?.add(Malls.fromJson(v));
      });
    }
    if (json['transport'] != null) {
      transport = [];
      json['transport'].forEach((v) {
        transport?.add(Transport.fromJson(v));
      });
    }
  }
  List<Schools>? schools;
  List<Hospitals>? hospitals;
  List<Malls>? malls;
  List<Transport>? transport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (schools != null) {
      map['schools'] = schools?.map((v) => v.toJson()).toList();
    }
    if (hospitals != null) {
      map['hospitals'] = hospitals?.map((v) => v.toJson()).toList();
    }
    if (malls != null) {
      map['malls'] = malls?.map((v) => v.toJson()).toList();
    }
    if (transport != null) {
      map['transport'] = transport?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Transport {
  Transport({
      this.name, 
      this.distance, 
      this.unit, 
      this.id,});

  Transport.fromJson(dynamic json) {
    name = json['name'];
    distance = json['distance'];
    unit = json['unit'];
    id = json['_id'];
  }
  String? name;
  int? distance;
  String? unit;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['distance'] = distance;
    map['unit'] = unit;
    map['_id'] = id;
    return map;
  }

}

class Malls {
  Malls({
      this.name, 
      this.distance, 
      this.unit, 
      this.id,});

  Malls.fromJson(dynamic json) {
    name = json['name'];
    distance = json['distance'];
    unit = json['unit'];
    id = json['_id'];
  }
  String? name;
  int? distance;
  String? unit;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['distance'] = distance;
    map['unit'] = unit;
    map['_id'] = id;
    return map;
  }

}

class Hospitals {
  Hospitals({
      this.name, 
      this.distance, 
      this.unit, 
      this.id,});

  Hospitals.fromJson(dynamic json) {
    name = json['name'];
    distance = json['distance'];
    unit = json['unit'];
    id = json['_id'];
  }
  String? name;
  int? distance;
  String? unit;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['distance'] = distance;
    map['unit'] = unit;
    map['_id'] = id;
    return map;
  }

}

class Schools {
  Schools({
      this.name, 
      this.distance, 
      this.unit, 
      this.id,});

  Schools.fromJson(dynamic json) {
    name = json['name'];
    distance = json['distance'];
    unit = json['unit'];
    id = json['_id'];
  }
  String? name;
  int? distance;
  String? unit;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['distance'] = distance;
    map['unit'] = unit;
    map['_id'] = id;
    return map;
  }

}

class Features {
  Features({
      this.facing, 
      this.flooringType, 
      this.waterSupply, 
      this.powerBackup, 
      this.servantRoom, 
      this.poojaRoom, 
      this.studyRoom, 
      this.storeRoom, 
      this.garden, 
      this.swimmingPool, 
      this.gym, 
      this.lift, 
      this.security,});

  Features.fromJson(dynamic json) {
    facing = json['facing'];
    flooringType = json['flooringType'];
    waterSupply = json['waterSupply'];
    powerBackup = json['powerBackup'];
    servantRoom = json['servantRoom'];
    poojaRoom = json['poojaRoom'];
    studyRoom = json['studyRoom'];
    storeRoom = json['storeRoom'];
    garden = json['garden'];
    swimmingPool = json['swimmingPool'];
    gym = json['gym'];
    lift = json['lift'];
    security = json['security'];
  }
  String? facing;
  String? flooringType;
  String? waterSupply;
  bool? powerBackup;
  bool? servantRoom;
  bool? poojaRoom;
  bool? studyRoom;
  bool? storeRoom;
  bool? garden;
  bool? swimmingPool;
  bool? gym;
  bool? lift;
  bool? security;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facing'] = facing;
    map['flooringType'] = flooringType;
    map['waterSupply'] = waterSupply;
    map['powerBackup'] = powerBackup;
    map['servantRoom'] = servantRoom;
    map['poojaRoom'] = poojaRoom;
    map['studyRoom'] = studyRoom;
    map['storeRoom'] = storeRoom;
    map['garden'] = garden;
    map['swimmingPool'] = swimmingPool;
    map['gym'] = gym;
    map['lift'] = lift;
    map['security'] = security;
    return map;
  }

}

class Contact {
  Contact({
      this.name, 
      this.phone, 
      this.whatsapp, 
      this.type,});

  Contact.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    type = json['type'];
  }
  String? name;
  String? phone;
  String? whatsapp;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['whatsapp'] = whatsapp;
    map['type'] = type;
    return map;
  }

}

class Pricing {
  Pricing({
      this.basePrice, 
      this.maintenanceCharges, 
      this.securityDeposit, 
      this.priceNegotiable,});

  Pricing.fromJson(dynamic json) {
    basePrice = json['basePrice'];
    maintenanceCharges = json['maintenanceCharges'];
    securityDeposit = json['securityDeposit'];
    priceNegotiable = json['priceNegotiable'];
  }
  int? basePrice;
  int? maintenanceCharges;
  int? securityDeposit;
  bool? priceNegotiable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['basePrice'] = basePrice;
    map['maintenanceCharges'] = maintenanceCharges;
    map['securityDeposit'] = securityDeposit;
    map['priceNegotiable'] = priceNegotiable;
    return map;
  }

}

class Seo {
  Seo({
      this.metaTitle, 
      this.metaDescription, 
      this.slug,});

  Seo.fromJson(dynamic json) {
    metaTitle = json['metaTitle'];
    metaDescription = json['metaDescription'];
    slug = json['slug'];
  }
  String? metaTitle;
  String? metaDescription;
  String? slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['metaTitle'] = metaTitle;
    map['metaDescription'] = metaDescription;
    map['slug'] = slug;
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

class SuperBuildUpArea {
  SuperBuildUpArea({
      this.value, 
      this.unit,});

  SuperBuildUpArea.fromJson(dynamic json) {
    value = json['value'];
    unit = json['unit'];
  }
  int? value;
  String? unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['unit'] = unit;
    return map;
  }

}

class BuildUpArea {
  BuildUpArea({
      this.value, 
      this.unit,});

  BuildUpArea.fromJson(dynamic json) {
    value = json['value'];
    unit = json['unit'];
  }
  int? value;
  String? unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['unit'] = unit;
    return map;
  }

}

class Area {
  Area({
      this.value, 
      this.unit,});

  Area.fromJson(dynamic json) {
    value = json['value'];
    unit = json['unit'];
  }
  int? value;
  String? unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['unit'] = unit;
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