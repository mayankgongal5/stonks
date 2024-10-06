import 'package:flutter/material.dart';
import 'dart:math';

class RetirementCalculatorPage extends StatefulWidget {
  @override
  _RetirementCalculatorPageState createState() => _RetirementCalculatorPageState();
}

class _RetirementCalculatorPageState extends State<RetirementCalculatorPage> {
  double _currentSavings = 0;
  double _annualContribution = 0;
  double _annualReturnRate = 5;
  int _yearsUntilRetirement = 1;
  double _futureValue = 0;

  void _calculateFutureValue() {
    setState(() {
      double r = _annualReturnRate / 100; // Convert percentage to decimal
      int n = _yearsUntilRetirement; // Number of years

      // Future Value calculation
      _futureValue = _currentSavings + 
                     (_annualContribution * (pow(1 + r, n) - 1) / r);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retirement Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Current Savings',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _currentSavings = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Annual Contribution',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _annualContribution = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildSlider('Annual Return Rate (%)', _annualReturnRate, 1, 20, (value) {
              setState(() {
                _annualReturnRate = value;
              });
            }),
            _buildSlider('Years Until Retirement', _yearsUntilRetirement.toDouble(), 1, 50, (value) {
              setState(() {
                _yearsUntilRetirement = value.toInt();
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateFutureValue,
              child: const Text('Calculate Future Value'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Future Value at Retirement: ₹${_futureValue.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
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
          activeColor: Colors.blue,
          inactiveColor: Colors.blue.shade100,
        ),
      ],
    );
  }
}