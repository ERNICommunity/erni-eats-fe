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
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Restaurant restaurant = snapshot.data[index];
                  return Card(
                    child: ListTile(
                      trailing: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(restaurant.imgUrl),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(restaurant.title),
                      subtitle:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${'*' * restaurant.estimation.value} (${restaurant.estimation.votes})'),
                              Text('${'€' * restaurant.priceCategory} • ${restaurant.type}'),
                            ],
                          ),
                    ),
                  );
                });
          }
          return Center();
        },
      ),
    );
  }
}
