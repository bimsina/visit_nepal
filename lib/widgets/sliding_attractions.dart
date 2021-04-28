import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:visit_nepal/modals/attractiondata.dart';
import 'package:visit_nepal/modals/graphQlConstant.dart';
import 'package:visit_nepal/screens/all_attractions.dart';
import 'package:visit_nepal/screens/place_detail.dart';
import 'package:visit_nepal/utils/widgets.dart';
import 'dart:math' as math;

import 'package:visit_nepal/widgets/retry_widget.dart';

class SlidingPlacesView extends StatefulWidget {
  final ThemeData themeData;

  SlidingPlacesView({this.themeData});

  @override
  _SlidingPlacesViewState createState() => _SlidingPlacesViewState();
}

class _SlidingPlacesViewState extends State<SlidingPlacesView> {
  PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Query(
        options: QueryOptions(
            document: gql(attractionsList), variables: <String, dynamic>{}),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      widget.themeData.accentColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Loading Attractions.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            );
          } else if (result.data == null) {
            return RetryWidget(
              themeData: widget.themeData,
              onRetried: () {
                refetch();
              },
            );
          } else {
            List<Attraction> attractions =
                AttractionData.fromJson(result.data).attractionList;
            return Column(
              children: <Widget>[
                ShowMore(
                  text: 'Attractions',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllAttractions(
                                  themeData: widget.themeData,
                                  attractions: attractions,
                                )));
                  },
                ),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: attractions.length >= 5 ? 5 : attractions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceDetail(
                                        place: Attraction.fromJson(result
                                            ?.data['attractionList'][index]),
                                        heroId: attractions[index].name,
                                        themeData: widget.themeData,
                                      )));
                        },
                        child: SlidingCard(
                          name: result.data['attractionList'][index]['name'],
                          imageUrl: result.data['attractionList'][index]
                              ['image'],
                          location: result.data['attractionList'][index]
                              ['district'],
                          offset: pageOffset - index,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name, imageUrl, location;
  final double offset;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.imageUrl,
    @required this.location,
    @required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Stack(
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(left: 8, right: 8, bottom: 30),
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Hero(
                tag: name,
                child: FadeInImage(
                  image: NetworkImage(imageUrl),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment(-offset.abs(), 0),
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/images/loading.gif'),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 8,
            child: Card(
              color: Theme.of(context).primaryColorDark,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(name,
                        style: Theme.of(context).textTheme.bodyText2,
                        overflow: TextOverflow.ellipsis),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).accentColor,
                          size: 20,
                        ),
                        Text(location,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
