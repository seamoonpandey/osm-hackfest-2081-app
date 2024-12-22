import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadUserData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get token
  final String? token = prefs.getString('token');

  // Get user object (including stats)
  final String? userJson = prefs.getString('user');
  if (userJson != null) {
    final Map<String, dynamic> user = jsonDecode(userJson);
    debugPrint('Token: $token');
    debugPrint('User: ${user['name']}');
    debugPrint('Stats: ${user['stats']}');
  } else {
    debugPrint('No user data found');
  }
}
