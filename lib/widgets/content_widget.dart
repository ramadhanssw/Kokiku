import 'package:kokiku/data/model/content.dart';
import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  final Restaurant_Content restaurant;

  ContentWidget({Key? key, required this.restaurant}) : super(key: key);

  bool favoriteButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: restaurant.name,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/' +
                        restaurant.pictureId,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                const Icon(Icons.location_city_outlined),
                                const SizedBox(height: 8.0),
                                Text(
                                  restaurant.city,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                const Icon(Icons.star),
                                const SizedBox(height: 8.0),
                                Text(
                                  restaurant.rating.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                const Icon(Icons.restaurant),
                                const SizedBox(height: 8.0),
                                Text(
                                  Categories(restaurant.categories),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Description',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          restaurant.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Foods',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          printName(restaurant.menus.foods),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Drinks',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          printName(restaurant.menus.drinks),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          Review(restaurant.customerReviews),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding:
                      MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

printName(goods) {
  int total = goods.length;
  late String allName = "";
  for (var i = 0; i < total; i++) {
    int checker = total - 1;
    if (i == checker) {
      allName += "• ${goods[i].name}";
    } else {
      allName += "• ${goods[i].name}\n";
    }
  }
  return allName;
}

Review(customers) {
  int total = customers.length;
  late String allName = "";
  for (var i = 0; i < total; i++) {
    int checker = total - 1;
    if (i == checker) {
      allName += "• ${customers[i].name} •\n";
      allName += "Review: ${customers[i].review}\n";
      allName += "Date: ${customers[i].date}";
    } else {
      allName += "• ${customers[i].name} •\n";
      allName += "Review: ${customers[i].review}\n";
      allName += "Date: ${customers[i].date}\n\n";
    }
  }
  return allName;
}

Categories(allcategories) {
  int total = allcategories.length;
  late String allName = "";
  for (var i = 0; i < total; i++) {
    int checker = total - 1;
    if (total == 1) {
      allName += "${allcategories[i].name}";
    } else if (total == 2) {
      if (i == checker) {
        allName += "and ${allcategories[i].name}";
      } else {
        allName += "${allcategories[i].name}, ";
      }
    } else {
      if (i == checker) {
        allName += "and ${allcategories[i].name}";
      } else {
        allName += "${allcategories[i].name}, ";
      }
    }
  }
  return allName;
}
