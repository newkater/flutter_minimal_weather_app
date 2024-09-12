import 'dart:convert';

import 'package:flutter_minimal_weather_app/models/city_model.dart';
import 'package:flutter_minimal_weather_app/models/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(CityModel city) async {
    final response = await http.get(Uri.parse('$BASE_URL?lat=${city.lat}&lon=${city.lon}&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load weather data');
    }
  }

  Future<CityModel?> getCurrentCity() async {

    // get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition();

    // convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //extract the city name from the first placemark
    String? city = placemarks[0].locality;

    return city == null ? null : CityModel(cityName: city, lat: position.latitude, lon: position.longitude);
  }
}