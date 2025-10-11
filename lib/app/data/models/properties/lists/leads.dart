
import 'buyer.dart';

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