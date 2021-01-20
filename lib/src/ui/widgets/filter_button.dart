import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final Color color;
  final Function() onPressed;
  final String label;
  const FilterButton(
      {Key key,
      @required this.color,
      @required this.onPressed,
      @required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
