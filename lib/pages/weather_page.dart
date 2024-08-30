import 'package:flutter/material.dart';
import 'package:flutter_minimal_weather_app/models/weather_model.dart';
import 'package:flutter_minimal_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('7f427dc6d3663d41aafed631484e389b');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weather = weather;
      });
    }
    catch (e) {
      print(e);
    }
  }

  // weather animation

  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? 'loading city..'),

            //temperature
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}