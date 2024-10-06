// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'search_stocks_page.dart'; // Import the new page

// class InvestmentPage extends StatefulWidget {
//   const InvestmentPage({Key? key}) : super(key: key);

//   @override
//   _InvestmentPageState createState() => _InvestmentPageState();
// }

// class _InvestmentPageState extends State<InvestmentPage> {
//   final _amountController = TextEditingController();
//   String _suggestedInvestment = '';
//   double _riskPercentage = 50; // Default to 50%
//   final Random _random = Random();

//   void _suggestInvestment() {
//   double? amount = double.tryParse(_amountController.text);

//   if (amount == null || amount <= 0) {
//     setState(() {
//       _suggestedInvestment = 'Please enter a valid amount.';
//     });
//     return;
//   }

//   setState(() {
//     _suggestedInvestment = _generateInvestmentPlan(amount, _riskPercentage);
//     _showInvestmentPlanDialog(_suggestedInvestment);
//   });
// }

//   String _generateInvestmentPlan(double amount, double riskPercentage) {
//     double lowRiskAmount = amount * (1 - riskPercentage / 100);
//     double mediumRiskAmount = amount * (riskPercentage / 200);
//     double highRiskAmount = amount * (riskPercentage / 200);

//     List<String> lowRiskOptions = [
//       'Savings Accounts',
//       'Certificates of Deposit (CDs)',
//       'Government Bonds',
//       'Money Market Funds'
//     ];

//     List<String> mediumRiskOptions = [
//       'Corporate Bonds',
//       'Dividend-Paying Stocks',
//       'Index Funds',
//       'Real Estate Investment Trusts (REITs)'
//     ];

//     List<String> highRiskOptions = [
//       'Growth Stocks',
//       'Emerging Market Funds',
//       'Cryptocurrencies',
//       'Venture Capital'
//     ];

//     String getRandomOption(List<String> options) {
//       return options[_random.nextInt(options.length)];
//     }

