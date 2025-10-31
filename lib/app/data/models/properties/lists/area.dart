class Area
{
  Area({
    this.value,
    this.unit
  });

  Area.fromJson(dynamic json)
  {
    value = json['value'];
    unit = json['unit'];
  }
  dynamic value;
  String? unit;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['unit'] = unit;
    return map;
  }
}

class BuildUpArea
{
  BuildUpArea({
    this.value,
    this.unit
  });

  BuildUpArea.fromJson(dynamic json)
  {
    value = json['value'];
    unit = json['unit'];
  }
  dynamic value;
  String? unit;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['unit'] = unit;
    return map;
  }
}
class SuperBuildUpArea
{
  SuperBuildUpArea({
    this.value,
    this.unit
  });

  SuperBuildUpArea.fromJson(dynamic json)
  {
    value = json['value'];
    unit = json['unit'];
  }
  dynamic value;
  String? unit;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['unit'] = unit;
    return map;
  }
}
