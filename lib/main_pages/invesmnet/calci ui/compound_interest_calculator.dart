import 'package:flutter/material.dart';
import 'dart:math'; // Import the math library for pow

class CompoundInterestCalculatorPage extends StatefulWidget {
  @override
  _CompoundInterestCalculatorPageState createState() => _CompoundInterestCalculatorPageState();
}

class _CompoundInterestCalculatorPageState extends State<CompoundInterestCalculatorPage> {
  double _principal = 0;
  double _rate = 5;
  double _time = 1;
  double _compoundingsPerYear = 1;
  double _compoundInterest = 0;

  void _calculateCompoundInterest() {
    setState(() {
      // Compound Interest Formula: A = P(1 + r/n)^(nt)
      double ratePerPeriod = _rate / 100 / _compoundingsPerYear;
      double periods = _time * _compoundingsPerYear;
      double totalValue = _principal * pow(1 + ratePerPeriod, periods);
      _compoundInterest = totalValue - _principal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compound Interest Calculator'),
        backgroundColor: Colors.orange,
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
            _buildSlider('Time (Years)', _time, 1, 50, (value) {
              setState(() {
                _time = value;
              });
            }),
            _buildSlider('Compoundings per Year', _compoundingsPerYear, 1, 12, (value) {
              setState(() {
                _compoundingsPerYear = value;
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateCompoundInterest,
              child: const Text('Calculate Interest'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.orange,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Compound Interest: ₹${_compoundInterest.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Value: ₹${(_principal + _compoundInterest).toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a slider with label
  // Helper function to build a slider with label
Widget _buildSlider(
    String label, double value, double min, double max, Function(double) onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$label: ${value.toStringAsFixed(0)}',
        style: const TextStyle(fontSize: 18),
      ),
      Slider(
        value: value,
        min: min,
        max: max,
        divisions: (max - min).toInt(),
        label: value.toStringAsFixed(0),
        onChanged: onChanged,
        activeColor: Colors.orange,
        inactiveColor: Colors.orange.shade100,
      ),
    ],
  );
}
}