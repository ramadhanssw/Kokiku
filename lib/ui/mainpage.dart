import 'package:flutter/material.dart';
import 'package:kokiku/ui/favorite_screen.dart';
import 'package:kokiku/ui/profilepage.dart';
import 'package:kokiku/ui/explore_screen.dart';
import 'package:kokiku/ui/search_screen.dart';
import 'package:kokiku/check_internet.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> _categories = [
    const Tab(child: Text('Explore')),
    const Tab(child: Text('Search')),
    const Tab(child: Text('Favorite')),
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
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: const Color(0xFF1A244C),
          title: Row(
            children: const [
              Icon(Icons.restaurant_menu),
              Text(
                "Kokiku",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
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
            preferredSize: const Size.fromHeight(30.0),
          ),
        ),
      ),
      body: TabBarView(
        children: const [
          RestaurantListPage(),
          SearchScreen(),
          FavoriteScreen(),
        ],
        controller: _tabController,
      ),
    );
  }
}
