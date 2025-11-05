import 'lists/area.dart';
import 'lists/address.dart';
import 'lists/features.dart';
import 'lists/near_by_places.dart';
import 'lists/contact.dart';
import 'lists/pricing.dart';

class PropertyRequestModel {
  final String title;
  final String description;
  final String propertyType;
  final String listingType;
  final int price;
  final Area area;
  final BuildUpArea? buildUpArea;
  final SuperBuildUpArea? superBuildUpArea;
  final String furnished;
  final int age;
  final int? bedrooms;
  final int? bathrooms;
  final int? balconies;
  final int? parking;
  final int? floor;
  final int? totalFloors;
  final Address address;
  final Features features;
  final List<String> amenities;
  final NearbyPlaces nearbyPlaces;
  final List<String> images;
  final Contact contact;
  final String notes;
  final Pricing pricing;

  PropertyRequestModel({
    required this.title,
    required this.description,
    required this.propertyType,
    required this.listingType,
    required this.price,
    required this.area,
    this.buildUpArea,
    this.superBuildUpArea,
    required this.furnished,
    required this.age,
    this.bedrooms,
    this.bathrooms,
    this.balconies,
    this.parking,
    this.floor,
    this.totalFloors,
    required this.address,
    required this.features,
    required this.amenities,
    required this.nearbyPlaces,
    required this.images,
    required this.contact,
    required this.notes,
    required this.pricing,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "propertyType": propertyType,
      "listingType": listingType,
      "price": price,
      "area": area.toJson(),
      if (buildUpArea != null) "buildUpArea": buildUpArea!.toJson(),
      if (superBuildUpArea != null) "superBuildUpArea": superBuildUpArea!.toJson(),
      "furnished": furnished,
      "age": age,
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "balconies": balconies,
      "parking": parking,
      "floor": floor,
      "totalFloors": totalFloors,
      "address": address.toJson(),
      "features": features.toJson(),
      "amenities": amenities,
      "nearbyPlaces": nearbyPlaces.toJson(),
      "images": images,
      "contact": contact.toJson(),
      "notes": notes,
      "pricing": pricing.toJson(),
    };
  }
}
