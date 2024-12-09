// api_services.dart
import 'dart:convert';
import 'package:dio/dio.dart';

// Define a method to get the predicted house price
Future<double?> predictHousePrice(String type, int bedrooms, double area, String city) async {
  final dio = Dio();  // Create Dio instance

  const url = 'http://10.0.2.2:5000/predict';  // Flask API endpoint (use your IP if on a real device)

  // Create a map of data to send in the POST request
  Map<String, dynamic> requestData = {
    'Type': type,
    'Bedrooms': bedrooms,
    'Area': area,
    'City': city,
  };

  try {
    // Send POST request with the data
    Response response = await dio.post(
      url,
      data: json.encode(requestData),
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      // If the request was successful, parse the JSON response
      final responseBody = response.data;
      return responseBody['predicted_price'];  // Return the predicted price
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error: $error');
    return null;
  }
}
