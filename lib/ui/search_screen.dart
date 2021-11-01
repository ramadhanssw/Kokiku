import 'package:flutter/material.dart';
import 'package:kokiku/utils/result_state.dart';
import 'package:kokiku/widgets/card_search.dart';
import 'package:provider/provider.dart';
import 'package:kokiku/provider/search_provider.dart';
import 'package:kokiku/data/api/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  Widget _listSearchRestaurants(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(
        apiService: ApiService(),
      ),
      child: Consumer<SearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            state.fetchAllArticle(queries);
            return Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardSearch(restaurant: restaurant);
                  },
                ));
          } else if (state.state == ResultState.NoData) {
            state.fetchAllArticle(queries);
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
            state.fetchAllArticle(queries);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          ChangeNotifierProvider(
            create: (_) => SearchProvider(apiService: ApiService()),
            child: Consumer<SearchProvider>(
              builder: (context, state, _) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                        leading: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                        title: TextField(
                          controller: _controller,
                          onChanged: (String value) {
                            setState(() {
                              queries = value;
                            });
                            if (value != '') {
                              state.fetchAllArticle(queries);
                            }
                          },
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                              hintText: "Let's find the restaurant!",
                              border: InputBorder.none),
                        ),
                        trailing: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            if (queries != '') {
                              _controller.clear();
                              setState(() {
                                queries = '';
                              });
                            }
                          },
                          icon: const Icon(Icons.close, size: 30),
                        )));
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 2, right: 2),
              child: _listSearchRestaurants(context),
            ),
          ),
        ],
      ),
    );
  }
}
