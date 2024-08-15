import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton(
      {super.key, this.quantityCount = 1, this.onTapAdd, this.onTapRemove});

  final int? quantityCount;
  final void Function()? onTapAdd;
  final void Function()? onTapRemove;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(7.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Text(
                  'Qty: $quantityCount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                VerticalDivider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: onTapAdd,
                  child: Icon(Icons.add),
                ),
                VerticalDivider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: onTapRemove,
                  child: Icon(Icons.remove),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
