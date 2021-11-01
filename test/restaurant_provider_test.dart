import 'package:flutter_test/flutter_test.dart';
import 'package:kokiku/data/model/search.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:kokiku/data/api/api_service.dart';
import 'package:kokiku/data/model/list.dart';
import 'package:kokiku/provider/restaurant_provider.dart';

import 'restaurant_provider_test.mocks.dart';

const apiResponse = {
  'error': false,
  'message': 'success',
  'count': 1,
  'restaurants': [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

const testRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
  "pictureId": "14",
  "city": "Medan",
  "rating": 4.2
};

const searchResponse = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
  ]
};

const testDetailRestaurant = {
  "id": "rqdv5juczeskfw1e867",
  "name": "Melting Pot",
  "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
  "city": "Medan",
  "address": "Jln. Pandeglang no 19",
  "pictureId": "14",
  "categories": [
    {"name": "Italia"},
    {"name": "Modern"}
  ],
  "menus": {
    "foods": [
      {"name": "Paket rosemary"},
      {"name": "Toastie salmon"}
    ],
    "drinks": [
      {"name": "Es krim"},
      {"name": "Sirup"}
    ]
  },
  "rating": 4.2,
  "customerReviews": [
    {
      "name": "Ahmad",
      "review": "Tidak rekomendasi untuk pelajar!",
      "date": "13 November 2019"
    }
  ]
};

@GenerateMocks([ApiService])
void main() {
  group('Restaurant Provider Test', () {
    late RestaurantProvider restaurantProvider;
    late ApiService apiService;
    setUp(() {
      apiService = MockApiService();
      when(apiService.ListModel())
          .thenAnswer((_) async => RestaurantList.fromJson(apiResponse));
      restaurantProvider = RestaurantProvider(apiService: apiService);
    });
    test('verify that fetch all restaurants json parse run as expected',
        () async {
      await restaurantProvider.fetchAllArticle();
      var result = restaurantProvider.result.restaurants[0];
      var jsonRestaurant = Restaurant.fromJson(testRestaurant);
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.rating == jsonRestaurant.rating, true);
    });

    test('verify that restaurants search json parse run as expected', () async {
      when(apiService.SearchModel('melting'))
          .thenAnswer((_) async => SearchRestaurant.fromJson(searchResponse));
      await restaurantProvider.fetchAllArticle();
      var result = restaurantProvider.result.restaurants[0];
      var jsonRestaurant = Restaurant_Search.fromJson(testRestaurant);
      expect(result.id == jsonRestaurant.id, true);
      expect(result.name == jsonRestaurant.name, true);
      expect(result.description == jsonRestaurant.description, true);
      expect(result.pictureId == jsonRestaurant.pictureId, true);
      expect(result.city == jsonRestaurant.city, true);
      expect(result.rating == jsonRestaurant.rating, true);
    });
  });
}
