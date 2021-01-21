import 'package:flutter/material.dart';
import 'package:prozone/src/models/provider_model.dart';
import 'package:prozone/src/ui/shared/routes.dart';
import 'package:prozone/src/ui/shared/style.dart';

class ProviderListItem extends StatelessWidget {
  ProviderListItem({
    Key key,
    @required ProviderModel provider,
  })  : _provider = provider,
        super(key: key);

  final ProviderModel _provider;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.ProviderDetails,
          arguments: {'provider': _provider}),
      child: Container(
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
            _provider.name,
            style: TextStyle(
                color: kBlue, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(_provider.address),
          trailing: Text(_provider.activeStatus),
        ),
      ),
    );
  }
}
