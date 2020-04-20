import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './transaction.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',

      theme: ThemeData(

        primarySwatch: Colors.grey,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'Opensans',fontWeight: FontWeight.bold,fontSize: 18)),
        appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(fontFamily: 'OpenSans',fontSize: 20,fontWeight: FontWeight.bold)))
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  
 /* String titleInput;
  String amountInput;*/
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();



  final List<Transaction> userTransaction = [
   /* Transaction(
        id: 't1', title: 'My shoes', amount: 68.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'My TShirt', amount: 78.99, date: DateTime.now())*/
  ];

  void addNewTransaction(String txTitle, double txAmout) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmout,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      userTransaction.add(newTx);
    });
  }


  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder:(_){
      return GestureDetector(
        child:NewTransaction(addNewTransaction),
        onTap: (){},
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add,),onPressed: () => startAddNewTransaction(context),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
               TransactionList(userTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      onPressed: () => startAddNewTransaction(context),),
    );
  }
}
