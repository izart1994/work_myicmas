import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import './coordinator_providers.dart';

class CoordinatorsProviders with ChangeNotifier {
  List<CoordinatorProviders> _items = [];

  final String authToken;

  CoordinatorsProviders(this.authToken, this._items);

  List<CoordinatorProviders> get items {
    return _items;
  }

  CoordinatorProviders findById(String id) {
    return _items.firstWhere((coordinator) => coordinator.cddId == id);
  }

  Future<void> fetchAndSetCoordinator() async {
    var url = 'YOUR_URL_HERE';
    //try {
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as List<dynamic>;
    final List<CoordinatorProviders> loadedCoordinator = [];
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((coorData) {
      loadedCoordinator.add(
        CoordinatorProviders(
          cddId: coorData['id'],
          newICNo: coorData['newIC'],
          cddName: coorData['name'],
          gender: coorData['gender'],
        ),
      );

      _items = loadedCoordinator;
      notifyListeners();
    });
  }

  // Future<void> updateProduct(String id, CoordinatorProviders editCoordinator) async {
  //   try {
  //     final url = 'YOUR_URL_HERE';
  //     await http.post(
  //       url,
  //       body: json.encode(
  //         {
  //           'title': editCoordinator.title,
  //           'description': editCoordinator.description,
  //           'price': editCoordinator.price,
  //           'imageUrl': editCoordinator.imageUrl,
  //         },
  //       ),
  //     );
  //     notifyListeners();
  //   } catch (error) {
  //     throw (error);
  //   }
  // }
}
