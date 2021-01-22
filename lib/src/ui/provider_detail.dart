import 'dart:io';
import 'dart:ui';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/image_bloc.dart';
import 'package:prozone/src/blocs/provider_state_bloc.dart';
import 'package:prozone/src/blocs/provider_type_bloc.dart';
import 'package:prozone/src/blocs/update_provider_bloc.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state_model.dart';
import 'package:prozone/src/ui/shared/routes.dart';
import 'package:prozone/src/ui/shared/style.dart';

import 'widgets/drop_down_input.dart';
import 'widgets/provider_detail_item_widget.dart';

class ProviderDetail extends StatefulWidget {
  @override
  _ProviderDetailState createState() => _ProviderDetailState();
}

class _ProviderDetailState extends State<ProviderDetail> {
  TextEditingController _nameCntrl = TextEditingController();
  TextEditingController _descriptionCntrl = TextEditingController();
  TextEditingController _ratingCntrl = TextEditingController();
  TextEditingController _addressCntrl = TextEditingController();
  TextEditingController _activeStatusCntrl = TextEditingController();
  TextEditingController _providerTypeCntrl = TextEditingController();
  TextEditingController _providerStateCntrl = TextEditingController();
  int id;
  ImageBloc _imageBloc = ImageBloc();
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> data = ModalRoute.of(context).settings.arguments;
    ProviderModel provider = data['provider'];
    _nameCntrl.text = provider.name;
    _addressCntrl.text = provider.address;
    _descriptionCntrl.text = provider.description;
    _providerStateCntrl.text = provider.state.name;
    _providerTypeCntrl.text = provider.providerType.name;
    _activeStatusCntrl.text = provider.activeStatus;
    _ratingCntrl.text = provider.rating.toString();
    id = provider.id;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: kBlue,
          ),
        ),
        title: Text(
          '${provider.name}',
          style: TextStyle(color: kText),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: kBlue,
                textColor: Colors.white,
                onPressed: () => _imageBloc.selectFiles(id),
                icon: Icon(Icons.add_a_photo),
                label: Text(
                  'Add Images',
                  style: TextStyle(fontSize: 12),
                )),
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: provider.images.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.images.length,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 4),
                              child: Image(
                                image: NetworkImage(provider.images[index].url),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: kGrey,
                        width: constraints.maxWidth,
                        child: Center(
                          child: Text(
                            'No Image(s)',
                            style: subHeading,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 500,
                child: ListView(
                  children: [
                    providerName(provider),
                    providerActiveStatus(),
                    providerAddress(provider),
                    providerDescription(provider),
                    providerRating(provider),
                    providerState(),
                    providerType(),
                    SizedBox(
                      height: 30,
                    ),
                    submitButton(id),
                    SizedBox(
                      height: 10,
                    ),
                    loadingIndicator(),
                    SizedBox(
                      height: constraints.maxHeight * 0.10,
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      }),
    );
  }

  Widget loadingIndicator() => StreamBuilder<bool>(
        stream: updateProviderBloc.loading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? Center(child: CircularProgressIndicator())
                : null,
          );
        },
      );

  Widget submitButton(id) => Container(
        height: 45,
        child: SizedBox.expand(
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => updateProviderBloc.submit(id),
            child: Text(
              'Update Provider Details',
              style: TextStyle(color: Colors.white),
            ),
            color: kBlue,
          ),
        ),
      );

  Widget providerName(
    ProviderModel provider,
  ) =>
      StreamBuilder<String>(
          stream: updateProviderBloc.name,
          builder: (context, snap) {
            return ProviderDetailItem(
              title: 'Provider Name',
              cntrl: _nameCntrl,
              onChange: updateProviderBloc.changeName,
            );
          });

  Widget providerAddress(
    ProviderModel provider,
  ) =>
      StreamBuilder<String>(
          stream: updateProviderBloc.address,
          builder: (context, snap) {
            return ProviderDetailItem(
              title: "Provider Address",
              cntrl: _addressCntrl,
              onChange: updateProviderBloc.changeAddress,
            );
          });

  Widget providerRating(
    ProviderModel provider,
  ) =>
      StreamBuilder<String>(
          stream: updateProviderBloc.rating,
          builder: (context, snap) {
            return DropDownInput(
              title: 'Provider Rating',
              dropdownSearch: DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItem: true,
                maxHeight: 150,
                dropDownButton: Icon(Icons.arrow_drop_down, color: kBlue),
                dropdownSearchDecoration: InputDecoration(
                  hintText: _ratingCntrl.text,
                  enabledBorder: border,
                  disabledBorder: border,
                  focusedBorder: border,
                  border: border,
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.only(left: 8),
                ),
                items: ["1", "2", "3", "4", "5"],
                onChanged: updateProviderBloc.changeRating,
                selectedItem: snap.data,
              ),
            );
          });

  Widget providerDescription(
    ProviderModel provider,
  ) =>
      StreamBuilder<String>(
          stream: updateProviderBloc.description,
          builder: (context, snap) {
            return ProviderDetailItem(
              title: 'Provider Description',
              cntrl: _descriptionCntrl,
              onChange: updateProviderBloc.changeDescription,
            );
          });

  Widget providerActiveStatus() => StreamBuilder<String>(
      stream: updateProviderBloc.activeStatus,
      builder: (context, snap) {
        return DropDownInput(
          title: 'Activation Status',
          dropdownSearch: DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItem: true,
            maxHeight: 150,
            dropDownButton: Icon(Icons.arrow_drop_down, color: kBlue),
            dropdownSearchDecoration: InputDecoration(
              hintText: _activeStatusCntrl.text,
              enabledBorder: border,
              disabledBorder: border,
              focusedBorder: border,
              border: border,
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.only(left: 8),
            ),
            items: ["Active", "Pending", "Deleted"],
            onChanged: updateProviderBloc.changeActiveStatus,
            selectedItem: snap.data,
          ),
        );
      });

  Widget providerState() => StreamBuilder<StateModel>(
      stream: updateProviderBloc.state,
      builder: (context, snap) {
        return DropDownInput(
          title: 'Provider State',
          dropdownSearch: StreamBuilder<List<StateModel>>(
              stream: providerStateBloc.providerState,
              builder: (context, stateSnapshot) {
                return DropdownSearch<StateModel>(
                  mode: Mode.MENU,
                  maxHeight: 120,
                  dropDownButton: Icon(Icons.arrow_drop_down, color: kBlue),
                  dropdownSearchDecoration: InputDecoration(
                    hintText: _providerStateCntrl.text,
                    enabledBorder: border,
                    disabledBorder: border,
                    focusedBorder: border,
                    border: border,
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 8),
                  ),
                  items: stateSnapshot.hasData
                      ? stateSnapshot.data.map((e) => e).toList()
                      : [],
                  onChanged: updateProviderBloc.changeState,
                  itemAsString: (StateModel data) => data.stateAsString(),
                  selectedItem: snap.data,
                );
              }),
        );
      });

  Widget providerType() => StreamBuilder<ProviderType>(
      stream: updateProviderBloc.type,
      builder: (context, snap) {
        return DropDownInput(
          title: 'Provider Type',
          dropdownSearch: StreamBuilder<List<ProviderType>>(
              stream: providerTypeBloc.providerType,
              builder: (context, typeSnapshot) {
                return DropdownSearch<ProviderType>(
                  mode: Mode.MENU,
                  maxHeight: 120,
                  dropDownButton: Icon(Icons.arrow_drop_down, color: kBlue),
                  dropdownSearchDecoration: InputDecoration(
                    hintText: _providerTypeCntrl.text,
                    enabledBorder: border,
                    disabledBorder: border,
                    focusedBorder: border,
                    border: border,
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 8),
                  ),
                  items: typeSnapshot.hasData
                      ? typeSnapshot.data.map((e) => e).toList()
                      : [],
                  onChanged: updateProviderBloc.changeType,
                  itemAsString: (ProviderType data) => data.typeAsString(),
                  selectedItem: snap.data,
                );
              }),
        );
      });
}
