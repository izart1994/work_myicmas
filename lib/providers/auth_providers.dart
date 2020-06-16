import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProviders with ChangeNotifier {
  String _idAdmin;
  DateTime _expiryToken;
  String _nameAdmin;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryToken != null &&
        _expiryToken.isAfter(DateTime.now()) &&
        _idAdmin != null) {
      return _idAdmin;
    }
    return null;
  }

  String get nameAdmin {
    return _nameAdmin;
  }

  Future<void> authenticate(String username, String password) async {
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password
    };

    final response = await http.post(
      'YOUR_URL_HERE',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final responseData = json.decode(response.body);
    print(responseData);
    if (responseData['error'] != null) {
      print(responseData);
    } else {
      _idAdmin = responseData['id_admin'];
      _nameAdmin = responseData['name_admin'];
      _expiryToken = DateTime.now().add(
        Duration(
          seconds: 5000,
        ),
      );
    }
    print(_idAdmin);
    print(_expiryToken);
    _autoSignout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'id_admin': _idAdmin,
        'name_admin': _nameAdmin,
      },
    );
    print(userData);
    prefs.setString('userData', userData);
  }

  Future<void> signOut() async {
    _idAdmin = null;
    _expiryToken = null;
    _nameAdmin = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoSignout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryToken.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), signOut);
  }

  Future<bool> tryAutoSignin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.now().subtract(
      Duration(
        seconds: 5000,
      ),
    );

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _idAdmin = extractedUserData['id_admin'];
    _nameAdmin = extractedUserData['name_admin'];
    _expiryToken = expiryDate;
    notifyListeners();
    _autoSignout();
    return true;
  }
}
