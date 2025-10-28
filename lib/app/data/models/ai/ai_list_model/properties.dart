class Properties {
  Properties({
    this.id,
    this.title,
    this.price,
    this.images,
    this.address,
    this.views,
    this.likes,
    // this.area,
    // this.seo,
    // this.pricing,
    // this.contact,
    // this.features,
    // this.nearbyPlaces,
    // this.description,
    // this.propertyType,
    // this.listingType,
    // this.currency,
    // this.bedrooms,
    // this.bathrooms,
    // this.balconies,
    // this.parking,
    // this.furnished,
    // this.floor,
    // this.totalFloors,
    // this.age,
    // this.videos,
    // this.amenities,
    // this.seller,
    // this.status,
    // this.featured,
    // this.premium,
    // this.leads,
    // this.approvalStatus,
    // this.notes,
    // this.viewedBy,
    // this.likedBy,
    // this.contactedBy,
    // this.expiresAt,
    // this.createdAt,
    // this.updatedAt,
    // this.v,
  });

  Properties.fromJson(dynamic json) {
    // area = json['area'] != null ? Area.fromJson(json['area']) : null;
    // // address = json['address'] != null ? Address.fromJson(json['address']) : null;
    // seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    // pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    // contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    // features = json['features'] != null ? Features.fromJson(json['features']) : null;
    // nearbyPlaces = json['nearbyPlaces'] != null ? NearbyPlaces.fromJson(json['nearbyPlaces']) : null;
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    address = json['address'];
    views = json['views'];
    likes = json['likes'];
    // description = json['description'];
    // propertyType = json['propertyType'];
    // listingType = json['listingType'];
    // currency = json['currency'];
    // bedrooms = json['bedrooms'];
    // bathrooms = json['bathrooms'];
    // balconies = json['balconies'];
    // parking = json['parking'];
    // furnished = json['furnished'];
    // floor = json['floor'];
    // totalFloors = json['totalFloors'];
    // age = json['age'];
    // videos = json['videos'] != null ? json['videos'].cast<String>() : [];
    // amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
    // seller = json['seller'];
    // status = json['status'];
    // featured = json['featured'];
    // premium = json['premium'];
    // // likes = json['likes'] != null ? json['likes'].cast<String>() : [];
    // leads = json['leads'] != null ? json['leads'].cast<String>() : [];
    // approvalStatus = json['approvalStatus'];
    // notes = json['notes'];
    // if (json['viewedBy'] != null) {
    //   viewedBy = [];
    //   json['viewedBy'].forEach((v) {
    //     viewedBy?.add(ViewedBy.fromJson(v));
    //   });
    // }
    // if (json['likedBy'] != null) {
    //   likedBy = [];
    //   json['likedBy'].forEach((v) {
    //     likedBy?.add(LikedBy.fromJson(v));
    //   });
    // }
    // if (json['contactedBy'] != null)
    // {
    //   contactedBy = [];
    //   json['contactedBy'].forEach((v)
    //   {
    //     contactedBy?.add(ContactedBy.fromJson(v));
    //   }
    //   );
    // }
    // expiresAt = json['expiresAt'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // v = json['__v'];
  }

  String? id;
  String? title;
  int? price;
  List<String>? images;
  String? address;
  int? views;
  int? likes;
  // //Address? address;
  // Area? area;
  // Seo? seo;
  // Pricing? pricing;
  // Contact? contact;
  // Features? features;
  // NearbyPlaces? nearbyPlaces;
  // String? description;
  // String? propertyType;
  // String? listingType;
  // String? currency;
  // int? bedrooms;
  // int? bathrooms;
  // int? balconies;
  // int? parking;
  // String? furnished;
  // int? floor;
  // int? totalFloors;
  // int? age;
  // List<String>? videos;
  // List<String>? amenities;
  // String? seller;
  // String? status;
  // bool? featured;
  // bool? premium;
  // // List<String>? likes;
  // List<String>? leads;
  // String? approvalStatus;
  // String? notes;
  // List<ViewedBy>? viewedBy;
  // List<LikedBy>? likedBy;
  // List<dynamic>? contactedBy;
  // String? expiresAt;
  // String? createdAt;
  // String? updatedAt;
  // int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // if (area != null) {
    //   map['area'] = area?.toJson();
    // }
    // if (address != null) {
    //   map['address'] = address?.toJson();
    // }
    // if (seo != null) {
    //   map['seo'] = seo?.toJson();
    // }
    // if (pricing != null) {
    //   map['pricing'] = pricing?.toJson();
    // }
    // if (contact != null) {
    //   map['contact'] = contact?.toJson();
    // }
    // if (features != null) {
    //   map['features'] = features?.toJson();
    // }
    // if (nearbyPlaces != null) {
    //   map['nearbyPlaces'] = nearbyPlaces?.toJson();
    // }
    map['_id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['images'] = images;
    map['address'] = address;
    map['views'] = views;
    map['likes'] = likes;
    // map['description'] = description;
    // map['propertyType'] = propertyType;
    // map['listingType'] = listingType;
    // map['currency'] = currency;
    // map['bedrooms'] = bedrooms;
    // map['bathrooms'] = bathrooms;
    // map['balconies'] = balconies;
    // map['parking'] = parking;
    // map['furnished'] = furnished;
    // map['floor'] = floor;
    // map['totalFloors'] = totalFloors;
    // map['age'] = age;
    // map['videos'] = videos;
    // map['amenities'] = amenities;
    // map['seller'] = seller;
    // map['status'] = status;
    // map['featured'] = featured;
    // map['premium'] = premium;
    // map['leads'] = leads;
    // map['approvalStatus'] = approvalStatus;
    // map['notes'] = notes;
    // if (viewedBy != null) {
    //   map['viewedBy'] = viewedBy?.map((v) => v.toJson()).toList();
    // }
    // if (likedBy != null) {
    //   map['likedBy'] = likedBy?.map((v) => v.toJson()).toList();
    // }
    // if (contactedBy != null) {
    //   map['contactedBy'] = contactedBy?.map((v) => v.toJson()).toList();
    // }
    // map['expiresAt'] = expiresAt;
    // map['createdAt'] = createdAt;
    // map['updatedAt'] = updatedAt;
    // map['__v'] = v;
    return map;
  }

}