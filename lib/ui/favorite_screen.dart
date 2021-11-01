import 'package:flutter/material.dart';
import 'package:kokiku/provider/database_provider.dart';
import 'package:kokiku/utils/result_state.dart';
import 'package:kokiku/widgets/card_list.dart';
import 'package:provider/provider.dart';
import 'package:kokiku/provider/restaurant_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardList(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
