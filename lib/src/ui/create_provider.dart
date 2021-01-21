import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/create_provider_bloc.dart';
import 'package:prozone/src/blocs/provider_state_bloc.dart';
import 'package:prozone/src/blocs/provider_type_bloc.dart';
import 'package:prozone/src/models/provider_type.dart';
import 'package:prozone/src/models/state_model.dart';
import 'package:prozone/src/ui/shared/style.dart';
import 'package:prozone/src/ui/widgets/drop_down_input.dart';

import 'widgets/provider_input_field.dart';

class CreateProvider extends StatefulWidget {
  @override
  _CreateProviderState createState() => _CreateProviderState();
}

class _CreateProviderState extends State<CreateProvider> {
  @override
  void initState() {
    providerTypeBloc.fetchProviderType();
    providerStateBloc.fetchProviderStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: kBlue,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              providerName(),
              providerActiveStatus(),
              providerAddress(),
              providerDescription(),
              providerRating(),
              providerState(),
              providerType(),
              SizedBox(
                height: 30,
              ),
              submitButton(),
              SizedBox(
                height: 10,
              ),
              loadingIndicator(),
              SizedBox(
                height: constraints.maxHeight * 0.10,
              )
            ]),
          ),
        );
      }),
    );
  }

  Widget loadingIndicator() => StreamBuilder<bool>(
        stream: createProviderBloc.loading,
        builder: (context, snap) {
          return Container(
            child: (snap.hasData && snap.data)
                ? Center(child: CircularProgressIndicator())
                : null,
          );
        },
      );

  Widget submitButton() => StreamBuilder<bool>(
      stream: createProviderBloc.submitValid,
      builder: (context, snap) {
        return Container(
          height: 45,
          child: SizedBox.expand(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: (!snap.hasData) ? null : createProviderBloc.submit,
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              color: kBlue,
            ),
          ),
        );
      });

  Widget providerName() => StreamBuilder<String>(
      stream: createProviderBloc.name,
      builder: (context, snap) {
        return ProviderInputField(
          title: 'Provider Name',
          onChange: createProviderBloc.changeName,
        );
      });

  Widget providerAddress() => StreamBuilder<String>(
      stream: createProviderBloc.address,
      builder: (context, snap) {
        return ProviderInputField(
          title: "Provider Address",
          onChange: createProviderBloc.changeAddress,
        );
      });

  Widget providerRating() => StreamBuilder<String>(
      stream: createProviderBloc.rating,
      builder: (context, snap) {
        return DropDownInput(
          title: 'Provider Rating',
          dropdownSearch: DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItem: true,
            maxHeight: 150,
            dropDownButton: Icon(Icons.arrow_drop_down, color: kBlue),
            dropdownSearchDecoration: InputDecoration(
              hintText: 'Select Rating',
              enabledBorder: border,
              disabledBorder: border,
              focusedBorder: border,
              border: border,
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.only(left: 8),
            ),
            items: ["1", "2", "3", "4", "5"],
            onChanged: createProviderBloc.changeRating,
            selectedItem: snap.data,
          ),
        );
      });

  Widget providerDescription() => StreamBuilder<String>(
      stream: createProviderBloc.description,
      builder: (context, snap) {
        return ProviderInputField(
          title: 'Provider Description',
          onChange: createProviderBloc.changeDescription,
        );
      });

  Widget providerActiveStatus() => StreamBuilder<String>(
        stream: createProviderBloc.activeStatus,
        builder: (context, snap) => DropDownInput(
          title: 'Provider Activation Status',
          dropdownSearch: DropdownSearch<String>(
            mode: Mode.MENU,
            showSelectedItem: true,
            maxHeight: 120,
            dropDownButton: Icon(Icons.arrow_drop_down, color: kBlue),
            dropdownSearchDecoration: InputDecoration(
              hintText: 'Select Activation Status',
              enabledBorder: border,
              disabledBorder: border,
              focusedBorder: border,
              border: border,
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.only(left: 8),
            ),
            items: ["Pending", "Active", "Deleted"],
            onChanged: createProviderBloc.changeActiveStatus,
            selectedItem: snap.data,
          ),
        ),
      );

  Widget providerState() => StreamBuilder<StateModel>(
      stream: createProviderBloc.state,
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
                    hintText: 'Select State',
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
                  onChanged: createProviderBloc.changeState,
                  itemAsString: (StateModel data) => data.stateAsString(),
                  selectedItem: snap.data,
                );
              }),
        );
      });

  Widget providerType() => StreamBuilder<ProviderType>(
      stream: createProviderBloc.type,
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
                    hintText: 'Select Provider Type',
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
                  onChanged: createProviderBloc.changeType,
                  itemAsString: (ProviderType data) => data.typeAsString(),
                  selectedItem: snap.data,
                );
              }),
        );
      });
}
