import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

import 'package:date_format/date_format.dart';
import 'package:flutter_glow/flutter_glow.dart';

import 'package:flutter/services.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();

    var date =
        (formatDate(now, [DD, ',', ' ', d, ' ', MM, ' ', yyyy])).toString();
    double _sigmaX = 20.0; // from 0-10
    double _sigmaY = 20.0; // from 0-10
    double _opacity = 0.0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Use [SystemUiOverlayStyle.light] for white status bar
      // or [SystemUiOverlayStyle.dark] for black status bar

      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.grey[850],
          systemNavigationBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/city_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                child: Container(
                  color: Colors.black.withOpacity(_opacity),
                ),
              ),
            ),
            SafeArea(
              //content goes here
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          onPressed: () async {
                            var weatherData =
                                await weather.getLocationWeather();
                            updateUI(weatherData);
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 23.0,
                          ),
                        ),
                        FlatButton(
                            onPressed: () async {
                              var typedName = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CityScreen();
                                  },
                                ),
                              );
                              if (typedName != null) {
                                var weatherData =
                                    await weather.getCityWeather(typedName);
                                updateUI(weatherData);
                              }
                            },
                            child: Text('Search by City')),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$cityName',
                          style: kCityTextStyle,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$date',
                          style: kDateTextStyle,
                        ),
                        SizedBox(height: 40),
                        Container(
                          child: GlowText(
                            weatherIcon,
                            glowColor: Colors.white,
                            blurRadius: 10,
                            style: kConditionTextStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$temperature°',
                              textAlign: TextAlign.center,
                              style: kTempTextStyle,
                            ),
                            Text(
                              'C',
                              textAlign: TextAlign.center,
                              style: kCelciusTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$weatherMessage',
                          style: kMessageTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: 1,
                    child: Container(
                      //black container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                        color: Colors.grey[850],
                      ),
                      width: double.infinity,
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 170,
              top: 580,
              child: TodayCard(
                text: 'Today',
              ),
            ),
            Positioned(
              left: 12,
              top: 625,
              child: SizedBox(
                width: 500,
                height: 200,
                child: ListView.builder(
                  //infinite list
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        InactiveCard(),
                        GlowContainer(
                            spreadRadius: 10,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            glowColor: Color(0xFFaccff),
                            child: ActiveCard(
                              time: '9:00',
                              icon: Icons.wb_cloudy_sharp,
                              temp: '13',
                            )),
                        InactiveCard(
                          time: '10:00',
                          icon: Icons.wb_sunny_sharp,
                          temp: '23',
                        ),
                        InactiveCard(
                          time: '11:00',
                          icon: Icons.wb_shade,
                          temp: '24',
                        ),
                        InactiveCard(
                          time: '12:00',
                          icon: Icons.wb_twighlight,
                          temp: '26',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveCard extends StatelessWidget {
  ActiveCard({this.icon, this.temp, this.time});
  final String time;
  final IconData icon;
  final String temp;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff6281e6),
            // spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Color(0xff6281e6),
            spreadRadius: -4,
            blurRadius: 10,
            offset: Offset(0, 0),
          )
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment
              .bottomRight, // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xff6281e6),
            const Color(0xff7accff)
          ], // red to yellow
          // repeats the gradient over the canvas
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      width: 80,
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(time, style: TextStyle(fontSize: 24, color: Colors.white)),
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          Text(
            temp,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class InactiveCard extends StatelessWidget {
  InactiveCard({this.icon, this.temp, this.time});
  final String time;
  final IconData icon;
  final String temp;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white38,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Colors.transparent,
      ),
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      width: 80,
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('08:00',
              style: TextStyle(fontSize: 24, color: Colors.grey[350])),
          Icon(
            Icons.wb_sunny,
            color: Colors.grey[350],
            size: 40,
          ),
          Text(
            '19°',
            style: TextStyle(fontSize: 24, color: Colors.grey[350]),
          ),
        ],
      ),
    );
  }
}

class TodayCard extends StatelessWidget {
  TodayCard({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        constraints: BoxConstraints(maxHeight: 40, maxWidth: 100),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff6281e6),
              // spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color(0xff6281e6),
              spreadRadius: -4,
              blurRadius: 10,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment
                .bottomRight, // 10% of the width, so there are ten blinds.
            colors: [
              const Color(0xff6281e6),
              const Color(0xff7accff)
            ], // red to yellow
            // repeats the gradient over the canvas
          ),
        ),
        child: Text(text,
            style: TextStyle(
              fontFamily: 'BB Anonym Pro',
              color: Colors.white,
              fontSize: 18.0,
            )));
  }
}
