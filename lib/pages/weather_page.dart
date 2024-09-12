import 'package:flutter/material.dart';
import 'package:flutter_minimal_weather_app/models/city_model.dart';
import 'package:flutter_minimal_weather_app/models/weather_model.dart';
import 'package:flutter_minimal_weather_app/services/weather_service.dart';
import 'package:lottie/lottie.dart';

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

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/clear.json';
    }

    switch (mainCondition.toLowerCase()) {
      case 'thunderstorm':
        return 'assets/clear.json';
      
      case 'rain':
        return 'assets/rain.json';
      
      case 'snow':
        return 'assets/snow.json';
      
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squalls':
      case 'tornado':
        return 'assets/atmosphere.json';
      
      case 'clear':
        return 'assets/clear.json';
      
      case 'clouds':
        return 'assets/clouds.json';

      default:
        return 'assets/clear.json';
    }
  }

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
            Text('${_weather?.countryName ?? 'loading country'}: ${_weather?.cityName ?? 'loading city'}'),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // description
            Text('${_weather != null ? _weather?.temperature.round() : "loading weather.."}°C'),

            // description
            Text('${_weather != null ? _weather?.description : "loading weather.."}'),

            // feels like
            Text('Feels like: ${_weather != null ? _weather?.feelsLike.round() : "loading weather.."}°C'),

            // wind speed
            Text('Wind speed: ${_weather != null ? _weather?.windSpeed.round() : "loading wind speed.."} m/s'),
          ],
        ),
      ),
    );
  }
}