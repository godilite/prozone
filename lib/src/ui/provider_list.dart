import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/models/provider_model.dart';
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
        actions: [IconButton(icon: Icon(Icons.sort_outlined), onPressed: null)],
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
        title: Text(provider.name),
        subtitle: Text(provider.address),
        trailing: Text(provider.activeStatus),
      ),
    );
  }
}
