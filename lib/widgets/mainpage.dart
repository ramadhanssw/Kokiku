import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kokiku/widgets/contentpage.dart';
import 'package:kokiku/widgets/profilepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  List<Tab> _categories = [
    Tab(child: Text('All Cities')),
    Tab(child: Text('Bali')),
    Tab(child: Text('Medan')),
    Tab(child: Text('Surabaya')),
    Tab(child: Text('Other Cities')),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _categories.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                var restaurantData = json.decode(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContentPage(
                                        restaurant: restaurantData[index],
                                        tag: restaurantData[index]['city'],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    child: Text(
                                      restaurantData[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_city_outlined),
                                      Text(
                                        restaurantData[index]['city'],
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star),
                                      Text(
                                        restaurantData[index]['rating']
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    restaurantData[index]['pictureId']),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: restaurantData == null ? 0 : restaurantData.length,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                var restaurantData = json.decode(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (restaurantData[index]['city'] == "Bali") {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContentPage(
                                          restaurant: restaurantData[index],
                                          tag: restaurantData[index]['city'],
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                        restaurantData[index]['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_city_outlined),
                                        Text(
                                          restaurantData[index]['city'],
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star),
                                        Text(
                                          restaurantData[index]['rating']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      restaurantData[index]['pictureId']),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center();
                    }
                  },
                  itemCount: restaurantData == null ? 0 : restaurantData.length,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                var restaurantData = json.decode(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (restaurantData[index]['city'] == "Medan") {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContentPage(
                                          restaurant: restaurantData[index],
                                          tag: restaurantData[index]['city'],
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                        restaurantData[index]['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_city_outlined),
                                        Text(
                                          restaurantData[index]['city'],
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star),
                                        Text(
                                          restaurantData[index]['rating']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      restaurantData[index]['pictureId']),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center();
                    }
                  },
                  itemCount: restaurantData == null ? 0 : restaurantData.length,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                var restaurantData = json.decode(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (restaurantData[index]['city'] == "Surabaya") {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContentPage(
                                          restaurant: restaurantData[index],
                                          tag: restaurantData[index]['city'],
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                        restaurantData[index]['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_city_outlined),
                                        Text(
                                          restaurantData[index]['city'],
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star),
                                        Text(
                                          restaurantData[index]['rating']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      restaurantData[index]['pictureId']),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center();
                    }
                  },
                  itemCount: restaurantData == null ? 0 : restaurantData.length,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                var restaurantData = json.decode(snapshot.data.toString());
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (restaurantData[index]['city'] != "Bali" &&
                        restaurantData[index]['city'] != "Medan" &&
                        restaurantData[index]['city'] != "Surabaya") {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContentPage(
                                          restaurant: restaurantData[index],
                                          tag: restaurantData[index]['city'],
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(
                                        restaurantData[index]['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_city_outlined),
                                        Text(
                                          restaurantData[index]['city'],
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.star),
                                        Text(
                                          restaurantData[index]['rating']
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      restaurantData[index]['pictureId']),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center();
                    }
                  },
                  itemCount: restaurantData == null ? 0 : restaurantData.length,
                );
              },
            ),
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
