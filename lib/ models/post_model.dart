class Weather {
  // api ma aapel name sachha lakhva.. no spaling mistekcs

  final String main;
  final String description;
  final double temp;
  final int humidity;
  final double speed;
  final String country;

  Weather({
    required this.main,
    required this.description,
    required this.temp,
    required this.humidity,
    required this.speed,
    required this.country,
  });

  factory Weather.fromJson({required Map json}) {
    // path joy ne apavo list ni under map aevu aave so..
    return Weather(
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'],
      humidity: json['main']['humidity'],
      speed: json['wind']['speed'],
      country: json['sys']['country'],
    );
  }
}
