import 'package:flutter/material.dart';
import 'dart:math';

class LoanEMICalculatorPage extends StatefulWidget {
  @override
  _LoanEMICalculatorPageState createState() => _LoanEMICalculatorPageState();
}

class _LoanEMICalculatorPageState extends State<LoanEMICalculatorPage> {
  double _principal = 0;
  double _annualInterestRate = 5;
  int _loanTenure = 12; // in months
  double _emi = 0;

  void _calculateEMI() {
    setState(() {
      double r = _annualInterestRate / 12 / 100; // Monthly interest rate
      int n = _loanTenure; // Loan tenure in months
      _emi = ( _principal * r * pow(1 + r, n) ) / (pow(1 + r, n) - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan EMI Calculator'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Principal Amount (₹)',
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
            _buildSlider('Annual Interest Rate (%)', _annualInterestRate, 1, 20, (value) {
              setState(() {
                _annualInterestRate = value;
              });
            }),
            _buildSlider('Loan Tenure (Months)', _loanTenure.toDouble(), 1, 360, (value) {
              setState(() {
                _loanTenure = value.toInt();
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateEMI,
              child: const Text('Calculate EMI'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.pink,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'EMI: ₹${_emi.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
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
          activeColor: Colors.pink,
          inactiveColor: Colors.pink.shade100,
        ),
      ],
    );
  }
}