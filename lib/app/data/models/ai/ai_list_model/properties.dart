import 'area.dart';
import 'address.dart';
import 'contact.dart';
import 'contacted_by.dart';
import 'seo.dart';
import 'pricing.dart';
import 'features.dart';
import 'near_by_places.dart';
import 'viewed_by.dart';
import 'liked_by.dart';

class Properties {
  Properties({
    this.area,
    this.address,
    this.seo,
    this.pricing,
    this.contact,
    this.features,
    this.nearbyPlaces,
    this.id,
    this.title,
    this.description,
    this.propertyType,
    this.listingType,
    this.price,
    this.currency,
    this.bedrooms,
    this.bathrooms,
    this.balconies,
    this.parking,
    this.furnished,
    this.floor,
    this.totalFloors,
    this.age,
    this.images,
    this.videos,
    this.amenities,
    this.seller,
    this.status,
    this.featured,
    this.premium,
    this.views,
    this.likes,
    this.leads,
    this.approvalStatus,
    this.notes,
    this.viewedBy,
    this.likedBy,
    this.contactedBy,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
    this.v,});

  Properties.fromJson(dynamic json) {
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
    pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    features = json['features'] != null ? Features.fromJson(json['features']) : null;
    nearbyPlaces = json['nearbyPlaces'] != null ? NearbyPlaces.fromJson(json['nearbyPlaces']) : null;
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    propertyType = json['propertyType'];
    listingType = json['listingType'];
    price = json['price'];
    currency = json['currency'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    balconies = json['balconies'];
    parking = json['parking'];
    furnished = json['furnished'];
    floor = json['floor'];
    totalFloors = json['totalFloors'];
    age = json['age'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    videos = json['videos'] != null ? json['videos'].cast<String>() : [];
    amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
    seller = json['seller'];
    status = json['status'];
    featured = json['featured'];
    premium = json['premium'];
    views = json['views'];
    likes = json['likes'] != null ? json['likes'].cast<String>() : [];
    leads = json['leads'] != null ? json['leads'].cast<String>() : [];
    approvalStatus = json['approvalStatus'];
    notes = json['notes'];
    if (json['viewedBy'] != null) {
      viewedBy = [];
      json['viewedBy'].forEach((v) {
        viewedBy?.add(ViewedBy.fromJson(v));
      });
    }
    if (json['likedBy'] != null) {
      likedBy = [];
      json['likedBy'].forEach((v) {
        likedBy?.add(LikedBy.fromJson(v));
      });
    }
    if (json['contactedBy'] != null)
    {
      contactedBy = [];
      json['contactedBy'].forEach((v)
      {
        contactedBy?.add(ContactedBy.fromJson(v));
      }
      );
    }
    expiresAt = json['expiresAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  Area? area;
  Address? address;
  Seo? seo;
  Pricing? pricing;
  Contact? contact;
  Features? features;
  NearbyPlaces? nearbyPlaces;
  String? id;
  String? title;
  String? description;
  String? propertyType;
  String? listingType;
  int? price;
  String? currency;
  int? bedrooms;
  int? bathrooms;
  int? balconies;
  int? parking;
  String? furnished;
  int? floor;
  int? totalFloors;
  int? age;
  List<String>? images;
  List<String>? videos;
  List<String>? amenities;
  String? seller;
  String? status;
  bool? featured;
  bool? premium;
  int? views;
  List<String>? likes;
  List<String>? leads;
  String? approvalStatus;
  String? notes;
  List<ViewedBy>? viewedBy;
  List<LikedBy>? likedBy;
  List<dynamic>? contactedBy;
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
    if (seo != null) {
      map['seo'] = seo?.toJson();
    }
    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
    if (contact != null) {
      map['contact'] = contact?.toJson();
    }
    if (features != null) {
      map['features'] = features?.toJson();
    }
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
    map['bedrooms'] = bedrooms;
    map['bathrooms'] = bathrooms;
    map['balconies'] = balconies;
    map['parking'] = parking;
    map['furnished'] = furnished;
    map['floor'] = floor;
    map['totalFloors'] = totalFloors;
    map['age'] = age;
    map['images'] = images;
    map['videos'] = videos;
    map['amenities'] = amenities;
    map['seller'] = seller;
    map['status'] = status;
    map['featured'] = featured;
    map['premium'] = premium;
    map['views'] = views;
    map['likes'] = likes;
    map['leads'] = leads;
    map['approvalStatus'] = approvalStatus;
    map['notes'] = notes;
    if (viewedBy != null) {
      map['viewedBy'] = viewedBy?.map((v) => v.toJson()).toList();
    }
    if (likedBy != null) {
      map['likedBy'] = likedBy?.map((v) => v.toJson()).toList();
    }
    if (contactedBy != null) {
      map['contactedBy'] = contactedBy?.map((v) => v.toJson()).toList();
    }
    map['expiresAt'] = expiresAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}