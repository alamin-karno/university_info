import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:university_info/model/university_model.dart';

class GetUniversityProvider with ChangeNotifier {
  List<UniversityModel> responseData = [];

  bool isLoading = false;

  Future<void> getAllUniversityData(String country) async {
    responseData = [];
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          "http://universities.hipolabs.com/search?country=$country"));

      debugPrint('RESPONSE: ${response.statusCode}');
      if (response.statusCode == 200) {
        List<dynamic> items = json.decode(response.body);

        for (int i = 0; i < items.length; i++) {
          responseData.add(UniversityModel.fromJson(items[i]));
        }
      } else {
        debugPrint("ERROR");
      }
    } catch (e) {
      debugPrint("ERROR: ${e.toString()}");
    }

    isLoading = false;
    notifyListeners();
  }
}
