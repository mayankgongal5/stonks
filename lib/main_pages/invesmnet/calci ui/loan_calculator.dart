import 'package:flutter/material.dart';
import 'dart:math';

class LoanCalculatorPage extends StatefulWidget {
  @override
  _LoanCalculatorPageState createState() => _LoanCalculatorPageState();
}

class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  double _loanAmount = 0;
  double _annualInterestRate = 5;
  double _loanTerm = 1;
  double _emi = 0;

  void _calculateEMI() {
    setState(() {
      double monthlyInterestRate = _annualInterestRate / 12 / 100; // Convert annual rate to monthly
      int totalMonths = (_loanTerm * 12).toInt(); // Convert years to months

      if (_loanAmount > 0 && monthlyInterestRate > 0) {
        // EMI formula calculation
        _emi = (_loanAmount * monthlyInterestRate * pow(1 + monthlyInterestRate, totalMonths)) /
            (pow(1 + monthlyInterestRate, totalMonths) - 1);
      } else {
        _emi = 0; // Reset EMI if inputs are not valid
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Calculator'),
        backgroundColor: Color.fromARGB(255, 137, 131, 76),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Loan Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _loanAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildSlider('Annual Interest Rate (%)', _annualInterestRate, 1, 20, (value) {
              setState(() {
                _annualInterestRate = value;
              });
            }),
            _buildSlider('Loan Term (Years)', _loanTerm, 1, 30, (value) {
              setState(() {
                _loanTerm = value;
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateEMI,
              child: const Text('Calculate EMI'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Color.fromARGB(255, 137, 131, 76),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Monthly EMI: ₹${_emi.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 137, 131, 76),
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
          activeColor: Color.fromARGB(255, 137, 131, 76),
          inactiveColor: Color.fromARGB(255, 137, 131, 76),
        ),
      ],
    );
  }
}