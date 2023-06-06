import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Forecast {
  final String date;
  final int temperature;
  final String dayIcon;
  final String nightIcon;

  Forecast({
    required this.date,
    required this.temperature,
    required this.dayIcon,
    required this.nightIcon,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final date = json['Date'];
    final temperature = json['Temperature']['Maximum']['Value'];
    final dayIcon = json['Day']['IconPhrase'];
    final nightIcon = json['Night']['IconPhrase'];

    return Forecast(
      date: date,
      temperature: temperature,
      dayIcon: dayIcon,
      nightIcon: nightIcon,
    );
  }
}

class WeatherForecastWidget extends StatefulWidget {
  @override
  _WeatherForecastWidgetState createState() => _WeatherForecastWidgetState();
}

class _WeatherForecastWidgetState extends State<WeatherForecastWidget> {
  List<Forecast> forecasts = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final apiKey = 'Qz6uFcJGkrGN3GQSpzEDAUG6VbEow4Lk';
    final locationKey =
        'YOUR_LOCATION_KEY'; // Replace with your actual location key

    final url =
        'http://dataservice.accuweather.com/forecasts/v1/daily/15day/$locationKey?apikey=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final forecastData = jsonData['DailyForecasts'] as List<dynamic>;

      setState(() {
        forecasts =
            forecastData.map((json) => Forecast.fromJson(json)).toList();
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('15-Day Forecast'),
      ),
      body: ListView.builder(
        itemCount: forecasts.length,
        itemBuilder: (context, index) {
          final forecast = forecasts[index];
          return ListTile(
            leading: Text(forecast.date),
            title: Text('Temperature: ${forecast.temperature}°C'),
            subtitle: Row(
              children: [
                Text('Day: ${forecast.dayIcon}'),
                const SizedBox(width: 8.0),
                Text('Night: ${forecast.nightIcon}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<String> getLocationKey(String cityName) async {
  final apiKey = 'Qz6uFcJGkrGN3GQSpzEDAUG6VbEow4Lk';
  final url =
      'http://dataservice.accuweather.com/locations/v1/search?apikey=$apiKey&q=$cityName';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body) as List<dynamic>;
    if (jsonData.isNotEmpty) {
      final locationKey = jsonData[0]['Key'] as String;
      return locationKey;
    }
  } else {
    // Handle error
    print('Error: ${response.statusCode}');
  }

  return '';
}

void main() async {
  final locationKey = await getLocationKey('Vellore');
  print('Location Key for Vellore: $locationKey');
}
