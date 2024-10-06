
import 'package:flutter/material.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/budgeting_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/compound_interest_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/inflation_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/loan_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/loan_emi_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/retirement_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/savings_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/simple_interest_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/sip_calculator.dart';
import 'package:stonks/main_pages/invesmnet/calci%20ui/swp_calculator.dart';



class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _selectedCalculator = 'Simple Interest Calculator';

  final List<String> _calculatorOptions = [
    'Simple Interest Calculator',
    'Compound Interest Calculator',
    'Loan Calculator',
    'Savings Calculator',
    'Retirement Calculator',
    'SIP (Systematic Investment Plan) Calculator',
    'SWP (Systematic Withdrawal Plan) Calculator',
    'Loan EMI (Equated Monthly Installment) Calculator',
    'Inflation Calculator',
    'Budgeting Calculator'
  ];

  final List<Color> _buttonColors = [
    Colors.red,
    Colors.orange,
    const Color.fromARGB(255, 137, 131, 76),
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
  ];

  void _navigateToCalculator(String calculatorName) {
    Widget page;
    switch (calculatorName) {
      case 'Simple Interest Calculator':
        page = SimpleInterestCalculatorPage();
        break;
      case 'Compound Interest Calculator':
        page = CompoundInterestCalculatorPage();
        break;
      case 'Loan Calculator':
        page = LoanCalculatorPage();
        break;
      case 'Savings Calculator':
        page = SavingsCalculatorPage();
        break;
      case 'Retirement Calculator':
        page = RetirementCalculatorPage();
        break;
      case 'SIP (Systematic Investment Plan) Calculator':
        page = SipCalculatorPage();
        break;
      case 'SWP (Systematic Withdrawal Plan) Calculator':
        page = SwpCalculatorPage();
        break;
      case 'Loan EMI (Equated Monthly Installment) Calculator':
        page = LoanEMICalculatorPage();
        break;
      case 'Inflation Calculator':
        page = InflationCalculatorPage();
        break;
      case 'Budgeting Calculator':
        page = BudgetingCalculatorPage();
        break;
      default:
        page = CalculatorPage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose your type of calculator:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // DropdownButton<String>(
            //   value: _selectedCalculator,
            //   isExpanded: true,
            //   items: _calculatorOptions.map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _selectedCalculator = newValue!;
            //     });
            //   },
            // ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _calculatorOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToCalculator(_calculatorOptions[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _buttonColors[index % _buttonColors.length],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _calculatorOptions[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}