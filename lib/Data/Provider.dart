import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherassign/Data/datasouce.dart';

class CityProvider extends ChangeNotifier {
  List<City> _allCities = [];
  List<City> _filteredCities = [];

  Future<List<City>> get cities async {
    if (_allCities.isEmpty) {
      _allCities = await loadCities();
      _filteredCities = _allCities;
    }
    return _filteredCities;
  }

  void filterCities(String query) {
    if (query.isEmpty) {
      _filteredCities = _allCities;
    } else {
      _filteredCities = _allCities
          .where(
              (city) => city.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<List<City>> loadCities() async {
    final String response =
        await rootBundle.loadString('assets/worldcities.json');
    final data = json.decode(response) as List;
    return data.map((json) => City.fromJson(json)).toList();
  }
}
