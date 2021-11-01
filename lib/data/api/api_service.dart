import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kokiku/data/model/content.dart';
import 'package:kokiku/data/model/list.dart';
import 'package:kokiku/data/model/search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantList> ListModel() async {
    final response = await http.get(Uri.parse(_baseUrl + "/list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the data');
    }
  }

  Future<RestaurantContent> ContentModel(id) async {
    final response = await http.get(Uri.parse(_baseUrl + "/detail/" + id));
    if (response.statusCode == 200) {
      return RestaurantContent.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the restaurant data');
    }
  }

  Future<SearchRestaurant> SearchModel(query) async {
    final response = await http.get(Uri.parse(_baseUrl + "/search?q=" + query));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to find the restaurant');
    }
  }
}
