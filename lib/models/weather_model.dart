class Weather {
  final String countryName;
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String mainCondition;
  final String description;
  final double windSpeed;

  Weather({
    required this.countryName, 
    required this.feelsLike, 
    required this.description, 
    required this.windSpeed, 
    required this.cityName, 
    required this.temperature, 
    required this.mainCondition
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      countryName: json['sys']['country'],
      cityName: json['name'], 
      temperature: json['main']['temp'].toDouble(), 
      feelsLike: json['main']['feels_like'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}