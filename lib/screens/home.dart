import 'package:visit_nepal/widgets/main_button.dart';
import 'package:visit_nepal/widgets/sliding_festivals.dart';

import '../screens/settings.dart';
import '../widgets/sliding_attractions.dart';
import '../bloc/change_theme_bloc.dart';
import '../bloc/change_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_hotels.dart';
import 'all_restaurants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: changeThemeBloc,
      builder: (BuildContext context, ChangeThemeState state) {
        return Theme(
          data: state.themeData,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                centerTitle: true,
                elevation: 5,
                title: Text(
                  'Visit Nepal',
                  style: state.themeData.textTheme.headline,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Essentials',
                        style: state.themeData.textTheme.body1,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: MainButton(
                          themeData: state.themeData,
                          title: 'Restaurants',
                          iconData: Icons.restaurant,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllRestaurants(
                                          themeData: state.themeData,
                                          isWhat: 0,
                                        )));
                          },
                        )),
                        Expanded(
                            child: MainButton(
                          themeData: state.themeData,
                          title: 'Pubs',
                          iconData: Icons.local_bar,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllRestaurants(
                                          themeData: state.themeData,
                                          isWhat: 2,
                                        )));
                          },
                        )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: MainButton(
                          themeData: state.themeData,
                          title: 'Cafes',
                          iconData: Icons.local_cafe,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllRestaurants(
                                          themeData: state.themeData,
                                          isWhat: 1,
                                        )));
                          },
                        )),
                        Expanded(
                            child: MainButton(
                          themeData: state.themeData,
                          title: 'Hotels',
                          iconData: Icons.local_hotel,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllHotels(
                                          themeData: state.themeData,
                                        )));
                          },
                        )),
                      ],
                    ),
                    SlidingPlacesView(themeData: state.themeData),
                    SlidingFestivalsView(themeData: state.themeData),
                  ],
                ),
                color: state.themeData.primaryColor),
          ),
        );
      },
    );
  }
}
