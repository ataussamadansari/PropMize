import 'dart:convert';

import 'lists/address.dart';
import 'lists/area.dart';
import 'lists/contact.dart';
import 'lists/contacted_by.dart';
import 'lists/features.dart';
import 'lists/liked_by.dart';
import 'lists/near_by_places.dart';
import 'lists/pricing.dart';
import 'lists/seo.dart';
import 'lists/viewed_by.dart';

class Data
{
    Data({
        this.area,
        this.buildUpArea,
        this.superBuildUpArea,
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
        // this.seller,
        this.status,
        this.featured,
        this.premium,
        this.views,
        this.likes,
        // this.leads,
        this.approvalStatus,
        this.notes,
        this.viewedBy,
        this.likedBy,
        this.contactedBy,
        this.expiresAt,
        this.createdAt,
        this.updatedAt,
        this.v});


    Data.fromJson(dynamic json)
    {
        // --- FIX FOR NESTED/STRINGIFIED JSON OBJECTS ---
        dynamic parsePotentiallyStringifiedJson(dynamic value)
        {
            if (value is String) 
            {
                try
                {
                    return jsonDecode(value); // Decode the string into a Map
                }
                catch (e)
                {
                    return null; // Return null if decoding fails
                }
            }
            return value; // Return original value if it's already a Map
        }

        final buildUpAreaJson = parsePotentiallyStringifiedJson(json['buildUpArea']);
        final superBuildUpAreaJson = parsePotentiallyStringifiedJson(json['superBuildUpArea']);

        area = json['area'] != null ? Area.fromJson(json['area']) : null;
        buildUpArea = buildUpAreaJson != null ? BuildUpArea.fromJson(buildUpAreaJson) : null;
        superBuildUpArea = superBuildUpAreaJson != null ? SuperBuildUpArea.fromJson(superBuildUpAreaJson) : null;
        amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
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
        images = json['images'] != null ? List<String>.from(json['images']) : [];
        videos = json['videos'] != null ? List<String>.from(json['videos']) : [];
        status = json['status'];
        featured = json['featured'];
        premium = json['premium'];
        views = json['views'];
        likes = json['likes'] != null ? List<String>.from(json['likes']) : [];
        approvalStatus = json['approvalStatus'];
        notes = json['notes'];

        if (json['viewedBy'] != null) 
        {
            viewedBy = (json['viewedBy'] as List).map((v) => ViewedBy.fromJson(v)).toList();
        }
        else 
        {
            viewedBy = null;
        }

        if (json['likedBy'] != null) 
        {
            likedBy = (json['likedBy'] as List).map((v) => LikedBy.fromJson(v)).toList();
        }
        else 
        {
            likedBy = null;
        }

        if (json['contactedBy'] != null) 
        {
            contactedBy = (json['contactedBy'] as List).map((v) => ContactedBy.fromJson(v)).toList();
        }
        else 
        {
            contactedBy = null;
        }

        expiresAt = json['expiresAt'];
        createdAt = json['createdAt'];
        updatedAt = json['updatedAt'];
        v = json['__v'];

        print("=== END Data.fromJson ===");
    }

    /*Data.fromJson(dynamic json)
    {
        print("=== START Data.fromJson ===");

        area = json['area'] != null ? Area.fromJson(json['area']) : null;
        print("Area JSON: ${json['area']}");


        buildUpArea = json['buildUpArea'] != null ? BuildUpArea.fromJson(json['buildUpArea']) : null;
        print("BuildUpArea JSON: ${json['buildUpArea']}");

        superBuildUpArea = json['superBuildUpArea'] != null ? SuperBuildUpArea.fromJson(json['superBuildUpArea']) : null;
        print("SuperBuildUpArea JSON: ${json['superBuildUpArea']}");

        address = json['address'] != null ? Address.fromJson(json['address']) : null;
        print("Address JSON: ${json['address']}");

        seo = json['seo'] != null ? Seo.fromJson(json['seo']) : null;
        print("Seo JSON: ${json['seo']}");

        pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
        print("Pricing JSON: ${json['pricing']}");

        contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null;
        print("Contact JSON: ${json['contact']}");

        features = json['features'] != null ? Features.fromJson(json['features']) : null;
        print("Features JSON: ${json['features']}");

        nearbyPlaces = json['nearbyPlaces'] != null ? NearbyPlaces.fromJson(json['nearbyPlaces']) : null;
        print("NearbyPlaces JSON: ${json['nearbyPlaces']}");

        id = json['_id'];
        print("ID: $id");

        title = json['title'];
        print("Title: $title");

        description = json['description'];
        print("Description: $description");

        propertyType = json['propertyType'];
        print("PropertyType: $propertyType");

        listingType = json['listingType'];
        print("ListingType: $listingType");

        price = json['price'];
        print("Price: $price");

        currency = json['currency'];
        print("Currency: $currency");

        bedrooms = json['bedrooms'];
        print("Bedrooms: $bedrooms");

        bathrooms = json['bathrooms'];
        print("Bathrooms: $bathrooms");

        balconies = json['balconies'];
        print("Balconies: $balconies");

        parking = json['parking'];
        print("Parking: $parking");

        furnished = json['furnished'];
        print("Furnished: $furnished");

        floor = json['floor'];
        print("Floor: $floor");

        totalFloors = json['totalFloors'];
        print("TotalFloors: $totalFloors");

        age = json['age'];
        print("Age: $age");

        images = json['images'] != null ? json['images'].cast<String>() : [];
        print("Images: ${images?.length} items");
        print("Images raw: ${json['images']}");

        videos = json['videos'] != null ? json['videos'].cast<String>() : [];
        print("Videos: ${videos?.length} items");

        amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
        print("Amenities: ${amenities?.length} items");
        print("Amenities raw: ${json['amenities']}");

        // seller = json['seller'];
        // seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
        // print("Seller JSON: ${json['seller']}");

        status = json['status'];
        print("Status: $status");

        featured = json['featured'];
        print("Featured: $featured");

        premium = json['premium'];
        print("Premium: $premium");

        views = json['views'];
        print("Views: $views");

        likes = json['likes'] != null ? json['likes'].cast<String>() : [];
        print("Likes: ${likes?.length} items");
        print("Likes raw: ${json['likes']}");

        approvalStatus = json['approvalStatus'];
        print("ApprovalStatus: $approvalStatus");

        notes = json['notes'];
        print("Notes: $notes");

        // ViewedBy commented out - debug if needed
        if (json['viewedBy'] != null) 
        {
            viewedBy = [];
            json['viewedBy'].forEach((v)
                {
                    viewedBy?.add(ViewedBy.fromJson(v));
                }
            );
        }
        else 
        {
            viewedBy = null;
        }
        print("ViewedBy: ${viewedBy?.length} items");

        if (json['likedBy'] != null) 
        {
            likedBy = [];
            json['likedBy'].forEach((v)
                {
                    likedBy?.add(LikedBy.fromJson(v));
                }
            );
        }
        else 
        {
            likedBy = null;
        }
        print("LikedBy: ${likedBy?.length} items");

        if (json['contactedBy'] != null) 
        {
            contactedBy = [];
            json['contactedBy'].forEach((v)
                {
                    contactedBy?.add(ContactedBy.fromJson(v));
                }
            );
        }
        else 
        {
            contactedBy = null;
        }
        print("ContactedBy: ${contactedBy?.length} items");

        expiresAt = json['expiresAt'];
        print("ExpiresAt: $expiresAt");

        createdAt = json['createdAt'];
        print("CreatedAt: $createdAt");

        updatedAt = json['updatedAt'];
        print("UpdatedAt: $updatedAt");

        v = json['__v'];
        print("V: $v");

        print("=== END Data.fromJson ===");
    }*/

