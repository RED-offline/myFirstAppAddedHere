import 'package:flutter/material.dart';
import 'package:test_project/constants.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? amount;
  final double? percentageOfTotal;

  const ChartBar({super.key, this.label, this.amount, this.percentageOfTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
          child: FittedBox(
            child: Text('\$ ${amount!.toStringAsFixed(0)}'),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 15,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: percentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: accentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        FittedBox(
          child: Text(label!),
        ),
      ],
    );
  }
}
