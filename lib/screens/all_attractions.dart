import 'package:flutter/material.dart';
import 'package:visit_nepal/widgets/grid_attractions.dart';
import '../modals/attractiondata.dart';

class AllAttractions extends StatefulWidget {
  final List<Attraction> attractions;
  final ThemeData themeData;
  AllAttractions({this.attractions, this.themeData});
  @override
  _AllAttractionsState createState() => _AllAttractionsState();
}

class _AllAttractionsState extends State<AllAttractions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All Attractions',
          style: widget.themeData.textTheme.headline,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: widget.themeData.accentColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: widget.themeData.primaryColor,
      ),
      body: GridAttractions(
        themeData: widget.themeData,
        attractions: widget.attractions
      ),
    );
  }
}
