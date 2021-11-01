import 'package:flutter/material.dart';
import 'package:kokiku/data/api/api_service.dart';
import 'package:kokiku/ui/profilepage.dart';
import 'package:kokiku/ui/explore_screen.dart';
import 'package:kokiku/ui/search_screen.dart';
import 'package:kokiku/check_internet.dart';
import 'package:provider/provider.dart';
import 'package:kokiku/provider/restaurant_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  List<Tab> _categories = [
    Tab(child: Text('Explore')),
    Tab(child: Text('Search')),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    checkInternet().checkConnection(context);
    _tabController = TabController(vsync: this, length: _categories.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    checkInternet().listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Color(0xFF1A244C),
          title: Row(
            children: [
              Icon(Icons.restaurant_menu),
              Text(
                "Kokiku",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            )
          ],
          bottom: PreferredSize(
            child: TabBar(
              tabs: _categories,
              controller: _tabController,
              isScrollable: true,
            ),
            preferredSize: Size.fromHeight(30.0),
          ),
        ),
      ),
      body: TabBarView(
        children: [
          ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider(apiService: ApiService()),
            child: RestaurantListPage(),
          ),
          SearchScreen(),
        ],
        controller: _tabController,
      ),
    );
  }
}
