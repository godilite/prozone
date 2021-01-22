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
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ProZone'.toUpperCase(),
                    style: TextStyle(
                      color: kBlue,
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    child: Text('Manage Providers With Ease',
                        style: TextStyle(
                          color: kText,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage('assets/spalshpage.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
