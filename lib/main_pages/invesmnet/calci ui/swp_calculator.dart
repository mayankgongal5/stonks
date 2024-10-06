import 'package:flutter/material.dart';
import 'dart:math';

class SwpCalculatorPage extends StatefulWidget {
  @override
  _SwpCalculatorPageState createState() => _SwpCalculatorPageState();
}

class _SwpCalculatorPageState extends State<SwpCalculatorPage> {
  double _investmentAmount = 0;
  double _annualReturnRate = 12;
  int _investmentDurationYears = 1;
  double _withdrawalAmount = 0;

  void _calculateWithdrawalAmount() {
    setState(() {
      double monthlyRate = _annualReturnRate / 100 / 12; // Convert annual rate to monthly
      int totalMonths = _investmentDurationYears * 12; // Total investment months

      // Withdrawal Amount calculation
      if (monthlyRate != 0) {
        _withdrawalAmount = (_investmentAmount * monthlyRate) / (1 - pow(1 + monthlyRate, -totalMonths));
      } else {
        _withdrawalAmount = _investmentAmount / totalMonths; // If no return, equal withdrawals
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SWP Calculator'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Investment Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _investmentAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildSlider('Annual Return Rate (%)', _annualReturnRate, 1, 20, (value) {
              setState(() {
                _annualReturnRate = value;
              });
            }),
            _buildSlider('Investment Duration (Years)', _investmentDurationYears.toDouble(), 1, 30, (value) {
              setState(() {
                _investmentDurationYears = value.toInt();
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateWithdrawalAmount,
              child: const Text('Calculate Withdrawal Amount'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.purple,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Monthly Withdrawal Amount: ₹${_withdrawalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
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
          activeColor: Colors.purple,
          inactiveColor: Colors.purple.shade100,
        ),
      ],
    );
  }
}