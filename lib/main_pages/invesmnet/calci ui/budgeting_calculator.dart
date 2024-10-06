import 'package:flutter/material.dart';

class BudgetingCalculatorPage extends StatefulWidget {
  @override
  _BudgetingCalculatorPageState createState() => _BudgetingCalculatorPageState();
}

class _BudgetingCalculatorPageState extends State<BudgetingCalculatorPage> {
  double _totalIncome = 0;
  double _savings = 0;
  double _necessities = 0;
  double _entertainment = 0;
  double _investments = 0;
  double _remainingBudget = 0;

  void _calculateRemainingBudget() {
    setState(() {
      _remainingBudget = _totalIncome - (_savings + _necessities + _entertainment + _investments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgeting Calculator'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Total Income (₹)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _totalIncome = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildBudgetField('Savings', (value) {
              setState(() {
                _savings = double.tryParse(value) ?? 0;
              });
            }),
            _buildBudgetField('Necessities', (value) {
              setState(() {
                _necessities = double.tryParse(value) ?? 0;
              });
            }),
            _buildBudgetField('Entertainment', (value) {
              setState(() {
                _entertainment = double.tryParse(value) ?? 0;
              });
            }),
            _buildBudgetField('Investments', (value) {
              setState(() {
                _investments = double.tryParse(value) ?? 0;
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateRemainingBudget,
              child: const Text('Calculate Remaining Budget'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.cyan,
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Remaining Budget: ₹${_remainingBudget.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build a budget input field
  Widget _buildBudgetField(String label, Function(String) onChanged) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
    );
  }
}