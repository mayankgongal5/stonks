import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DebtPage extends StatefulWidget {
  final List<Map<String, dynamic>> debts;

  DebtPage({required this.debts});

  @override
  _DebtPageState createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'expense_debt.db'),
      version: 1,
    );
  }

  Future<void> _editEntry(BuildContext context, Map<String, dynamic> entry) async {
    final TextEditingController descriptionController =
        TextEditingController(text: entry['description']);
    final TextEditingController amountController =
        TextEditingController(text: entry['amount'].toString());

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedEntry = {
                  'description': descriptionController.text,
                  'amount': double.parse(amountController.text),
                  'isDebt': entry['isDebt'],
                };
                await _database.update(
                  'entries',
                  updatedEntry,
                  where: 'id = ?',
                  whereArgs: [entry['id']],
                );
                setState(() {
                  final index = widget.debts.indexWhere((e) => e['id'] == entry['id']);
                  widget.debts[index] = updatedEntry;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteEntry(int id) async {
    await _database.delete(
      'entries',
      where: 'id = ?',
      whereArgs: [id],
    );
    setState(() {
      widget.debts.removeWhere((entry) => entry['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debts'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.debts.length,
          itemBuilder: (context, index) {
            final entry = widget.debts[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(entry['description']),
                subtitle: Text('Amount: \$${entry['amount']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editEntry(context, entry),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteEntry(entry['id']),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}