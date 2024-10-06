import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'stock_chart.dart'; // Import the new StockChart widget

class SearchStocksPage extends StatefulWidget {
  const SearchStocksPage({Key? key}) : super(key: key);

  @override
  _SearchStocksPageState createState() => _SearchStocksPageState();
}

class _SearchStocksPageState extends State<SearchStocksPage> {
  final _nameController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<FlSpot> _chartData = [];
  final String _apiKey = ''; // Replace with your API key
  final List<Map<String, String>> _trendingStocks = [
    {'symbol': 'NVDA', 'name': 'Nvidia'},
    {'symbol': 'AAPL', 'name': 'Apple'},
    {'symbol': 'BA', 'name': 'Boeing'},
    {'symbol': 'AMZN', 'name': 'Amazon'},
    {'symbol': 'BABA', 'name': 'Alibaba'},
    {'symbol': 'META', 'name': 'Meta'},
    {'symbol': 'MSFT', 'name': 'Microsoft'},
  ];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _searchStocks() async {
    final String symbol = _nameController.text.trim();
    if (symbol.isEmpty || _startDate == null || _endDate == null) {
      setState(() {
        _chartData = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a stock symbol and select a date range.')),
      );
      return;
    }

    final String startDate = DateFormat('yyyy-MM-dd').format(_startDate!);
    final String endDate = DateFormat('yyyy-MM-dd').format(_endDate!);

    final String url =
        'https://api.polygon.io/v2/aggs/ticker/$symbol/range/1/day/$startDate/$endDate?apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('results')) {
        final List<dynamic> results = data['results'];
        final List<FlSpot> chartData = [];
        for (int i = 0; i < results.length; i++) {
          final dynamic closePrice = results[i]['c'];
          chartData.add(FlSpot(i.toDouble(), closePrice.toDouble()));
        }
        setState(() {
          _chartData = chartData;
        });
        _showChartDialog();
      } else {
        setState(() {
          _chartData = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data available for the given symbol.')),
        );
      }
    } else {
      setState(() {
        _chartData = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch data. Please try again.')),
      );
    }
  }

  Future<void> _fetchStockData(String symbol) async {
    final String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String startDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 30)));

    final String url =
        'https://api.polygon.io/v2/aggs/ticker/$symbol/range/1/day/$startDate/$endDate?apiKey=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('results')) {
        final List<dynamic> results = data['results'];
        final List<FlSpot> chartData = [];
        for (int i = 0; i < results.length; i++) {
          final dynamic closePrice = results[i]['c'];
          chartData.add(FlSpot(i.toDouble(), closePrice.toDouble()));
        }
        setState(() {
          _chartData = chartData;
        });
        _showChartDialog();
      } else {
        setState(() {
          _chartData = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data available for the given symbol.')),
        );
      }
    } else {
      setState(() {
        _chartData = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch data. Please try again.')),
      );
    }
  }

  void _showChartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StockChart(chartData: _chartData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Stocks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Search for Stocks:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter stock name or symbol',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _searchStocks,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Search', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Date Range:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: _startDate == null
                            ? 'Start Date'
                            : DateFormat.yMd().format(_startDate!),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: _endDate == null
                            ? 'End Date'
                            : DateFormat.yMd().format(_endDate!),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Trending Stocks:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _trendingStocks.length,
                itemBuilder: (context, index) {
                  final stock = _trendingStocks[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(stock['name']!),
                      subtitle: Text(stock['symbol']!),
                      onTap: () => _fetchStockData(stock['symbol']!),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
