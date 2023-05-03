class Shelter {
  final String name;
  final double latitude;
  final double longitude;
  final String placeId;
  final String photoURL;

  Shelter(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.photoURL,
      required this.placeId});

  factory Shelter.fromJson(Map<String, dynamic> json) {
    final location = json["geometry"]["location"];

    return Shelter(
        placeId: json["place_id"],
        name: json["name"],
        latitude: location["lat"],
        longitude: location["lng"],
        photoURL: (json["photos"][0])["photo_reference"]);
  }
}
