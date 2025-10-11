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