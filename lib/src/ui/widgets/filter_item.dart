import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/filter_bloc.dart';

class FilterItem extends StatefulWidget {
  final String title;
  final int id;
  final String type;
  final bool status;
  const FilterItem(
      {Key key,
      @required this.title,
      this.id,
      @required this.type,
      @required this.status})
      : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState(status);
}

class _FilterItemState extends State<FilterItem> {
  bool status;
  _FilterItemState(this.status);

  @override
  Widget build(BuildContext context) {
    bool isSelected = status;

    return FilterChip(
      label: Text(widget.title),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          status = selected;
        });
        status
            ? filterBloc.saveFilters(widget.title, widget.id, widget.type)
            : filterBloc.removeFilters(widget.title, widget.id, widget.type);
      },
    );
  }
}
