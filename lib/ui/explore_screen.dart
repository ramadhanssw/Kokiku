import 'package:flutter/material.dart';
import 'package:kokiku/widgets/card_list.dart';
import 'package:provider/provider.dart';
import 'package:kokiku/provider/restaurant_provider.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardList(
                restaurant: restaurant,
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          state.fetchAllArticle();
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'assets/img/datanotfound.png',
                  height: 60,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        } else if (state.state == ResultState.Error) {
          state.fetchAllArticle();
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'assets/img/internetproblem.png',
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}
