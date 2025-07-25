// import 'package:first_class/Rest%20API%20pr/weatherserviceapi.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/api/weatherserviceapi.dart';
// import 'WeatherService.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _service = WeatherService();
  String? temperature;
  String? description;
  String? cityName;
  String? error;

  void getWeather(String city) async {
    final data = await _service.fetchWeather(city);

    if (data != null) {
      setState(() {
        temperature = data['main']['temp'].toString();
        description = data['weather'][0]['description'];
        cityName = data['name'];
        error = null;
      });
    } else {
      setState(() {
        temperature = null;
        description = null;
        cityName = null;
        error = "City not found!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Simple Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
              ),
              onSubmitted: getWeather,
            ),
            const SizedBox(height: 20),
            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red))
            else if (temperature != null)
              Column(
                children: [
                  Text(
                    '$cityName',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$temperature °C',
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    '$description',
                    style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 220,),
                  Text("By \nMirza Areeb Baig",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
          ],
        ),
      ),
    );
  }
}

