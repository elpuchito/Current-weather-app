import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkH networkHelper = NetworkH(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=f62b501cc274cf6e2101bafe830dcec8&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkH networkHelper = NetworkH(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitud}&lon=${location.longitud}&appid=f62b501cc274cf6e2101bafe830dcec8&units=metric');
    //'https://api.openweathermap.org/data/2.5/weather?lat=6.2608337&lon=-75.5711769&appid=f62b501cc274cf6e2101bafe830dcec8&units=metric');

    var weatherData = await networkHelper.getData();
    return (weatherData);
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '🌩';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ice cream time';
    } else if (temp > 20) {
      return 'Time for shorts and t-shirts';
    } else if (temp < 10) {
      return 'You\'ll need a scarf and gloves';
    } else {
      return 'Bring a coat just in case';
    }
  }
}
