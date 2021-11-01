import 'package:kokiku/data/model/search.dart';
import 'package:kokiku/ui/contentpage.dart';
import 'package:flutter/material.dart';
import 'package:kokiku/provider/content_provider.dart';
import 'package:provider/provider.dart';
import 'package:kokiku/data/api/api_service.dart';

class CardSearch extends StatelessWidget {
  final Restaurant restaurant;

  const CardSearch({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<ContentProvider>(
                create: (_) =>
                    ContentProvider(restaurant.id, apiService: ApiService()),
                child: ContentPage(),
              ),
            ),
          );
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: Text(
                      restaurant.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city_outlined),
                      Text(
                        restaurant.city,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star),
                      Text(
                        restaurant.rating.toString(),
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: 100,
                width: 100,
                child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/' +
                        restaurant.pictureId),
              )
            ],
          ),
        ),
      ),
    );
  }
}
