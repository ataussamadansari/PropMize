
class Data
{
    Data({
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
        this.v});

    Data.fromJson(dynamic json)
    {
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
        seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
        status = json['status'];
        featured = json['featured'];
        premium = json['premium'];
        views = json['views'];
        likes = json['likes'] != null ? json['likes'].cast<String>() : [];
        if (json['leads'] != null) 
        {
            leads = [];
            json['leads'].forEach((v)
                {
                    leads?.add(Leads.fromJson(v));
                }
            );
        }
        approvalStatus = json['approvalStatus'];
        notes = json['notes'];
        if (json['viewedBy'] != null) 
        {
            viewedBy = [];
            json['viewedBy'].forEach((v)
                {
                    viewedBy?.add(ViewedBy.fromJson(v));
                }
            );
        }
        if (json['likedBy'] != null) 
        {
            likedBy = [];
            json['likedBy'].forEach((v)
                {
                    likedBy?.add(LikedBy.fromJson(v));
                }
            );
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
    Seller? seller;
    String? status;
    bool? featured;
    bool? premium;
    int? views;
    List<String>? likes;
    List<Leads>? leads;
    String? approvalStatus;
    String? notes;
    List<ViewedBy>? viewedBy;
    List<LikedBy>? likedBy;
    List<dynamic>? contactedBy;
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
        if (seller != null) 
        {
            map['seller'] = seller?.toJson();
        }
        map['status'] = status;
        map['featured'] = featured;
        map['premium'] = premium;
        map['views'] = views;
        map['likes'] = likes;
        if (leads != null) 
        {
            map['leads'] = leads?.map((v) => v.toJson()).toList();
        }
        map['approvalStatus'] = approvalStatus;
        map['notes'] = notes;
        if (viewedBy != null) 
        {
            map['viewedBy'] = viewedBy?.map((v) => v.toJson()).toList();
        }
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

class Address
{
    Address({
        this.street,
        this.area,
        this.city,
        this.state,
        this.zipCode,
        this.country,
        this.landmark});

    Address.fromJson(dynamic json)
    {
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

    Map<String, dynamic> toJson() 
    {
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

class Area
{
    Area({
        this.value,
        this.unit});

    Area.fromJson(dynamic json)
    {
        value = json['value'];
        unit = json['unit'];
    }
    int? value;
    String? unit;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['value'] = value;
        map['unit'] = unit;
        return map;
    }

}

class ViewedBy
{
    ViewedBy({
        this.user,
        this.viewedAt,
        this.id});

    ViewedBy.fromJson(dynamic json)
    {
        user = json['user'];
        viewedAt = json['viewedAt'];
        id = json['_id'];
    }
    String? user;
    String? viewedAt;
    String? id;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['user'] = user;
        map['viewedAt'] = viewedAt;
        map['_id'] = id;
        return map;
    }

}

class Leads
{
    Leads({
        this.id,
        this.buyer,
        this.status,
        this.createdAt});

    Leads.fromJson(dynamic json)
    {
        id = json['_id'];
        buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
        status = json['status'];
        createdAt = json['createdAt'];
    }
    String? id;
    Buyer? buyer;
    String? status;
    String? createdAt;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['_id'] = id;
        if (buyer != null) 
        {
            map['buyer'] = buyer?.toJson();
        }
        map['status'] = status;
        map['createdAt'] = createdAt;
        return map;
    }

}

class Buyer
{
    Buyer({
        this.id,
        this.phone,
        this.email,
        this.name});

    Buyer.fromJson(dynamic json)
    {
        id = json['_id'];
        phone = json['phone'];
        email = json['email'];
        name = json['name'];
    }
    String? id;
    String? phone;
    String? email;
    String? name;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['_id'] = id;
        map['phone'] = phone;
        map['email'] = email;
        map['name'] = name;
        return map;
    }

}

class Seller
{
    Seller({
        this.id,
        this.phone,
        this.avatar,
        this.isEmailVerified,
        this.isPhoneVerified,
        this.email,
        this.name});

    Seller.fromJson(dynamic json)
    {
        id = json['_id'];
        phone = json['phone'];
        avatar = json['avatar'];
        isEmailVerified = json['isEmailVerified'];
        isPhoneVerified = json['isPhoneVerified'];
        email = json['email'];
        name = json['name'];
    }
    String? id;
    String? phone;
    String? avatar;
    bool? isEmailVerified;
    bool? isPhoneVerified;
    String? email;
    String? name;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['_id'] = id;
        map['phone'] = phone;
        map['avatar'] = avatar;
        map['isEmailVerified'] = isEmailVerified;
        map['isPhoneVerified'] = isPhoneVerified;
        map['email'] = email;
        map['name'] = name;
        return map;
    }

}

class NearbyPlaces
{
    NearbyPlaces({
        this.schools,
        this.hospitals,
        this.malls,
        this.transport});

    NearbyPlaces.fromJson(dynamic json)
    {
        if (json['schools'] != null) 
        {
            schools = [];
            json['schools'].forEach((v)
                {
                    schools?.add(Schools.fromJson(v));
                }
            );
        }
        if (json['hospitals'] != null) 
        {
            hospitals = [];
            json['hospitals'].forEach((v)
                {
                    hospitals?.add(Hospitals.fromJson(v));
                }
            );
        }
        if (json['malls'] != null) 
        {
            malls = [];
            json['malls'].forEach((v)
                {
                    malls?.add(Malls.fromJson(v));
                }
            );
        }
        if (json['transport'] != null) 
        {
            transport = [];
            json['transport'].forEach((v)
                {
                    transport?.add(Transport.fromJson(v));
                }
            );
        }
    }
    List<Schools>? schools;
    List<Hospitals>? hospitals;
    List<Malls>? malls;
    List<Transport>? transport;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        if (schools != null) 
        {
            map['schools'] = schools?.map((v) => v.toJson()).toList();
        }
        if (hospitals != null) 
        {
            map['hospitals'] = hospitals?.map((v) => v.toJson()).toList();
        }
        if (malls != null) 
        {
            map['malls'] = malls?.map((v) => v.toJson()).toList();
        }
        if (transport != null) 
        {
            map['transport'] = transport?.map((v) => v.toJson()).toList();
        }
        return map;
    }

}

