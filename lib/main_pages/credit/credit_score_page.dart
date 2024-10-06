
import 'package:flutter/material.dart';
import 'package:stonks/main_pages/credit/credit_score_checker.dart';

class CreditScorePage extends StatefulWidget {
  const CreditScorePage({Key? key}) : super(key: key);

  @override
  _CreditScorePageState createState() => _CreditScorePageState();
}

class _CreditScorePageState extends State<CreditScorePage> {
  final TextEditingController _creditScoreController = TextEditingController();
  List<String> recommendations = [];
  List<String> benefits = [];
  final Color _primaryColor = Colors.blue; // Define primary color for consistency

  void _getRecommendation() {
    final int? score = int.tryParse(_creditScoreController.text);
    if (score != null) {
      // Update recommendations based on score range
      recommendations = _getRecommendations(score);
    } else {
      recommendations = ["Please enter a valid credit score."];
    }

    _showRecommendationsDialog();
  }

  void _getBenefits() {
    final int? score = int.tryParse(_creditScoreController.text);
    if (score != null) {
      // Update benefits based on score range
      benefits = _calculateBenefits(score);
    } else {
      benefits = ["Please enter a valid credit score."];
    }

    _showBenefitsDialog();
  }

  List<String> _getRecommendations(int score) {
    if (score < 580) {
      return [
        "Focus on paying bills on time: This is crucial for improving your score.",
        "Reduce credit card debt: Pay down balances as much as possible.",
        "Limit new credit applications: Applying can temporarily lower your score.",
        "Consider a secured credit card: Build credit history if you have limited or no credit.",
        "Dispute errors on your credit report: Correcting errors can improve your score."
      ];
    } else if (score < 700) {
      return [
        "Continue making on-time payments: This remains essential.",
        "Reduce credit card utilization: Keep balances below 30% of credit limits.",
        "Consider a balance transfer: Transfer high-interest balances to a lower APR card.",
        "Monitor your credit report regularly: Check for errors and take steps to correct them.",
        "Consider a credit builder loan: This can help establish or improve your credit history."
      ];
    } else {
      return [
        "Maintain on-time payments: Continue to preserve your good credit.",
        "Keep credit card utilization low: Aim for balances below 30% of credit limits.",
        "Limit new credit applications: Avoid applying unless necessary.",
        "Monitor your credit report regularly: Check for errors and take steps to correct them.",
        "Consider a credit card with rewards: Get cash back or travel miles."
      ];
    }
  }

  List<String> _calculateBenefits(int score) {
    if (score < 580) {
      return [
        "Higher interest rates on loans and credit cards.",
        "Difficulty getting approved for rental applications.",
        "Potential difficulty securing employment in certain industries."
      ];
    } else if (score < 700) {
      return [
        "Access to a wider range of credit products.",
        "Moderate interest rates on loans and credit cards.",
        "Better chances of getting approved for rental applications.",
        "Improved chances of securing employment in certain industries."
      ];
    } else {
      return [
        "Access to the best credit products with the lowest interest rates.",
        "Higher credit limits on credit cards.",
        "Easier approval for rental applications.",
        "Better chances of securing employment in most industries.",
        "Eligibility for credit cards with rewards like cash back or travel miles."
      ];
    }
  }

  void _showRecommendationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Recommendations',
            style: TextStyle(fontWeight: FontWeight.bold, color: _primaryColor),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: recommendations.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: _primaryColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            recommendations[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBenefitsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Benefits I Get',
            style: TextStyle(fontWeight: FontWeight.bold, color: _primaryColor),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: benefits.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: _primaryColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            benefits[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _creditScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Score Transparency'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  CreditScoreChecker()),
                );
              },
              child: const Text('Check Your Credit Score'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _creditScoreController,
              decoration: InputDecoration(
                labelText: 'Enter Your Credit Score',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSquareButton(
                  color: _primaryColor,
                  text: 'Suggestions',
                  onPressed: _getRecommendation,
                ),
                _buildSquareButton(
                  color: Colors.green,
                  text: 'Benefits',
                  onPressed: _getBenefits,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSquareButton(
                  color: Colors.orange,
                  text: 'Loans',
                  onPressed: () {
                    // Add your logic for Loans button
                  },
                ),
                _buildSquareButton(
                  color: Colors.red,
                  text: 'Pay Bill',
                  onPressed: () {
                    // Add your logic for Pay Bill button
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton({
    required Color color,
    required String text,
    required VoidCallback onPressed,
    double width = 150,
  }) {
    return Container(
      width: 150,
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
    );
  }
}
