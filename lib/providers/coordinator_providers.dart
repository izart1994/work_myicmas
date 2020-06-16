import 'package:flutter/foundation.dart';

class CoordinatorProviders with ChangeNotifier {
  final String cddId;
  final String newICNo;
  final String cddName;
  final String gender;

  CoordinatorProviders({
    this.cddId,
    this.newICNo,
    this.cddName,
    this.gender,
  });

  factory CoordinatorProviders.fromJson(Map<String, dynamic> json) {
    return CoordinatorProviders(
      cddId: json["id"] as String,
      newICNo: json["newIC"] as String,
      cddName: json["name"] as String,
      gender: json["gender"] as String,
    );
  }
}