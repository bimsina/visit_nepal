import 'package:provider/provider.dart';
import 'package:visit_nepal/theme/theme_state.dart';
import 'package:visit_nepal/widgets/sliding_festivals.dart';
import 'package:visit_nepal/widgets/sliding_hotels.dart';

import '../screens/settings.dart';
import '../widgets/sliding_attractions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return Theme(
      data: state.themeData,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            elevation: 5,
            title: Text(
              'Visit Nepal',
              style: state.themeData.textTheme.headline5,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: state.themeData.accentColor,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            backgroundColor: state.themeData.primaryColor),
        drawer: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 50, 25),
          child: SettingsPage(),
        ),
        body: Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SlidingPlacesView(themeData: state.themeData),
                SlidingHotelsView(themeData: state.themeData),
                SlidingFestivalsView(themeData: state.themeData),
              ],
            ),
            color: state.themeData.primaryColor),
      ),
    );
  }
}
