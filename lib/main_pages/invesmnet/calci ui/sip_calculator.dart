import 'package:flutter/material.dart';
import 'dart:math';

class SipCalculatorPage extends StatefulWidget {
  @override
  _SipCalculatorPageState createState() => _SipCalculatorPageState();
}

class _SipCalculatorPageState extends State<SipCalculatorPage> {
  double _monthlyInvestment = 0;
  double _annualReturnRate = 12;
  int _investmentDurationYears = 1;
  double _futureValue = 0;

  void _calculateFutureValue() {
    setState(() {
      double monthlyRate = _annualReturnRate / 100 / 12; // Convert annual rate to monthly
      int totalMonths = _investmentDurationYears * 12; // Total investment months

      // Future Value calculation
      _futureValue = _monthlyInvestment * ((pow(1 + monthlyRate, totalMonths) - 1) / monthlyRate) * (1 + monthlyRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIP Calculator'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Monthly Investment',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _monthlyInvestment = double.tryParse(value) ?? 0;
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
              onPressed: _calculateFutureValue,
              child: const Text('Calculate Future Value'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.indigo,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Future Value of SIP: ₹${_futureValue.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
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
          activeColor: Colors.indigo,
          inactiveColor: Colors.indigo.shade100,
        ),
      ],
    );
  }
}