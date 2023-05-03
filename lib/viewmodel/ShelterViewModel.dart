// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../model/Shelter.dart';

// class ShelterViewModel {
//   Future<List<Shelter>> fetchPlacesByKeyworkdAndPosition(
//       String keyword, double latitude, double longitude) async {
//     final url =
//         "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$keyword&location=$latitude,$longitude&radius=1500&type=shelter&key=AIzaSyCV7la0_WJfuEUHBRsz5WFG8kb36cfCFuw";

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);
//       final Iterable results = jsonResponse["results"];
//       results.map((shelter) => Shelter.fromJson(shelter)).toList();
//     } else {
//       throw Exception("Unable to perform request");
//     }
//     throw Exception();
//   }

//    Shelter _shelter;

//   ShelterViewModel(Shelter shelter) {
//     this._shelter = shelter;
//   }

//   String get placeId {
//     return this._shelter.placeId;
//   }

//   String get photoURL {
//     return this._shelter.photoURL;
//   }

//   double get latitude {
//     return this._shelter.latitude;
//   }

//   double get longitude {
//     return this._shelter.longitude;
//   }

//   String get name {
//     return this._shelter.name;
//   }
// }
