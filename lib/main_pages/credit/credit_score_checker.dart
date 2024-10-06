import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:math';

class CreditScoreChecker extends StatefulWidget {
  @override
  _CreditScoreCheckerState createState() => _CreditScoreCheckerState();
}

class _CreditScoreCheckerState extends State<CreditScoreChecker> {
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  int? _creditScore;

  @override
  void dispose() {
    _panController.dispose();
    _dobController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _showScore() {
    setState(() {
      _creditScore = Random().nextInt(251) + 600; // Generate a random score between 600 and 850
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Credit Score'),
          content: Container(
            height: 300,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 300,
                  maximum: 850,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 300,
                      endValue: 550,
                      color: Colors.red,
                    ),
                    GaugeRange(
                      startValue: 550,
                      endValue: 700,
                      color: Colors.yellow,
                    ),
                    GaugeRange(
                      startValue: 700,
                      endValue: 850,
                      color: Colors.green,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: _creditScore!.toDouble(),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        '$_creditScore',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.5,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Score Checker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _panController,
              decoration: InputDecoration(
                labelText: 'PAN Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'DD/MM/YYYY',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showScore,
              child: Text('Show Score'),
            ),
          ],
        ),
      ),
    );
  }
}