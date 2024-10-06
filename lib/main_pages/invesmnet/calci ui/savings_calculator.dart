import 'package:flutter/material.dart';
import 'dart:math';

class SavingsCalculatorPage extends StatefulWidget {
  @override
  _SavingsCalculatorPageState createState() => _SavingsCalculatorPageState();
}

class _SavingsCalculatorPageState extends State<SavingsCalculatorPage> {
  double _initialInvestment = 0;
  double _annualInterestRate = 5;
  int _years = 1;
  double _futureValue = 0;

  void _calculateFutureValue() {
    setState(() {
      // Future Value calculation
      double rate = _annualInterestRate / 100; // Convert percentage to decimal
      _futureValue = _initialInvestment * pow(1 + rate, _years);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Calculator'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Initial Investment',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _initialInvestment = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildSlider('Annual Interest Rate (%)', _annualInterestRate, 1, 20, (value) {
              setState(() {
                _annualInterestRate = value;
              });
            }),
            _buildSlider('Investment Duration (Years)', _years.toDouble(), 1, 30, (value) {
              setState(() {
                _years = value.toInt();
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateFutureValue,
              child: const Text('Calculate Future Value'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.green,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Future Value: ₹${_futureValue.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
          activeColor: Colors.green,
          inactiveColor: Colors.green.shade100,
        ),
      ],
    );
  }
}