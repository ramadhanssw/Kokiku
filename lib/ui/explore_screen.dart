import 'package:flutter/material.dart';
import 'package:kokiku/utils/result_state.dart';
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
          return const Center(child: CircularProgressIndicator());
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
          return Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  'assets/img/datanotfound.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(
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
          return Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  'assets/img/internetproblem.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(
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
          return const Center(child: Text(''));
        }
      },
    );
  }
}