class Transport
{
    Transport({
        this.name,
        this.distance,
        this.unit,
        this.id});

    Transport.fromJson(dynamic json)
    {
        name = json['name'];
        distance = json['distance'];
        unit = json['unit'];
        id = json['_id'];
    }
    String? name;
    int? distance;
    String? unit;
    String? id;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['name'] = name;
        map['distance'] = distance;
        map['unit'] = unit;
        map['_id'] = id;
        return map;
    }

}

class Malls
{
    Malls({
        this.name,
        this.distance,
        this.unit,
        this.id});

    Malls.fromJson(dynamic json)
    {
        name = json['name'];
        distance = json['distance'];
        unit = json['unit'];
        id = json['_id'];
    }
    String? name;
    int? distance;
    String? unit;
    String? id;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['name'] = name;
        map['distance'] = distance;
        map['unit'] = unit;
        map['_id'] = id;
        return map;
    }

}

class Hospitals
{
    Hospitals({
        this.name,
        this.distance,
        this.unit,
        this.id});

    Hospitals.fromJson(dynamic json)
    {
        name = json['name'];
        distance = json['distance'];
        unit = json['unit'];
        id = json['_id'];
    }
    String? name;
    int? distance;
    String? unit;
    String? id;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['name'] = name;
        map['distance'] = distance;
        map['unit'] = unit;
        map['_id'] = id;
        return map;
    }

}

class Schools
{
    Schools({
        this.name,
        this.distance,
        this.unit,
        this.id});

    Schools.fromJson(dynamic json)
    {
        name = json['name'];
        distance = json['distance'];
        unit = json['unit'];
        id = json['_id'];
    }
    String? name;
    int? distance;
    String? unit;
    String? id;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['name'] = name;
        map['distance'] = distance;
        map['unit'] = unit;
        map['_id'] = id;
        return map;
    }

}

class Features
{
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
        this.security});

    Features.fromJson(dynamic json)
    {
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

    Map<String, dynamic> toJson() 
    {
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

class LikedBy
{
    LikedBy({
        this.user,
        this.likedAt,
        this.id});

    LikedBy.fromJson(dynamic json)
    {
        user = json['user'];
        likedAt = json['likedAt'];
        id = json['_id'];
    }
    String? user;
    String? likedAt;
    String? id;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['user'] = user;
        map['likedAt'] = likedAt;
        map['_id'] = id;
        return map;
    }

}

class Contact
{
    Contact({
        this.name,
        this.phone,
        this.whatsapp,
        this.type});

    Contact.fromJson(dynamic json)
    {
        name = json['name'];
        phone = json['phone'];
        whatsapp = json['whatsapp'];
        type = json['type'];
    }
    String? name;
    String? phone;
    String? whatsapp;
    String? type;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['name'] = name;
        map['phone'] = phone;
        map['whatsapp'] = whatsapp;
        map['type'] = type;
        return map;
    }

}

class Pricing
{
    Pricing({
        this.basePrice,
        this.maintenanceCharges,
        this.securityDeposit,
        this.priceNegotiable});

    Pricing.fromJson(dynamic json)
    {
        basePrice = json['basePrice'];
        maintenanceCharges = json['maintenanceCharges'];
        securityDeposit = json['securityDeposit'];
        priceNegotiable = json['priceNegotiable'];
    }
    dynamic basePrice;
    dynamic maintenanceCharges;
    dynamic securityDeposit;
    bool? priceNegotiable;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['basePrice'] = basePrice;
        map['maintenanceCharges'] = maintenanceCharges;
        map['securityDeposit'] = securityDeposit;
        map['priceNegotiable'] = priceNegotiable;
        return map;
    }

}

class Seo
{
    Seo({
        this.metaTitle,
        this.metaDescription,
        this.slug});

    Seo.fromJson(dynamic json)
    {
        metaTitle = json['metaTitle'];
        metaDescription = json['metaDescription'];
        slug = json['slug'];
    }
    String? metaTitle;
    String? metaDescription;
    String? slug;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['metaTitle'] = metaTitle;
        map['metaDescription'] = metaDescription;
        map['slug'] = slug;
        return map;
    }

}

class Pagination
{
    Pagination({
        this.page,
        this.limit,
        this.total,
        this.pages});

    Pagination.fromJson(dynamic json)
    {
        page = json['page'];
        limit = json['limit'];
        total = json['total'];
        pages = json['pages'];
    }
    int? page;
    int? limit;
    int? total;
    int? pages;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['page'] = page;
        map['limit'] = limit;
        map['total'] = total;
        map['pages'] = pages;
        return map;
    }

}

class ContactedBy
{
    ContactedBy({
        this.user,
        this.contactedAt
    });

    ContactedBy.fromJson(dynamic json)
    {
        user = json['user'];
        contactedAt = json['contactedAt'];
    }
    String? user;
    String? contactedAt;

    Map<String, dynamic> toJson() 
    {
        final map = <String, dynamic>{};
        map['user'] = user;
        map['likedAt'] = contactedAt;
        return map;
    }
}
