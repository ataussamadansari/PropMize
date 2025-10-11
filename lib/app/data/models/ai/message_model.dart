import 'messages.dart';

class MessageModel {
  final bool? success;
  final Data? data;

  MessageModel({this.success, this.data});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class Data {
  final Chat? chat;

  Data({this.chat});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      chat: json['chat'] != null ? Chat.fromJson(json['chat']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat': chat?.toJson(),
    };
  }
}

class AiMetadata {
  final String? model;
  final int? tokensUsed;
  final int? responseTime;
  final double? confidence;

  AiMetadata({this.model, this.tokensUsed, this.responseTime, this.confidence});

  factory AiMetadata.fromJson(Map<String, dynamic> json) {
    return AiMetadata(
      model: json['model'],
      tokensUsed: json['tokensUsed'],
      responseTime: json['responseTime'],
      confidence: json['confidence']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'tokensUsed': tokensUsed,
      'responseTime': responseTime,
      'confidence': confidence,
    };
  }
}

class Chat {
  final Context? context;
  final String? id;
  final String? user;
  final String? sessionId;
  final String? title;
  final List<ChatMessage>? messages;
  final String? status;
  final List<String>? relatedProperties;
  final List<dynamic>? relatedLeads;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Chat({
    this.context,
    this.id,
    this.user,
    this.sessionId,
    this.title,
    this.messages,
    this.status,
    this.relatedProperties,
    this.relatedLeads,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      context: json['context'] != null ? Context.fromJson(json['context']) : null,
      id: json['_id'],
      user: json['user'],
      sessionId: json['sessionId'],
      title: json['title'],
      messages: json['messages'] != null
          ? List<ChatMessage>.from(json['messages'].map((x) => ChatMessage.fromJson(x)))
          : null,
      status: json['status'],
      relatedProperties: json['relatedProperties'] != null
          ? List<String>.from(json['relatedProperties'])
          : null,
      relatedLeads: json['relatedLeads'] != null
          ? List<dynamic>.from(json['relatedLeads'])
          : null,
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'context': context?.toJson(),
      '_id': id,
      'user': user,
      'sessionId': sessionId,
      'title': title,
      'messages': messages?.map((x) => x.toJson()).toList(),
      'status': status,
      'relatedProperties': relatedProperties,
      'relatedLeads': relatedLeads,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class ChatMessage {
  final String? role;
  final String? content;
  final String? timestamp;
  final List<dynamic>? properties;
  final List<dynamic>? suggestions;
  final String? id;

  ChatMessage({
    this.role,
    this.content,
    this.timestamp,
    this.properties,
    this.suggestions,
    this.id,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      role: json['role'],
      content: json['content'],
      timestamp: json['timestamp'],
      properties: json['properties'] != null
          ? (json['properties'] as List).map((e) {
        if (e is Map<String, dynamic>) {
          // agar full object aaya to wahi forward kar do
          return e;
        } else {
          // agar sirf ek string/id aayi to safe Map bana do
          return {"_id": e.toString(), "title": e.toString()};
        }
      }).toList()
          : [],
      suggestions: json['suggestions'] != null
          ? List<String>.from(json['suggestions'])
          : [],
      id: json['_id'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content,
      'timestamp': timestamp,
      'properties': properties,
      'suggestions': suggestions,
      '_id': id,
    };
  }
}

extension MessagesMapper on Messages {
  ChatMessage toChatMessage() {
    return ChatMessage(
      role: role,
      content: content,
      timestamp: timestamp,
      properties: properties,
      suggestions: suggestions,
      id: id,
    );
  }
}


class Context {
  final PropertySearch? propertySearch;
  final UserPreferences? userPreferences;
  final String? conversationType;

  Context({this.propertySearch, this.userPreferences, this.conversationType});

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      propertySearch: json['propertySearch'] != null
          ? PropertySearch.fromJson(json['propertySearch'])
          : null,
      userPreferences: json['userPreferences'] != null
          ? UserPreferences.fromJson(json['userPreferences'])
          : null,
      conversationType: json['conversationType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'propertySearch': propertySearch?.toJson(),
      'userPreferences': userPreferences?.toJson(),
      'conversationType': conversationType,
    };
  }
}

class PropertySearch {
  final List<dynamic>? amenities;

  PropertySearch({this.amenities});

  factory PropertySearch.fromJson(Map<String, dynamic> json) {
    return PropertySearch(
      amenities: json['amenities'] != null
          ? List<dynamic>.from(json['amenities'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amenities': amenities,
    };
  }
}

class UserPreferences {
  final List<dynamic>? preferredLocations;
  final List<dynamic>? propertyTypes;
  final List<dynamic>? mustHaveAmenities;

  UserPreferences({
    this.preferredLocations,
    this.propertyTypes,
    this.mustHaveAmenities,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      preferredLocations: json['preferredLocations'] != null
          ? List<dynamic>.from(json['preferredLocations'])
          : null,
      propertyTypes: json['propertyTypes'] != null
          ? List<dynamic>.from(json['propertyTypes'])
          : null,
      mustHaveAmenities: json['mustHaveAmenities'] != null
          ? List<dynamic>.from(json['mustHaveAmenities'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preferredLocations': preferredLocations,
      'propertyTypes': propertyTypes,
      'mustHaveAmenities': mustHaveAmenities,
    };
  }
}

// property_model.dart
class Property {
  final Area? area;
  final Address? address;
  final Seo? seo;
  final Pricing? pricing;
  final Contact? contact;
  final Features? features;
  final NearbyPlaces? nearbyPlaces;
  final String? id;
  final String? title;
  final String? description;
  final String? propertyType;
  final String? listingType;
  final int? price;
  final String? currency;
  final int? bedrooms;
  final int? bathrooms;
  final int? balconies;
  final int? parking;
  final String? furnished;
  final int? floor;
  final int? totalFloors;
  final int? age;
  final List<String>? images;
  final List<dynamic>? videos;
  final List<dynamic>? amenities;
  final Seller? seller;
  final String? status;
  final bool? featured;
  final bool? premium;
  final int? views;
  final List<String>? likes;
  final List<dynamic>? leads;
  final String? approvalStatus;
  final String? notes;
  final List<ViewedBy>? viewedBy;
  final List<LikedBy>? likedBy;
  final List<dynamic>? contactedBy;
  final String? expiresAt;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Property({
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
    this.v,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      area: json['area'] != null ? Area.fromJson(json['area']) : null,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      seo: json['seo'] != null ? Seo.fromJson(json['seo']) : null,
      pricing: json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null,
      contact: json['contact'] != null ? Contact.fromJson(json['contact']) : null,
      features: json['features'] != null ? Features.fromJson(json['features']) : null,
      nearbyPlaces: json['nearbyPlaces'] != null
          ? NearbyPlaces.fromJson(json['nearbyPlaces'])
          : null,
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      propertyType: json['propertyType'],
      listingType: json['listingType'],
      price: json['price'],
      currency: json['currency'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      balconies: json['balconies'],
      parking: json['parking'],
      furnished: json['furnished'],
      floor: json['floor'],
      totalFloors: json['totalFloors'],
      age: json['age'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      videos: json['videos'] != null ? List<dynamic>.from(json['videos']) : null,
      amenities: json['amenities'] != null ? List<dynamic>.from(json['amenities']) : null,
      // seller: json['seller'] != null ? Seller.fromJson(json['seller']) : null,
      seller: json['seller'] != null
          ? (json['seller'] is Map<String, dynamic>
          ? Seller.fromJson(json['seller'])
          : Seller(id: json['seller'])) // agar sirf id aayi to custom handling
          : null,

      status: json['status'],
      featured: json['featured'],
      premium: json['premium'],
      views: json['views'],
      likes: json['likes'] != null ? List<String>.from(json['likes']) : null,
      leads: json['leads'] != null ? List<dynamic>.from(json['leads']) : null,
      approvalStatus: json['approvalStatus'],
      notes: json['notes'],
      viewedBy: json['viewedBy'] != null
          ? List<ViewedBy>.from(json['viewedBy'].map((x) => ViewedBy.fromJson(x)))
          : null,
      likedBy: json['likedBy'] != null
          ? List<LikedBy>.from(json['likedBy'].map((x) => LikedBy.fromJson(x)))
          : null,
      contactedBy: json['contactedBy'] != null
          ? List<dynamic>.from(json['contactedBy'])
          : null,
      expiresAt: json['expiresAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area': area?.toJson(),
      'address': address?.toJson(),
      'seo': seo?.toJson(),
      'pricing': pricing?.toJson(),
      'contact': contact?.toJson(),
      'features': features?.toJson(),
      'nearbyPlaces': nearbyPlaces?.toJson(),
      '_id': id,
      'title': title,
      'description': description,
      'propertyType': propertyType,
      'listingType': listingType,
      'price': price,
      'currency': currency,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'balconies': balconies,
      'parking': parking,
      'furnished': furnished,
      'floor': floor,
      'totalFloors': totalFloors,
      'age': age,
      'images': images,
      'videos': videos,
      'amenities': amenities,
      'seller': seller?.toJson(),
      'status': status,
      'featured': featured,
      'premium': premium,
      'views': views,
      'likes': likes,
      'leads': leads,
      'approvalStatus': approvalStatus,
      'notes': notes,
      'viewedBy': viewedBy?.map((x) => x.toJson()).toList(),
      'likedBy': likedBy?.map((x) => x.toJson()).toList(),
      'contactedBy': contactedBy,
      'expiresAt': expiresAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}


class Area {
  final int? value;
  final String? unit;

  Area({this.value, this.unit});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      value: json['value'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'unit': unit,
    };
  }
}

class Address {
  final String? street;
  final String? area;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final String? landmark;

  Address({
    this.street,
    this.area,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.landmark,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      area: json['area'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      country: json['country'],
      landmark: json['landmark'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'area': area,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'landmark': landmark,
    };
  }
}

class Seo {
  final String? metaTitle;
  final String? metaDescription;
  final String? slug;

  Seo({this.metaTitle, this.metaDescription, this.slug});

  factory Seo.fromJson(Map<String, dynamic> json) {
    return Seo(
      metaTitle: json['metaTitle'],
      metaDescription: json['metaDescription'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
      'slug': slug,
    };
  }
}

class Pricing {
  final dynamic basePrice;
  final dynamic maintenanceCharges;
  final dynamic securityDeposit;
  final bool? priceNegotiable;

  Pricing({
    this.basePrice,
    this.maintenanceCharges,
    this.securityDeposit,
    this.priceNegotiable,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      basePrice: json['basePrice'],
      maintenanceCharges: json['maintenanceCharges'],
      securityDeposit: json['securityDeposit'],
      priceNegotiable: json['priceNegotiable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'basePrice': basePrice,
      'maintenanceCharges': maintenanceCharges,
      'securityDeposit': securityDeposit,
      'priceNegotiable': priceNegotiable,
    };
  }
}

class Contact {
  final String? name;
  final String? phone;
  final String? whatsapp;
  final String? type;

  Contact({this.name, this.phone, this.whatsapp, this.type});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'whatsapp': whatsapp,
      'type': type,
    };
  }
}

class Features {
  final String? facing;
  final String? flooringType;
  final String? waterSupply;
  final bool? powerBackup;
  final bool? servantRoom;
  final bool? poojaRoom;
  final bool? studyRoom;
  final bool? storeRoom;
  final bool? garden;
  final bool? swimmingPool;
  final bool? gym;
  final bool? lift;
  final bool? security;

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
    this.security,
  });

  factory Features.fromJson(Map<String, dynamic> json) {
    return Features(
      facing: json['facing'],
      flooringType: json['flooringType'],
      waterSupply: json['waterSupply'],
      powerBackup: json['powerBackup'],
      servantRoom: json['servantRoom'],
      poojaRoom: json['poojaRoom'],
      studyRoom: json['studyRoom'],
      storeRoom: json['storeRoom'],
      garden: json['garden'],
      swimmingPool: json['swimmingPool'],
      gym: json['gym'],
      lift: json['lift'],
      security: json['security'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facing': facing,
      'flooringType': flooringType,
      'waterSupply': waterSupply,
      'powerBackup': powerBackup,
      'servantRoom': servantRoom,
      'poojaRoom': poojaRoom,
      'studyRoom': studyRoom,
      'storeRoom': storeRoom,
      'garden': garden,
      'swimmingPool': swimmingPool,
      'gym': gym,
      'lift': lift,
      'security': security,
    };
  }
}

class NearbyPlaces {
  final List<dynamic>? schools;
  final List<dynamic>? hospitals;
  final List<dynamic>? malls;
  final List<dynamic>? transport;

  NearbyPlaces({this.schools, this.hospitals, this.malls, this.transport});

  factory NearbyPlaces.fromJson(Map<String, dynamic> json) {
    return NearbyPlaces(
      schools: json['schools'] != null ? List<dynamic>.from(json['schools']) : null,
      hospitals: json['hospitals'] != null ? List<dynamic>.from(json['hospitals']) : null,
      malls: json['malls'] != null ? List<dynamic>.from(json['malls']) : null,
      transport: json['transport'] != null ? List<dynamic>.from(json['transport']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schools': schools,
      'hospitals': hospitals,
      'malls': malls,
      'transport': transport,
    };
  }
}

class Seller {
  final String? id;
  final String? phone;
  final String? name;

  Seller({this.id, this.phone, this.name});

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['_id'],
      phone: json['phone'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'phone': phone,
      'name': name,
    };
  }
}

class ViewedBy {
  final dynamic user;
  final String? viewedAt;
  final String? id;

  ViewedBy({this.user, this.viewedAt, this.id});

  factory ViewedBy.fromJson(Map<String, dynamic> json) {
    return ViewedBy(
      user: json['user'],
      viewedAt: json['viewedAt'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'viewedAt': viewedAt,
      '_id': id,
    };
  }
}

class LikedBy {
  final String? user;
  final String? likedAt;
  final String? id;

  LikedBy({this.user, this.likedAt, this.id});

  factory LikedBy.fromJson(Map<String, dynamic> json) {
    return LikedBy(
      user: json['user'],
      likedAt: json['likedAt'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'likedAt': likedAt,
      '_id': id,
    };
  }
}