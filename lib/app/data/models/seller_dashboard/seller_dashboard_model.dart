class SellerDashboardModel {
  SellerDashboardModel({
      this.success, 
      this.data,});

  SellerDashboardModel.fromJson(dynamic json) {
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
      this.stats, 
      this.recentLeads, 
      this.topProperties,});

  Data.fromJson(dynamic json) {
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['recentLeads'] != null) {
      recentLeads = [];
      json['recentLeads'].forEach((v) {
        recentLeads?.add(RecentLeads.fromJson(v));
      });
    }
    if (json['topProperties'] != null) {
      topProperties = [];
      json['topProperties'].forEach((v) {
        topProperties?.add(TopProperties.fromJson(v));
      });
    }
  }
  Stats? stats;
  List<RecentLeads>? recentLeads;
  List<TopProperties>? topProperties;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    if (recentLeads != null) {
      map['recentLeads'] = recentLeads?.map((v) => v.toJson()).toList();
    }
    if (topProperties != null) {
      map['topProperties'] = topProperties?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TopProperties {
  TopProperties({
      this.id, 
      this.title, 
      this.views, 
      this.leads,});

  TopProperties.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    views = json['views'];
    leads = json['leads'];
  }
  String? id;
  String? title;
  int? views;
  int? leads;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['views'] = views;
    map['leads'] = leads;
    return map;
  }

}

class RecentLeads {
  RecentLeads({
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

  RecentLeads.fromJson(dynamic json) {
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
      this.name,});

  Buyer.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}

class Property {
  Property({
      this.id, 
      this.title,});

  Property.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
  }
  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
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

class Stats {
  Stats({
      this.totalProperties, 
      this.totalViews, 
      this.totalLeads,});

  Stats.fromJson(dynamic json) {
    totalProperties = json['totalProperties'];
    totalViews = json['totalViews'];
    totalLeads = json['totalLeads'];
  }
  int? totalProperties;
  int? totalViews;
  int? totalLeads;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalProperties'] = totalProperties;
    map['totalViews'] = totalViews;
    map['totalLeads'] = totalLeads;
    return map;
  }

}