import 'package:erni_eats_fe/service/mocked-be-data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Erni eats',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: MyHomePage(title: 'Welcome page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getRestaurants(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data.length > 0) {
            return Card(
              child: ListTile(
                trailing: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/alfa.png'),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                title: Text('The Enchanted Nightingale'),
                subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
            );
          }
          return Center();
        },
      ),
    );
  }

  // generateCards(data) {
  //   var cards = <Card>[];
  //   var list = new List<int>.generate(data.length, (index) => index + 1);
  //   list.forEach((element) {
  //     return new Card(
  //             child: ListTile(
  //               trailing: Container(
  //                 height: 80,
  //                 width: 80,
  //                 decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                     fit: BoxFit.fill,
  //                     image: AssetImage('assets/alfa.png'),
  //                   ),
  //                   shape: BoxShape.circle,
  //                 ),
  //               ),
  //               title: Text('The Enchanted Nightingale'),
  //               subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
  //             ),
  //           );
  //   })
  //   // child: Card(
  //   //                 child: ListTile(
  //   //                   trailing: Container(
  //   //                     height: 80,
  //   //                     width: 80,
  //   //                     decoration: BoxDecoration(
  //   //                       image: DecorationImage(
  //   //                         fit: BoxFit.fill,
  //   //                         image: AssetImage('assets/alfa.png'),
  //   //                       ),
  //   //                       shape: BoxShape.circle,
  //   //                     ),
  //   //                   ),
  //   //                   title: Text('The Enchanted Nightingale'),
  //   //                   subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
  //   //                 ),
  //   //               ),
  // }
}
