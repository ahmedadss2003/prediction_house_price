import 'package:flutter/material.dart';

class PredictionForm extends StatefulWidget {
  final Function(String type, int bedrooms, double area, String city) onPredict;

  const PredictionForm({Key? key, required this.onPredict}) : super(key: key);

  @override
  _PredictionFormState createState() => _PredictionFormState();
}

class _PredictionFormState extends State<PredictionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String type = 'Apartment';
  int bedrooms = 3;
  double area = 120.0;
  String city = 'Cairo';

  // Controllers for text fields
  TextEditingController _bedroomsController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _bedroomsController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Type Dropdown
          DropdownButtonFormField<String>(
            value: type,
            decoration: const InputDecoration(
              labelText: 'Type of House',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            items: ['Apartment', 'Villa', 'Penthouse']
                .map((type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                type = value!;
              });
            },
            validator: (value) => value == null ? 'Please select a type' : null,
          ),
          const SizedBox(height: 20),

          // Bedrooms Input Field
          TextFormField(
            controller: _bedroomsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Number of Bedrooms',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of bedrooms';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                bedrooms = int.tryParse(value) ?? 0;
              });
            },
          ),
          const SizedBox(height: 20),

          // Area Input Field
          TextFormField(
            controller: _areaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Area (in square meters)',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the area';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                area = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SizedBox(height: 20),

          // City Input Field
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'City',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the city';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                city = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Predict Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onPredict(type, bedrooms, area, city);
                }
              },
              child:  const Text('Predict Price'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
