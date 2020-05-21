import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Photos',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final widgetOptions = [new ListPage(), Text('Favorite Photos')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //cabeçalho da aplicação
      appBar: AppBar(
        title: Text('Photos'),
      ),

      body: Center(child: widgetOptions.elementAt(selectedIndex)),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_album), title: Text('Galery')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Favorites'))
        ],

        //indicar opção corrente para navegação
        currentIndex: selectedIndex,
        fixedColor: Colors.greenAccent,
        onTap: cliquei,
      ),
    );
  }

  void cliquei(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);
  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          child: new Center(
        child: new FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/photos.json'),
            builder: (context, snapshot) {
              var photos = json.decode(snapshot.data.toString());
              print(photos);
              return new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var photo = photos[index];
                  return new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Padding(
                          padding: EdgeInsets.all(10.0),
                          child: new Text(photo['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ))),
                      new Image.network(
                        photo['thumbnailUrl'],
                        height: 200,
                        width: 200,
                      )
                    ],
                  );
                },
                itemCount: photos == null ? 0 : photos.length,
              );
            }),
      )),
    );
  }
}
