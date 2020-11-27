import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: [
            spendingAmountLabel(constrains),
            SizedBox(height: constrains.maxHeight * 0.05),
            chartBoxIndiactor(constrains, context),
            SizedBox(height: constrains.maxHeight * 0.05),
            dayLabel(constrains),
          ],
        );
      },
    );
  }

  Container dayLabel(BoxConstraints constrains) {
    return Container(
      height: constrains.maxHeight * 0.15,
      child: FittedBox(child: Text(label)),
    );
  }

  Container chartBoxIndiactor(BoxConstraints constrains, BuildContext context) {
    return Container(
      height: constrains.maxHeight * 0.6,
      width: 10,
      child: Stack(
        children: [
          backgroundBox(),
          coloredBox(context),
        ],
      ),
    );
  }

  FractionallySizedBox coloredBox(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: spendingPctOfTotal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Container backgroundBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(220, 220, 220, 1),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
    );
  }

  Container spendingAmountLabel(BoxConstraints constrains) {
    return Container(
      height: constrains.maxHeight * 0.15,
      child: FittedBox(
        child: Text("₹${spendingAmount.toStringAsFixed(0)}"),
      ),
    );
  }
}
