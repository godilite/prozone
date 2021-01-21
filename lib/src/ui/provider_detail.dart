import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/image_bloc.dart';
import 'package:prozone/src/blocs/update_provider_bloc.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/ui/shared/routes.dart';
import 'package:prozone/src/ui/shared/style.dart';

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
  UpdateProviderBloc _updateProviderBloc = UpdateProviderBloc();
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: kBlue,
                textColor: Colors.white,
                onPressed: () async {
                  List<File> files = await _imageBloc.selectFiles();
                  Navigator.pushNamed(context, Routes.PreviewImage,
                      arguments: {'files': files, 'id': id});
                },
                icon: Icon(Icons.image),
                label: Text('Add Images')),
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.images.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 7,
                            color: Colors.grey.shade200,
                            spreadRadius: 8)
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4),
                        child: Image(
                          image: NetworkImage(provider.images[index].url),
                        ),
                      ),
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
                    providerName(provider, _updateProviderBloc),
                    providerActiveStatus(provider, _updateProviderBloc),
                    providerAddress(provider, _updateProviderBloc),
                    providerDescription(provider, _updateProviderBloc),
                    providerRating(provider, _updateProviderBloc),
                    providerName(provider, _updateProviderBloc),
                    SizedBox(
                      height: 30,
                    ),
                    submitButton(_updateProviderBloc, id),
                    SizedBox(
                      height: 10,
                    ),
                    loadingIndicator(_updateProviderBloc),
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

  Widget loadingIndicator(UpdateProviderBloc updateProviderBloc) =>
      StreamBuilder<bool>(
        stream: updateProviderBloc.loading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? Center(child: CircularProgressIndicator())
                : null,
          );
        },
      );

  Widget submitButton(UpdateProviderBloc updateProviderBloc, id) => Container(
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
          ProviderModel provider, UpdateProviderBloc updateProviderBloc) =>
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
          ProviderModel provider, UpdateProviderBloc updateProviderBloc) =>
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
          ProviderModel provider, UpdateProviderBloc updateProviderBloc) =>
      StreamBuilder<String>(
          stream: updateProviderBloc.rating,
          builder: (context, snap) {
            return ProviderDetailItem(
              title: "Provider Rating",
              cntrl: _ratingCntrl,
              onChange: updateProviderBloc.changeRating,
            );
          });

  Widget providerDescription(
          ProviderModel provider, UpdateProviderBloc updateProviderBloc) =>
      StreamBuilder<String>(
          stream: updateProviderBloc.description,
          builder: (context, snap) {
            return ProviderDetailItem(
              title: 'Provider Description',
              cntrl: _descriptionCntrl,
              onChange: updateProviderBloc.changeDescription,
            );
          });

  Widget providerActiveStatus(
          ProviderModel provider, UpdateProviderBloc updateProviderBloc) =>
      StreamBuilder<String>(
          stream: updateProviderBloc.activeStatus,
          builder: (context, snap) {
            return ProviderDetailItem(
              title: 'Provider Activation Status',
              cntrl: _activeStatusCntrl,
              onChange: updateProviderBloc.changeActiveStatus,
            );
          });
}
