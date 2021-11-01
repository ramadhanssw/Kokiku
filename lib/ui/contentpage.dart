import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:kokiku/provider/content_provider.dart';
import 'package:kokiku/widgets/content_widget.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContentProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return Container(
            child: ContentWidget(restaurant: state.result.restaurant),
          );
        } else if (state.state == ResultState.NoData) {
          state.fetchContentArticle();
          return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
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
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[900]),
                      ),
                    ),
                  ),
                ],
              ));
        } else if (state.state == ResultState.Error) {
          state.fetchContentArticle();
          return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/img/internetproblem.png',
                          height: 60,
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
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(10.0)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[900]),
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}
