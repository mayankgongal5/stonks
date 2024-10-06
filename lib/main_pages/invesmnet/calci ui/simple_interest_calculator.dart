import 'package:flutter/material.dart';

class SimpleInterestCalculatorPage extends StatefulWidget {
  @override
  _SimpleInterestCalculatorPageState createState() => _SimpleInterestCalculatorPageState();
}

class _SimpleInterestCalculatorPageState extends State<SimpleInterestCalculatorPage> {
  double _principal = 0;
  double _rate = 5;
  double _time = 1;
  double _interest = 0;

  void _calculateInterest() {
    setState(() {
      _interest = (_principal * _rate * _time) / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Principal',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _principal = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildSlider('Rate (%)', _rate, 1, 100, (value) {
              setState(() {
                _rate = value;
              });
            }),
            _buildSlider('Time (Years)', _time, 1, 100, (value) {
              setState(() {
                _time = value;
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateInterest,
              child: const Text('Calculate Interest'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), backgroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Simple Interest: ₹${_interest.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Value: ₹${(_principal + _interest).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a slider with label
  Widget _buildSlider(
      String label, double value, double min, double max, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 18),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 100,
          label: value.toStringAsFixed(2),
          onChanged: onChanged,
          activeColor: Colors.red,
          inactiveColor: Colors.red.shade100,
        ),
      ],
    );
  }
}