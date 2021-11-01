import 'dart:async';

import 'package:kokiku/data/api/api_service.dart';
import 'package:kokiku/data/model/content.dart';
import 'package:flutter/material.dart';
import 'package:kokiku/utils/result_state.dart';

class ContentProvider extends ChangeNotifier {
  final ApiService apiService;
  final id;

  ContentProvider(this.id, {required this.apiService}) {
    fetchContentArticle();
  }

  late RestaurantContent _restaurantContent;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantContent get result => _restaurantContent;

  ResultState get state => _state;

  Future<dynamic> fetchContentArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final fullContent = await apiService.ContentModel(id);
      if (fullContent.restaurant.id.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Can\'t find the restaurant';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantContent = fullContent;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'There is an error with the connection \nPlease check your connection!';
    }
  }
}
