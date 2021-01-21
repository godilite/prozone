import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:prozone/src/ui/shared/style.dart';

class DropDownInput extends StatelessWidget {
  const DropDownInput({
    Key key,
    @required String title,
    @required Widget dropdownSearch,
  })  : _title = title,
        _dropdownSearch = dropdownSearch,
        super(key: key);

  final String _title;
  final Widget _dropdownSearch;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          _title,
          style: TextStyle(
              color: Colors.grey.shade500, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey.shade100, border: Border.all(color: kGrey)),
            child: _dropdownSearch)
      ]),
    );
  }
}
