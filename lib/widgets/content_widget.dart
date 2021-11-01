import 'package:kokiku/data/model/content.dart';
import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  final Restaurant restaurant;

  const ContentWidget({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Text(
                          restaurant.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Icon(Icons.location_city_outlined),
                                  SizedBox(height: 8.0),
                                  Text(
                                    restaurant.city,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(Icons.star),
                                  SizedBox(height: 8.0),
                                  Text(
                                    restaurant.rating.toString(),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Icon(Icons.restaurant),
                                  SizedBox(height: 8.0),
                                  Text(
                                    Categories(restaurant.categories),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          child: Text(
                            'Description',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            restaurant.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          child: Text(
                            'Foods',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            printName(restaurant.menus.foods),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          child: Text(
                            'Drinks',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            printName(restaurant.menus.drinks),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          child: Text(
                            'Review',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            Review(restaurant.customerReviews),
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                  backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                ),
              ),
            ),
          ],
        ),
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
