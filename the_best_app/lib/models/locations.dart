class Location {
  final String shopName;
  final String shopAddress;

  Location({required this.shopName, required this.shopAddress});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(shopName: json['title'], shopAddress: json['body']);
  }
}
