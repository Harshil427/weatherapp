import 'dart:convert';
import 'package:http/http.dart' as http;

class GetData {
  Future<Map<String, dynamic>> fetchData({
    required double latitude,
    required double longitude,
  }) async {
    int day = 1;
    try {
      String apiUrl =
          'http://api.weatherapi.com/v1/forecast.json?key=03521a110569495385f62734232105&q=$latitude,$longitude&days=$day&aqi=no&alerts=no&hour=24';

      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        String data = response.body;
        return parseWeatherData(data);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Failed to get data: $e');
      return {};
    }
  }

  Map<String, dynamic> parseWeatherData(String jsonData) {
    var data = jsonDecode(jsonData);
    List<dynamic> hourlyData = data['forecast']['forecastday'][0]['hour'];

    return {
      'locationName': getLocationName(data),
      'temperatureCelsius': getTemperatureCelsius(data),
      'condition': getCondition(data),
      'iconName': data['current']['condition']['icon'],
      'humidity': data['current']['humidity'],
      'windKph': data['current']['wind_kph'],
      'cloud': data['current']['cloud'],
      'hourlyData': getHourlyData(hourlyData),
    };
  }

  String getLocationName(Map<String, dynamic> data) {
    var location = data['location'];
    return location['name'];
  }

  double getTemperatureCelsius(Map<String, dynamic> data) {
    var current = data['current'];
    return current['temp_c'];
  }

  String getCondition(Map<String, dynamic> data) {
    var current = data['current'];
    var condition = current['condition'];
    return condition['text'];
  }

  List<Map<String, dynamic>> getHourlyData(List<dynamic> hourlyData) {
    return hourlyData.map((hour) {
      return {
        'time': DateTime.parse(hour['time']),
        'icon': hour['condition']['icon'],
        'temp': hour['temp_c'],
      };
    }).toList();
  }
}
