import 'package:flutter/material.dart';

import 'package:geocoder/geocoder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Address> _addresses = [];

  // 19b larchwood ave
  //'coordinates': {'latitude': -36.8579576, 'longitude': 174.7268011},
  // double latitude = -36.8579576;
  // double longitude = 174.7268011;

  // auckland airport
  // 'coordinates': {'latitude': -37.004349999999995, 'longitude': 174.7824},
  // double latitude = -37.004349999999995;
  // double longitude = 174.7824;

  // emily place, auckland central
  // 'coordinates': {'latitude': -36.8459377, 'longitude': 174.7688944},
  double latitude = -36.8459377;
  double longitude = 174.7688944;

  // larchwood ave, westmere
  // 'coordinates': {'latitude': -36.8586637, 'longitude': 174.7242143},
  // double latitude = -36.8586637;
  // double longitude = 174.7242143;

  // lemonwood drive, rolleston (beta testing issue #313)
  // double latitude = -43.6191225;
  // double longitude = 172.3904125;

  void _reverseGeocode() async {
    Coordinates coordinates = Coordinates(latitude, longitude);
    List _address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    // print('_reverseGeocode ${_address.length}');

    _address.forEach((addr) => print(addr.toMap().toString()));

    // if(_address.length == 0){
    //   // local has not returned any values, so try using Google Maps service
    //   print('trying to use Google reverse geocode');
    //   // this is greg's personal key which can only be used when at the Grid
    //   // _address = await Geocoder.google('AIzaSyC4CztRY9ghQWat_EiqcaakUHzP-9taIfI').findAddressesFromCoordinates(coordinates);
    //   // _address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // }

    //AIzaSyBZTAzrl3OV7VFgl3zYmaMYqvVzmoA0UyY

    setState(() {
      this._addresses = _address;
    });
  }

  String _addressString() {
    return (this._addresses.length > 0)
        ? this._addresses.first.addressLine
        : 'not avaialble';
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // FutureBuilder(
            //   future: reverseGeocode(Coordinates(38.422, -133.085)),
            //   builder: (BuildContext context, AsyncSnapshot snapshot){
            //     if(snapshot.hasData){
            //       if(snapshot.data != null){

            //       }
            //     }
            //   }
            // ),
            Text('Number of Addresses: ${_addresses.length.toString()}'),
            Text('Address (when present): ${_addressString()}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reverseGeocode,
        tooltip: 'Reverse Geocode',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