//     return 'Investment Plan:\n'
//         'Low-Risk Investments:\n'
//         ' - ₹${(lowRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(lowRiskOptions)}\n'
//         ' - ₹${(lowRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(lowRiskOptions)}\n\n'
//         'Medium-Risk Investments:\n'
//         ' - ₹${(mediumRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(mediumRiskOptions)}\n'
//         ' - ₹${(mediumRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(mediumRiskOptions)}\n\n'
//         'High-Risk Investments:\n'
//         ' - ₹${(highRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(highRiskOptions)}\n'
//         ' - ₹${(highRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(highRiskOptions)}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Investment Accessibility'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Enter an amount to invest:',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: _amountController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           hintText: 'Enter amount in ₹',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         'Select your risk tolerance:',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('0'),
//                           Expanded(
//                             child: Slider(
//                               value: _riskPercentage,
//                               min: 0,
//                               max: 100,
//                               divisions: 100,
//                               label: '${_riskPercentage.round()}%',
//                               onChanged: (value) {
//                                 setState(() {
//                                   _riskPercentage = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           const Text('100'),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: _suggestInvestment,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text('Suggest Investment', style: TextStyle(fontSize: 16)),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildSquareButton(
//                             color: Colors.blue,
//                             text: 'Search Stocks',
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => const SearchStocksPage()),
//                               );
//                             },
//                           ),
//                           _buildSquareButton(
//                             color: Colors.green,
//                             text: 'Search Crypto',
//                             onPressed: () {
//                               // Add your logic for Search Crypto button
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildSquareButton(
//                             color: Colors.orange,
//                             text: 'Calculators',
//                             onPressed: () {
//                               // Add your logic for Calculators button
//                             },
//                           ),
//                           _buildSquareButton(
//                             color: Colors.red,
//                             text: 'Technicals',
//                             onPressed: () {
//                               // Add your logic for Technicals button
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//     void _showInvestmentPlanDialog(String investmentPlan) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Investment Plan',
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
//           ),
//           content: Container(
//             width: double.maxFinite,
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: investmentPlan.split('\n').length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8.0),
//                   elevation: 4.0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(
//                       investmentPlan.split('\n')[index],
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text(
//                 'Close',
//                 style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         );
//       },
//     );
//   }

//    Widget _buildSquareButton({required Color color, required String text, required VoidCallback onPressed}) {
//     return Expanded(
//       child: Container(
//         margin: const EdgeInsets.all(8.0),
//         height: 150,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: color,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//           ),
//           onPressed: onPressed,
//           child: Text(
//             text,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:stonks/main_pages/invesmnet/calci.dart';
import 'dart:math';
import 'search_stocks_page.dart'; // Import the new page

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({Key? key}) : super(key: key);

  @override
  _InvestmentPageState createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  final _amountController = TextEditingController();
  String _suggestedInvestment = '';
  double _riskPercentage = 50; // Default to 50%
  final Random _random = Random();

  void _suggestInvestment() {
    double? amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      setState(() {
        _suggestedInvestment = 'Please enter a valid amount.';
      });
      return;
    }

    setState(() {
      _suggestedInvestment = _generateInvestmentPlan(amount, _riskPercentage);
      _showInvestmentPlanDialog(_suggestedInvestment); // Show as a dialog
    });
  }

  String _generateInvestmentPlan(double amount, double riskPercentage) {
    double lowRiskAmount = amount * (1 - riskPercentage / 100);
    double mediumRiskAmount = amount * (riskPercentage / 200);
    double highRiskAmount = amount * (riskPercentage / 200);

    List<String> lowRiskOptions = [
      'Savings Accounts',
      'Certificates of Deposit (CDs)',
      'Government Bonds',
      'Money Market Funds'
    ];

    List<String> mediumRiskOptions = [
      'Corporate Bonds',
      'Dividend-Paying Stocks',
      'Index Funds',
      'Real Estate Investment Trusts (REITs)'
    ];

    List<String> highRiskOptions = [
      'Growth Stocks',
      'Emerging Market Funds',
      'Cryptocurrencies',
      'Venture Capital'
    ];

    String getRandomOption(List<String> options) {
      return options[_random.nextInt(options.length)];
    }

    return 'Investment Plan:\n'
        'Low-Risk Investments:\n'
        ' - ₹${(lowRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(lowRiskOptions)}\n'
        ' - ₹${(lowRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(lowRiskOptions)}\n\n'
        'Medium-Risk Investments:\n'
        ' - ₹${(mediumRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(mediumRiskOptions)}\n'
        ' - ₹${(mediumRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(mediumRiskOptions)}\n\n'
        'High-Risk Investments:\n'
        ' - ₹${(highRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(highRiskOptions)}\n'
        ' - ₹${(highRiskAmount * 0.50).toStringAsFixed(2)} in ${getRandomOption(highRiskOptions)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Accessibility'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter an amount to invest:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter amount in ₹',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select your risk tolerance:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('0'),
                          Expanded(
                            child: Slider(
                              value: _riskPercentage,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: '${_riskPercentage.round()}%',
                              onChanged: (value) {
                                setState(() {
                                  _riskPercentage = value;
                                });
                              },
                            ),
                          ),
                          const Text('100'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // ElevatedButton(
                      //   onPressed: _suggestInvestment,
                      //   style: ElevatedButton.styleFrom(
                      //     padding: const EdgeInsets.symmetric(vertical: 14),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //   ),
                      //   child: const Text('Suggest Investment', style: TextStyle(fontSize: 16)),
                      // ),
                                            const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: _suggestInvestment,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24), backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ), // Button color
                          ),
                          child: const Text(
                            'Suggest Investment',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSquareButton(
                            color: Colors.blue,
                            text: 'Search Stocks',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SearchStocksPage()),
                              );
                            },
                          ),
                          _buildSquareButton(
                            color: Colors.green,
                            text: 'Calculator',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CalculatorPage()),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSquareButton(
                            color: Colors.orange,
                            text: 'Cryptos',
                            onPressed: () {
                              // Add your logic for Calculators button
                            },
                          ),
                          _buildSquareButton(
                            color: Colors.red,
                            text: 'Technicals',
                            onPressed: () {
                              // Add your logic for Technicals button
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInvestmentPlanDialog(String investmentPlan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Investment Plan',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: investmentPlan
                  .split('\n')
                  .map((line) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(line, style: const TextStyle(fontSize: 16)),
                      ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  Widget _buildSquareButton({required Color color, required String text, required VoidCallback onPressed}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        height: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}