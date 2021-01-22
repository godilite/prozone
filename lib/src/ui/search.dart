import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/search_bloc.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/ui/widgets/provider_list_item.dart';

import 'shared/style.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchBloc _searchBloc = SearchBloc();

  @override
  void initState() {
    _searchBloc.searchProviders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: kBlue,
          ),
        ),
        title: searchInputField(),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              height: constraints.maxHeight * 0.9,
              child: StreamBuilder<List<ProviderModel>>(
                  stream: _searchBloc.results,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active &&
                        snapshot.hasData) {
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
                                style: subtrail,
                              ),
                            );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container();
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

  Widget searchInputField() => StreamBuilder<String>(
      stream: _searchBloc.searchKeyword,
      builder: (context, snapshot) {
        return Container(
          height: 50,
          child: TextField(
            onChanged: _searchBloc.addKeyword,
            textInputAction: TextInputAction.search,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              _searchBloc.searchProviders();
            },
            decoration: InputDecoration(
                fillColor: kGrey,
                filled: true,
                hintText: 'Search Providers eg: Selma Pharmacy',
                disabledBorder: searchBorder,
                border: searchBorder,
                enabledBorder: searchBorder,
                prefixIcon: Icon(Icons.search_outlined)),
          ),
        );
      });
}
