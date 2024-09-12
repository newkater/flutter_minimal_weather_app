import 'package:flutter/material.dart';
import 'package:flutter_minimal_weather_app/models/city_model.dart';
import 'package:flutter_minimal_weather_app/models/weather_model.dart';
import 'package:flutter_minimal_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('3fb78241d86f83f6701a533b8f04737a');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    CityModel? city = await _weatherService.getCurrentCity();

    if (city == null) {
      throw Exception('failed to load weather data');
    }

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(city);

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
            Text('${_weather != null ? _weather?.temperature.round() : "loading weather.."}°C'),
          ],
        ),
      ),
    );
  }
}