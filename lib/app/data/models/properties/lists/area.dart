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
