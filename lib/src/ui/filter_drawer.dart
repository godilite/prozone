import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/filter_bloc.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/ui/shared/style.dart';
import 'package:prozone/src/ui/widgets/filter_button.dart';
import 'widgets/filter_item.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  FilterBloc filterBloc = FilterBloc();

  @override
  void initState() {
    filterBloc.fetchProviderTypes();
    filterBloc.fetchStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'Filters',
                style: heading,
              ),
            ),
          ),
          Text('Filter by Provider Type', style: subHeading),
          typeStreamBuilder(),
          SizedBox(
            height: 50,
          ),
          Text('Filter by Onboarding Status', style: subHeading),
          statusStreamBuilder(),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterButton(
                color: accentOrange,
                onPressed: () => null,
                label: 'Reset',
              ),
              FilterButton(
                color: kBlue,
                onPressed: () => null,
                label: 'Apply',
              ),
            ],
          )
        ],
      ),
    );
  }

  StreamBuilder typeStreamBuilder() {
    return StreamBuilder(
        stream: filterBloc.types,
        builder: (context, snap) {
          return snap.hasData
              ? Wrap(
                  children: snap.data
                      .map<Widget>(
                        (ProviderType x) => FilterItem(
                          title: x.name,
                        ),
                      )
                      .toList(),
                )
              : Container();
        });
  }

  StreamBuilder statusStreamBuilder() {
    return StreamBuilder(
        stream: filterBloc.status,
        builder: (context, snap) {
          return snap.hasData
              ? Wrap(
                  children: snap.data
                      .map<Widget>(
                        (x) => FilterItem(
                          title: x,
                        ),
                      )
                      .toList(),
                )
              : Container();
        });
  }
}
