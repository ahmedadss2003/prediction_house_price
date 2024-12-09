import 'package:flutter/material.dart';
import 'prediction_form.dart';  // Import the form widget
import 'api_services.dart';  // Import API services to handle prediction

class HousePricePredictionPage extends StatefulWidget {
  @override
  _HousePricePredictionPageState createState() =>
      _HousePricePredictionPageState();
}

class _HousePricePredictionPageState extends State<HousePricePredictionPage> {
  double? predictedPrice;

  // Method to trigger prediction
  Future<void> _predictPrice(String type, int bedrooms, double area, String city) async {
    predictedPrice = await predictHousePrice(type, bedrooms, area, city);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Price Prediction'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'Enter House Details',
             
            ),
            SizedBox(height: 20),

            // Prediction Form Widget
            PredictionForm(onPredict: _predictPrice),

            // Display the prediction result
            if (predictedPrice != null)
              Card(
                color: Colors.amber[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Predicted Price: \$${predictedPrice!.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber[900]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
