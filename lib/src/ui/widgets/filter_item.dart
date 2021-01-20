import 'package:flutter/material.dart';

class FilterItem extends StatefulWidget {
  final String title;
  const FilterItem({Key key, this.title}) : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.title),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          isSelected = selected;
        });
      },
    );
  }
}
