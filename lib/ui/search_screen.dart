import 'package:flutter/material.dart';
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
  TextEditingController _controller = TextEditingController();

  Widget _listSearchRestaurants(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(
        apiService: ApiService(),
      ),
      child: Consumer<SearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            state.fetchAllArticle(queries);
            return Container(
                margin: EdgeInsets.only(left: 5, right: 5),
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
            state.fetchAllArticle(queries);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          ChangeNotifierProvider(
            create: (_) => SearchProvider(apiService: ApiService()),
            child: Consumer<SearchProvider>(
              builder: (context, state, _) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                        leading: Icon(
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
                          decoration: InputDecoration(
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
                          icon: Icon(Icons.close, size: 30),
                        )));
              },
            ),
          ),
          SizedBox(
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
