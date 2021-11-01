import 'dart:async';

import 'package:kokiku/data/api/api_service.dart';
import 'package:kokiku/data/model/search.dart';
import 'package:flutter/material.dart';

enum ResultState { Loading, NoData, HasData, Error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    fetchAllArticle(query);
  }

  late SearchRestaurant _searchRestaurant;
  late ResultState _state;
  String _message = '';
  String _query = '';

  String get message => _message;
  String get query => _query;

  SearchRestaurant get result => _searchRestaurant;

  ResultState get state => _state;

  Future<dynamic> fetchAllArticle(query) async {
    try {
      _state = ResultState.Loading;
      _query = query;
      notifyListeners();
      final allSearch = await apiService.SearchModel(query);
      if (allSearch.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Can\'t find the restaurant';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurant = allSearch;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'There is an error with the connection \nPlease check your connection!';
    }
  }
}
