import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/ui/shared/routes.dart';
import 'package:prozone/src/ui/widgets/provider_list_item.dart';

import 'shared/style.dart';
import 'filter_drawer.dart';

class ProviderList extends StatefulWidget {
  @override
  _ProviderListState createState() => _ProviderListState();
}

class _ProviderListState extends State<ProviderList> {
  @override
  void didChangeDependencies() {
    providerBloc.fetchAllProviders();
    super.didChangeDependencies();
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
                size: 30,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        centerTitle: true,
        title: Container(
          height: 50,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.SearchRoute),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                  fillColor: kGrey,
                  filled: true,
                  hintText: 'Search Providers eg: Selma Pharmacy',
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
              padding: EdgeInsets.all(10),
              child: StreamBuilder<List<ProviderModel>>(
                  stream: providerBloc.providers,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.length > 0
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return ProviderListItem(
                                    provider: snapshot.data[index]);
                              })
                          : Center(
                              child: Text(
                                'No Providers found',
                                style: subHeading,
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
      floatingActionButton: _offsetPopup(),
    );
  }

  Widget _offsetPopup() => CircleAvatar(
        backgroundColor: kBlue,
        radius: 25,
        child: PopupMenuButton<String>(
          elevation: 6,
          itemBuilder: (context) => [
            PopupMenuItem(
              height: 10,
              value: Routes.CreateProviderRoute,
              child: Text(
                "Add New Provider",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          color: kBlue,
          onSelected: (value) => Navigator.pushNamed(context, value),
          icon: CircleAvatar(
            backgroundColor: kBlue,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          offset: Offset(-10, -90),
        ),
      );
}
