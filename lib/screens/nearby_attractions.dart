import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:visit_nepal/modals/attractiondata.dart';
import 'package:visit_nepal/modals/graphQlConstant.dart';
import 'package:visit_nepal/widgets/grid_attractions.dart';

class NearbyAttractions extends StatefulWidget {
  final ThemeData themeData;
  final int provinceId;
  NearbyAttractions({this.themeData, this.provinceId});
  @override
  _NearbyAttractionsState createState() => _NearbyAttractionsState();
}

class _NearbyAttractionsState extends State<NearbyAttractions> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: nearbyAttractionsList,
          variables: <String, dynamic>{"id": widget.provinceId}),
      builder: (
        QueryResult result, {
        VoidCallback refetch,
      }) {
        if (result.loading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(widget.themeData.accentColor),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Loading Attractions.',
                  style: widget.themeData.textTheme.body2,
                ),
              )
            ],
          );
        } else if (result.data == null) {
          return Center(child: Text("No Data Found !"));
        } else {
          List<Attraction> attractions =
              NearbyData.fromJson(result.data).attractionList;

          return GridAttractions(
              themeData: widget.themeData, attractions: attractions);
        }
      },
    );
  }
}
