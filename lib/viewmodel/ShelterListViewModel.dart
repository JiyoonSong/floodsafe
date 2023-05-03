// import 'package:floodsafe/view/ShelterPage.dart';
// import 'package:floodsafe/viewmodel/ShelterViewModel.dart';
// import 'package:flutter/foundation.dart';

// class ShelterListViewModel extends ChangeNotifier {
//   var shelters = List<ShelterViewModel>();

//   Future<void> fetchPlacesByKeyworkdAndPosition(
//       String keyword, double latitude, double longitude) async {
//     final results = await ShelterViewModel()
//         .fetchPlacesByKeyworkdAndPosition(keyword, latitude, longitude);
//     this.shelters = results.map((place) => ShelterViewModel(shelters).toList());
//     notifyListeners();
//   }
// }
