import 'package:flutter/material.dart';
import 'dart:math';

class InflationCalculatorPage extends StatefulWidget {
  @override
  _InflationCalculatorPageState createState() => _InflationCalculatorPageState();
}

class _InflationCalculatorPageState extends State<InflationCalculatorPage> {
  double _presentValue = 0;
  double _inflationRate = 3;
  int _durationYears = 1;
  double _futureValue = 0;

  void _calculateFutureValue() {
    setState(() {
      _futureValue = _presentValue * pow((1 + _inflationRate / 100), _durationYears);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inflation Calculator'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Present Value (₹)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _presentValue = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildSlider('Inflation Rate (%)', _inflationRate, 1, 20, (value) {
              setState(() {
                _inflationRate = value;
              });
            }),
            _buildSlider('Duration (Years)', _durationYears.toDouble(), 1, 30, (value) {
              setState(() {
                _durationYears = value.toInt();
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateFutureValue,
              child: const Text('Calculate Future Value'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Future Value: ₹${_futureValue.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a slider with label
  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged) {
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
          activeColor: Colors.teal,
          inactiveColor: Colors.teal.shade100,
        ),
      ],
    );
  }
}