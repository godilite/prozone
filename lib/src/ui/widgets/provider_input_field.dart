import 'package:flutter/material.dart';
import 'package:prozone/src/ui/shared/style.dart';

class ProviderInputField extends StatelessWidget {
  const ProviderInputField({
    Key key,
    @required String title,
    @required Function(String) onChange,
  })  : _title = title,
        _onChange = onChange,
        super(key: key);

  final String _title;
  final Function(String) _onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: TextStyle(
                color: Colors.grey.shade500, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: TextFormField(
              keyboardType: TextInputType.name,
              style: TextStyle(
                  color: Colors.grey.shade700, fontWeight: FontWeight.bold),
              onChanged: _onChange,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kBlue, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kBorder, width: 2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
