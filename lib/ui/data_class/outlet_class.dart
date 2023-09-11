class OutletClass {
  String docId;
  String id;
  String name;
  String description;
  String image;
  DateTime date;
  String country;
  String location;
  bool isLocatedAt;
  String contactNumber;
  String email;
  String currency;
  int star;
  String regionId;
  String regionName;
  String cuisineId;
  String cuisineName;
  String cuisineStyleId;
  String cuisineStyleName;
  String scheduleId;
  dynamic category = List<String>;
  OutletClass(
      {required this.docId,
      required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.date,
      required this.country,
      required this.location,
      required this.isLocatedAt,
      required this.contactNumber,
      required this.email,
      required this.currency,
      required this.star,
      required this.regionId,
      required this.regionName,
      required this.cuisineId,
      required this.cuisineName,
      required this.cuisineStyleId,
      required this.cuisineStyleName,
      required this.scheduleId,
      required this.category});
}
