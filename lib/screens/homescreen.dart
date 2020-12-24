import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_app/constants.dart';
import 'package:flutter_budget_app/data/data.dart';
import 'package:flutter_budget_app/models/categary_model.dart';
import 'package:flutter_budget_app/widget/bar_chart.dart';

import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  _builCategoies(BuildContext context, Category category, double totalAmount) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryScreen(category: category),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${category.name}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\$${(category.maxAmount - totalAmount).toStringAsFixed(2)}/${totalAmount.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                var widthColor = Colors.grey[400];
                final double percent =
                    (category.maxAmount - totalAmount) / category.maxAmount;
                double barWidth = percent * maxBarWidth;

                if (barWidth < 0) {
                  barWidth = 0;
                }
                if (percent >= 0.66) {
                  widthColor = kHighLevelColor;
                } else if (percent <= 0.33) {
                  widthColor = kLowLevelColor;
                } else {
                  widthColor = kMediumLevelColor;
                }

                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                          color: widthColor,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        '${(percent * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.white),
                      ),
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          forceElevated: true,
          floating: true,
          expandedHeight: 100.0,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Budget UI App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            if (index == 0) {
              return Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6.0,
                        color: Colors.black12,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: BarChart(expenses: weeklySpending),
              );
            } else {
              final Category category = categories[index - 1];
              double totalAmountSpent = 0;
              category.expenses.forEach((element) {
                totalAmountSpent += element.cost;
              });
              return _builCategoies(context, category, totalAmountSpent);
            }
          }, childCount: 1 + categories.length),
        ),
      ]),
    );
  }
}
