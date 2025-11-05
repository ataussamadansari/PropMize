class AnalyticsModel {
  AnalyticsModel({
      this.success, 
      this.data,});

  AnalyticsModel.fromJson(dynamic json) {
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
      this.overallStats, 
      this.propertyAnalytics, 
      this.periodData, 
      this.marketInsights, 
      this.summary,});

  Data.fromJson(dynamic json) {
    if (json['overallStats'] != null) {
      overallStats = [];
      json['overallStats'].forEach((v) {
        overallStats?.add(OverallStats.fromJson(v));
      });
    }
    if (json['propertyAnalytics'] != null) {
      propertyAnalytics = [];
      json['propertyAnalytics'].forEach((v) {
        propertyAnalytics?.add(PropertyAnalytics.fromJson(v));
      });
    }
    if (json['periodData'] != null) {
      periodData = [];
      json['periodData'].forEach((v) {
        periodData?.add(PeriodData.fromJson(v));
      });
    }
    if (json['marketInsights'] != null) {
      marketInsights = [];
      json['marketInsights'].forEach((v) {
        marketInsights?.add(MarketInsights.fromJson(v));
      });
    }
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }
  List<OverallStats>? overallStats;
  List<PropertyAnalytics>? propertyAnalytics;
  List<PeriodData>? periodData;
  List<MarketInsights>? marketInsights;
  Summary? summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (overallStats != null) {
      map['overallStats'] = overallStats?.map((v) => v.toJson()).toList();
    }
    if (propertyAnalytics != null) {
      map['propertyAnalytics'] = propertyAnalytics?.map((v) => v.toJson()).toList();
    }
    if (periodData != null) {
      map['periodData'] = periodData?.map((v) => v.toJson()).toList();
    }
    if (marketInsights != null) {
      map['marketInsights'] = marketInsights?.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      map['summary'] = summary?.toJson();
    }
    return map;
  }

}

class Summary {
  Summary({
      this.totalProperties, 
      this.activeProperties, 
      this.totalValue, 
      this.averagePrice,
  });

  Summary.fromJson(dynamic json) {
    totalProperties = json['totalProperties'];
    activeProperties = json['activeProperties'];
    totalValue = json['totalValue'];
    averagePrice = json['averagePrice'];
  }
  int? totalProperties;
  int? activeProperties;
  int? totalValue;
  double? averagePrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalProperties'] = totalProperties;
    map['activeProperties'] = activeProperties;
    map['totalValue'] = totalValue;
    map['averagePrice'] = averagePrice;
    return map;
  }

}

class MarketInsights {
  MarketInsights({
      this.title, 
      this.value, 
      this.insight, 
      this.recommendation,});

  MarketInsights.fromJson(dynamic json) {
    title = json['title'];
    value = json['value'];
    insight = json['insight'];
    recommendation = json['recommendation'];
  }
  String? title;
  String? value;
  String? insight;
  String? recommendation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['value'] = value;
    map['insight'] = insight;
    map['recommendation'] = recommendation;
    return map;
  }

}

class PeriodData {
  PeriodData({
      this.day, 
      this.views, 
      this.inquiries,});

  PeriodData.fromJson(dynamic json) {
    day = json['day'];
    views = json['views'];
    inquiries = json['inquiries'];
  }
  String? day;
  int? views;
  int? inquiries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['views'] = views;
    map['inquiries'] = inquiries;
    return map;
  }

}

class PropertyAnalytics {
  PropertyAnalytics({
      this.id, 
      this.title, 
      this.views, 
      this.inquiries, 
      this.favorites, 
      this.calls, 
      this.likes, 
      this.conversionRate, 
      this.converted, 
      this.daysListed, 
      this.status, 
      this.propertyType, 
      this.listingType, 
      this.location, 
      this.price,});

  PropertyAnalytics.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    views = json['views'];
    inquiries = json['inquiries'];
    favorites = json['favorites'];
    calls = json['calls'];
    likes = json['likes'];
    conversionRate = json['conversionRate'];
    converted = json['converted'];
    daysListed = json['daysListed'];
    status = json['status'];
    propertyType = json['propertyType'];
    listingType = json['listingType'];
    location = json['location'];
    price = json['price'];
  }
  String? id;
  String? title;
  int? views;
  int? inquiries;
  int? favorites;
  int? calls;
  int? likes;
  dynamic conversionRate;
  int? converted;
  int? daysListed;
  String? status;
  String? propertyType;
  String? listingType;
  String? location;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['views'] = views;
    map['inquiries'] = inquiries;
    map['favorites'] = favorites;
    map['calls'] = calls;
    map['likes'] = likes;
    map['conversionRate'] = conversionRate;
    map['converted'] = converted;
    map['daysListed'] = daysListed;
    map['status'] = status;
    map['propertyType'] = propertyType;
    map['listingType'] = listingType;
    map['location'] = location;
    map['price'] = price;
    return map;
  }

}

class OverallStats {
  OverallStats({
      this.label, 
      this.value, 
      this.change, 
      this.trend, 
      this.icon,});

  OverallStats.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'];
    change = json['change'];
    trend = json['trend'];
    icon = json['icon'];
  }
  dynamic label;
  dynamic value;
  dynamic change;
  dynamic trend;
  dynamic icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    map['change'] = change;
    map['trend'] = trend;
    map['icon'] = icon;
    return map;
  }

}