import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pex/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (DateTime(
                    recentTransactions[i].date.year,
                    recentTransactions[i].date.month,
                    recentTransactions[i].date.day) ==
                DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }
      return {0
        'day': DateFormat.E().format(weekDay).substring(0,2),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return (sum + (item['amount'] as double));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return ChartBar(data['day'].toString(), data['amount'] as double,
            totalSpending ==0 ? 0.0 :  ((data['amount'] as double)/ 1000));
        }).toList(),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:pex/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  Map<String, double>  groupedTransactionValues() {

    Map<String, double> spending = {};
    double totalSum = 0;
    recentTransaction.forEach((transaction) {
      if (DateTime(transaction.date.year, transaction.date.month, transaction.date.day) == DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)  ){
        totalSum = totalSum + transaction.amount;
        spending[DateFormat.E().format(transaction.date)] = totalSum;
      }
    });
    return spending;


    /*return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      ); [this is the logic for having all 7 expense tubes in the chart
      double totalSum = 0.0;


      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay).substring(0, 1));
      print("Total Sum: $totalSum");
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();*/
  }

  double totalSpending() {
    double totalSpending = 0;
    groupedTransactionValues().forEach((key, value) {
      totalSpending = totalSpending + value;
    });
    return totalSpending;

    /*return groupedTransactionValues.fold(0.0, (sum, item) {
      return (sum + (item['amount'] as double));
    });*/
  }

  List<Widget> getChildren(){
    List<Widget> children = [];
    groupedTransactionValues().forEach((key, value) {
      children.add(Flexible(
        fit: FlexFit.tight,
        child: ChartBar(key, value,
            value / totalSpending()),
      ));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getChildren()
          /*children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar('${data['day']}', (data['amount'] as double),
                  (data['amount'] as double) / totalSpending()),
            );
          }).toList(),*/
        ),
      ),
    );
  }
}
*/
