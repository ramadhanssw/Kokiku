import 'dart:async';

import 'package:kokiku/data/api/api_service.dart';
import 'package:kokiku/data/model/list.dart';
import 'package:flutter/material.dart';
import 'package:kokiku/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllArticle();
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantList get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final allList = await apiService.ListModel();
      if (allList.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Can\'t find the restaurant';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = allList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'There is an error with the connection \nPlease check your connection!';
    }
  }
}
