import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

DateTime? _selectedDate ;

  void _submitData() {
    if(_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate==null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate:DateTime(2020) , 
      lastDate: DateTime.now(),).then((pickeddate) {
        if(pickeddate==null){
          return;
        }
setState(() {
  _selectedDate=pickeddate;
});
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10)
                  // ),
                  labelText: "Title"),
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  //   border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10)
                  // ),
                  labelText: "Amount"),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_selectedDate==null?"No date choosen":DateFormat.yMd().format(_selectedDate ?? DateTime.now()),),
                  TextButton(onPressed: _presentDatePicker,
                  
                   child: Text("Choose date"))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitData, child: Text("Add transaction"))
          ],
        ),
      ),
    );
  }
}