    Area? area;
    BuildUpArea? buildUpArea;
    SuperBuildUpArea? superBuildUpArea;
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
    // Seller? seller;
    // String? seller;
    String? status;
    bool? featured;
    bool? premium;
    int? views;
    List<String>? likes;
    // List<String>? leads;
    // List<Leads>? leads;
    String? approvalStatus;
    String? notes;
    List<ViewedBy>? viewedBy;
    List<LikedBy>? likedBy;
    List<ContactedBy>? contactedBy;
    String? expiresAt;
    String? createdAt;
    String? updatedAt;
    int? v;

    Map<String, dynamic> toJson()
    {
        final map = <String, dynamic>{};
        if (area != null)
        {
            map['area'] = area?.toJson();
        }
        if (buildUpArea != null)
        {
            map['buildUpArea'] = buildUpArea?.toJson();
        }
        if (superBuildUpArea != null)
        {
            map['superBuildUpArea'] = superBuildUpArea?.toJson();
        }
        if (address != null)
        {
            map['address'] = address?.toJson();
        }
        if (seo != null)
        {
            map['seo'] = seo?.toJson();
        }
        if (pricing != null)
        {
            map['pricing'] = pricing?.toJson();
        }
        if (contact != null)
        {
            map['contact'] = contact?.toJson();
        }
        if (features != null)
        {
            map['features'] = features?.toJson();
        }
        if (nearbyPlaces != null)
        {
            map['nearbyPlaces'] = nearbyPlaces?.toJson();
        }
        map['_id'] = id;
        map['title'] = title;
        map['description'] = description;
        map['propertyType'] = propertyType;
        map['listingType'] = listingType;
        if (price != null)
        {
            map['price'] = price;
        }
        map['price'] = price;
        map['currency'] = currency;
        if (bedrooms != null)
        {
            map['bedrooms'] = bedrooms;
        }
        if (bathrooms != null)
        {
            map['bathrooms'] = bathrooms;
        }
        if (balconies != null)
        {
            map['balconies'] = balconies;
        }
        if (parking != null)
        {
            map['parking'] = parking;
        }
        map['furnished'] = furnished;
        if (floor != null)
        {
            map['floor'] = floor;
        }
        if (totalFloors != null)
        {
            map['totalFloors'] = totalFloors;
        }
        if (age != null)
        {
            map['age'] = age;
        }
        map['images'] = images;
        map['videos'] = videos;
        map['amenities'] = amenities;
        // map['seller'] = seller;
        /*if (seller != null)
        {
            map['seller'] = seller?.toJson();
        }*/
        map['status'] = status;
        map['featured'] = featured;
        map['premium'] = premium;
        if (views != null)
        {
            map['views'] = views;
        }
        map['likes'] = likes;
        // if (leads != null)
        // {
        //     map['leads'] = leads;
        //     // map['leads'] = leads?.map((v) => v.toJson()).toList();
        // }
        map['approvalStatus'] = approvalStatus;
        map['notes'] = notes;
        /*if (viewedBy != null)
        {
            map['viewedBy'] = viewedBy?.map((v) => v.toJson()).toList();
        }*/
        if (likedBy != null)
        {
            map['likedBy'] = likedBy?.map((v) => v.toJson()).toList();
        }
        if (contactedBy != null)
        {
            map['contactedBy'] = contactedBy?.map((v) => v.toJson()).toList();
        }
        map['expiresAt'] = expiresAt;
        map['createdAt'] = createdAt;
        map['updatedAt'] = updatedAt;
        map['__v'] = v;
        return map;
    }
}

