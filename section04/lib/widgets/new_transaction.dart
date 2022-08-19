import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key, required this.addTransaction})
      : super(key: key);

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_titleController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
      txTitle: enteredTitle,
      txAmount: enteredAmount,
      txDate: _selectedDate,
    );
    // close top-most sheet
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // TextField Card
      elevation: 2,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title:'),
                controller: _titleController,
                // function takes a variable but it's throw away in this instance '(_)'
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount:'),
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                // function takes a variable but it's throw away in this instance '(_)'
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen.'
                            : 'Chosen date: ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: const Text('Choose date.'),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
