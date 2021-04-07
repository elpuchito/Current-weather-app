import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:clima/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'f62b501cc274cf6e2101bafe830dcec8';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double long;
  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  // void getLocation() async {
  //   final location = Location();
  //   await location.getCurrentLocation();
  //   lat = (location.latitud);

  //   long = (location.longitud);
  // }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
    // http.Response response = await http.get(
    //     //'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=f62b501cc274cf6e2101bafe830dcec8');
    //     'https://api.openweathermap.org/data/2.5/weather?q=Miami&APPID=$apiKey&units=metric');
    // if (response.statusCode == 200) {
    //   String data = response.body;
    //   var condition = jsonDecode(data)['weather'][0]['id'];
    //   var temp = jsonDecode(data)['main']['temp'];
    //   var city = jsonDecode(data)['name'];
    //   print(condition);
    //   print(temp);
    //   print(city);
    // }
    // print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRing(
          color: Colors.white54,
          size: 50.0,
        ),
      ),
    );
  }
}
