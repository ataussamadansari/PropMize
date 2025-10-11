
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