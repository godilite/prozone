import 'package:flutter/material.dart';
import 'package:prozone/src/blocs/filter_bloc.dart';
import 'package:prozone/src/blocs/provider_bloc.dart';
import 'package:prozone/src/ui/provider_list.dart';
import 'package:prozone/src/app.dart';

import 'shared/style.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double screenWidth = 0.0;
  double screenheight = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    filterBloc.fetchProviderTypes();
    filterBloc.fetchStatus();
    Future.delayed(Duration(seconds: 2), () {
      return navigatorKey.currentState.pushReplacement(
          MaterialPageRoute(builder: (context) => ProviderList()));
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ProZone'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kBlue,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
            Container(
              child: Text('Manage Providers With Ease',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kText,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
