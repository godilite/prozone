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
  @override
  void didChangeDependencies() {
    filterBloc.fetchProviderTypes();
    filterBloc.fetchStatus();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
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
            SizedBox(
              height: 30,
            ),
            Text('Provider Type', style: subHeading),
            SizedBox(
              height: 10,
            ),
            typeStreamBuilder(),
            SizedBox(
              height: 30,
            ),
            Text('Onboarding Status', style: subHeading),
            SizedBox(
              height: 10,
            ),
            statusStreamBuilder(),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(
                  color: accentOrange,
                  onPressed: () => filterBloc.resetFilter(),
                  label: 'Reset',
                ),
                FilterButton(
                  color: kBlue,
                  onPressed: () => filterBloc.applyFilters(),
                  label: 'Apply',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  StreamBuilder typeStreamBuilder() {
    return StreamBuilder<List<ProviderType>>(
        stream: filterBloc.types,
        builder: (context, snap) {
          return snap.connectionState == ConnectionState.active && snap.hasData
              ? Wrap(
                  children: snap.data
                      .map<Widget>(
                        (ProviderType x) => FilterItem(
                          title: x.name,
                          id: x.id,
                          type: 'provider_type',
                          status: x.status,
                        ),
                      )
                      .toList(),
                )
              : Container(
                  child: CircularProgressIndicator(),
                );
        });
  }

  StreamBuilder statusStreamBuilder() {
    return StreamBuilder<List>(
        stream: filterBloc.status,
        builder: (context, snap) {
          return snap.hasData
              ? Wrap(
                  children: snap.data
                      .map<Widget>(
                        (x) => FilterItem(
                          title: x['title'],
                          status: x['status'],
                          type: 'status',
                        ),
                      )
                      .toList(),
                )
              : Container();
        });
  }
}
