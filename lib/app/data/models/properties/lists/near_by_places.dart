
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
