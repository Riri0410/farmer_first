import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnalysisFarmer(),
  ));
}

class AnalysisFarmer extends StatefulWidget {
  @override
  _AnalysisFarmerState createState() => _AnalysisFarmerState();
}

class _AnalysisFarmerState extends State<AnalysisFarmer> {
  String? _selectedSeason;
  String? _selectedCrop;
  List<String> _crops = [];
  Map<String, String> _cropData = {
    'Lettuce':
        'It is ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Spinach':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Strawberries':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Radishes':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Peas':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Tomatoes':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Corn':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Watermelon':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Cucumbers':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Green beans':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Pumpkins':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Apples':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Squash':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Brussels sprouts':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Carrots':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Kale':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Cabbage':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Potatoes':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Winter squash':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters',
    'Beets':
        'It is NOT ideal to grow this vegetable this time as it is a very secure investment according to your credit score and other parameters'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Analysis'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Select Season:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              DropdownButton<String>(
                value: _selectedSeason,
                hint: const Text('Select season'),
                onChanged: (String? value) {
                  setState(() {
                    _selectedSeason = value;
                    _selectedCrop = null;
                    _crops.clear();
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'Spring',
                    child: const Text('Spring'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Summer',
                    child: const Text('Summer'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Autumn/Fall',
                    child: const Text('Autumn/Fall'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Winter',
                    child: const Text('Winter'),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              if (_selectedSeason != null)
                Text(
                  'Crops for $_selectedSeason:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 10.0),
              if (_selectedSeason != null)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _getCropsForSelectedSeason().length,
                  itemBuilder: (context, index) {
                    String crop = _getCropsForSelectedSeason()[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCrop = crop;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          crop,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: _selectedCrop == crop
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 20.0),
              if (_selectedCrop != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Crop Information:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      _cropData[_selectedCrop] ?? '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              const SizedBox(height: 40.0),
              if (_selectedCrop != null)
                WeatherForecastWidget(locationKey: 'Vellore'),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getCropsForSelectedSeason() {
    switch (_selectedSeason) {
      case 'Spring':
        return [
          'Lettuce',
          'Spinach',
          'Strawberries',
          'Radishes',
          'Peas',
        ];
      case 'Summer':
        return [
          'Tomatoes',
          'Corn',
          'Watermelon',
          'Cucumbers',
          'Green beans',
        ];
      case 'Autumn/Fall':
        return [
          'Pumpkins',
          'Apples',
          'Squash',
          'Brussels sprouts',
          'Carrots',
        ];
      case 'Winter':
        return [
          'Kale',
          'Cabbage',
          'Potatoes',
          'Winter squash',
          'Beets',
        ];
      default:
        return [];
    }
  }
}

class WeatherForecastWidget extends StatefulWidget {
  final String locationKey;

  const WeatherForecastWidget({Key? key, required this.locationKey})
      : super(key: key);

  @override
  _WeatherForecastWidgetState createState() => _WeatherForecastWidgetState();
}

class _WeatherForecastWidgetState extends State<WeatherForecastWidget> {
  List<WeatherForecast> _weatherForecasts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherForecasts();
  }

  Future<void> fetchWeatherForecasts() async {
    final apiKey = 'YOUR_API_KEY';
    final baseUrl = 'https://api.weatherapi.com/v1';
    final forecastDays = 10;
    final url =
        '$baseUrl/forecast.json?key=$apiKey&q=${widget.locationKey}&days=$forecastDays';

    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        _weatherForecasts =
            WeatherForecast.fromList(data['forecast']['forecastday']);
        _isLoading = false;
      });
    } else {
      // Handle error case
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Weather Forecast:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _weatherForecasts.length,
                itemBuilder: (context, index) {
                  final weatherForecast = _weatherForecasts[index];
                  return ListTile(
                    leading: Image.network(
                      'https:${weatherForecast.iconUrl}',
                      width: 40.0,
                      height: 40.0,
                    ),
                    title: Text(
                      weatherForecast.date,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                      '${weatherForecast.condition}\n${weatherForecast.temperature}',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  );
                },
              ),
            ],
          );
  }
}

class WeatherForecast {
  final String date;
  final String condition;
  final String temperature;
  final String iconUrl;

  WeatherForecast({
    required this.date,
    required this.condition,
    required this.temperature,
    required this.iconUrl,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final date = DateFormat('yyyy-MM-dd').format(DateTime.parse(json['date']));
    final condition = json['day']['condition']['text'];
    final avgTemp = json['day']['avgtemp_c'];
    final maxTemp = json['day']['maxtemp_c'];
    final minTemp = json['day']['mintemp_c'];
    final temperature = '$minTemp°C - $maxTemp°C';
    final iconUrl = json['day']['condition']['icon'];

    return WeatherForecast(
      date: date,
      condition: condition,
      temperature: temperature,
      iconUrl: iconUrl,
    );
  }

  static List<WeatherForecast> fromList(List<dynamic> list) {
    return list.map((item) => WeatherForecast.fromJson(item)).toList();
  }
}
