import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    Color statusColor;
    switch (_provider.activeStatus) {
      case "Pending":
        statusColor = accentOrange;
        break;
      case "Active":
        statusColor = Colors.green;
        break;

      default:
        statusColor = Colors.red;
    }
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
                color: kBlue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${_provider.description}",
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _provider.activeStatus,
                style: TextStyle(color: statusColor),
              ),
              RatingBar.builder(
                initialRating: _provider.rating.toDouble(),
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                ignoreGestures: true,
                updateOnDrag: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: 12,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
