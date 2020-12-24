import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;
  BarChart({this.expenses});
  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double element) {
      if (element > mostExpensive) {
        mostExpensive = element;
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.arrow_back_outlined),
              Text(
                'Nov 10,2020 - Dec 10,2020',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                label: 'Sun',
                amountSpent: expenses[0],
                mostExpensive: mostExpensive,
              ),
              SizedBox(
                width: 5.0,
              ),
              Bar(
                label: 'Mon',
                amountSpent: expenses[1],
                mostExpensive: mostExpensive,
              ),
              SizedBox(
                width: 5.0,
              ),
              Bar(
                label: 'Tue',
                amountSpent: expenses[2],
                mostExpensive: mostExpensive,
              ),
              SizedBox(
                width: 5.0,
              ),
              Bar(
                label: 'Wen',
                amountSpent: expenses[3],
                mostExpensive: mostExpensive,
              ),
              SizedBox(
                width: 5.0,
              ),
              Bar(
                label: 'Thu',
                amountSpent: expenses[4],
                mostExpensive: mostExpensive,
              ),
              SizedBox(
                width: 5.0,
              ),
              Bar(
                label: 'Fri',
                amountSpent: expenses[5],
                mostExpensive: mostExpensive,
              ),
              SizedBox(
                width: 5.0,
              ),
              Bar(
                label: 'Sat',
                amountSpent: expenses[6],
                mostExpensive: mostExpensive,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 150.0;

  Bar({this.amountSpent, this.label, this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final _barHeight = amountSpent / mostExpensive * _maxBarHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '\$${amountSpent.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
        ),
        Container(
          width: 18.0,
          height: _barHeight,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
