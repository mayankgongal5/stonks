import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stonks/main_pages/expense/debt.dart';
import 'package:stonks/main_pages/expense/exp.dart';


class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final List<Map<String, dynamic>> _entries = [];
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isDebt = false;
  late Future<Database> _databaseFuture;

  @override
  void initState() {
    super.initState();
    _databaseFuture = _initDb();
  }

  Future<Database> _initDb() async {
    return openDatabase(
      join(await getDatabasesPath(), 'expense_debt.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE entries(id INTEGER PRIMARY KEY, description TEXT, amount REAL, isDebt INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> _fetchEntries(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('entries');
    setState(() {
      _entries.clear();
      _entries.addAll(maps);
    });
  }

  double get _totalExpenses => _entries
      .where((entry) => entry['isDebt'] == 0)
      .fold(0.0, (sum, entry) => sum + entry['amount']);

  double get _totalDebts => _entries
      .where((entry) => entry['isDebt'] == 1)
      .fold(0.0, (sum, entry) => sum + entry['amount']);

  Future<void> _addEntry(Database db) async {
    if (_descriptionController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    final entry = {
      'description': _descriptionController.text,
      'amount': double.parse(_amountController.text),
      'isDebt': _isDebt ? 1 : 0,
    };

    await db.insert(
      'entries',
      entry,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    setState(() {
      _entries.add(entry);
    });

    _descriptionController.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: _databaseFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Expense and Debt Management'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Expense and Debt Management'),
              centerTitle: true,
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final db = snapshot.data!;
          _fetchEntries(db); // Fetch entries once the database is initialized

          return Scaffold(
            appBar: AppBar(
              title: const Text('Expense and Debt Management'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      hintText: 'Amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(
                      _isDebt ? 'Debt' : 'Expense',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: _isDebt,
                    onChanged: (value) {
                      setState(() {
                        _isDebt = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _addEntry(db);
                      _fetchEntries(
                          db); // Ensure the list is updated after adding an entry
                    },
                    child: const Text('Add Entry'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        // Expenses section
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpPage(
                                    expenses: _entries
                                        .where((e) => e['isDebt'] == 0)
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            child: _buildSection(
                              title: 'Expenses',
                              total: _totalExpenses,
                              color:  Colors.green,
                              points: _entries
                                  .where((entry) => entry['isDebt'] == 0)
                                  .map((entry) =>
                                      '${entry['description']}: \$${entry['amount'].toStringAsFixed(2)}')
                                  .toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Debts section
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DebtPage(
                                    debts: _entries
                                        .where((e) => e['isDebt'] == 1)
                                        .toList(),
                                  ),
                                ),
                              );
                            },
                            child: _buildSection(
                              title: 'Debts',
                              total: _totalDebts,
                              color: Colors.red,
                              points: _entries
                                  .where((entry) => entry['isDebt'] == 1)
                                  .map((entry) =>
                                      '${entry['description']}: \$${entry['amount'].toStringAsFixed(2)}')
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSection({
    required String title,
    required double total,
    required Color color,
    required List<String> points,
  }) {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total: ₹${total.toStringAsFixed(2)}', // Replaced $ with ₹
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ...points.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    point.replaceAll('\$', '₹'), // Replaced $ with ₹ in points
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
