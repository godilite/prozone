import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/filter_bloc.dart';
import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/ui/shared/routes.dart';

import 'shared/style.dart';

class ProviderList extends StatefulWidget {
  @override
  _ProviderListState createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList> {
  ProviderBloc _providerBloc = ProviderBloc();
  @override
  void initState() {
    _providerBloc.fetchAllProviders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.sort_outlined,
                color: kBlue,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        centerTitle: true,
        title: Container(
          height: 40,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.SearchRoute),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                  fillColor: kGrey,
                  filled: true,
                  disabledBorder: searchBorder,
                  prefixIcon: Icon(Icons.search_outlined)),
            ),
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Providers',
              style: heading,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: constraints.maxHeight * 0.9,
              child: StreamBuilder<List<ProviderModel>>(
                  stream: _providerBloc.providers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.length > 0
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return providerItem(snapshot.data[index]);
                              })
                          : Center(
                              child: Text(
                                'No Providers found',
                                style: subtrail,
                              ),
                            );
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: kBlue,
                    ));
                  }),
            )
          ]),
        );
      }),
      endDrawer: FilterWidget(),
    );
  }

  providerItem(ProviderModel provider) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 6,
                color: Colors.grey.shade200,
                spreadRadius: 6)
          ]),
      child: ListTile(
        title: Text(
          provider.name,
          style: TextStyle(
              color: kBlue, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(provider.address),
        trailing: Text(provider.activeStatus),
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  FilterBloc filterBloc = FilterBloc();

  @override
  void initState() {
    filterBloc.fetchFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              'Filter',
              style: heading,
            ),
          ),
          Text('Filter by Provider Type'),
          StreamBuilder(
              stream: filterBloc.types,
              builder: (context, snap) {
                return snap.hasData
                    ? Wrap(
                        children: snap.data
                            .map<Widget>(
                              (ProviderType x) => FilterItem(),
                            )
                            .toList(),
                      )
                    : Container();
              }),
          Text('Filter by Onboarding Status')
        ],
      ),
    );
  }
}

class FilterItem extends StatefulWidget {
  final ProviderType type;
  const FilterItem({Key key, this.type}) : super(key: key);

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.type.name),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          isSelected = selected;
        });
      },
    );
  }
}
