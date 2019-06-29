import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:visit_nepal/modals/graphQlConstant.dart';
import 'package:visit_nepal/modals/hoteldata.dart';
import 'package:visit_nepal/screens/all_hotels.dart';
import 'package:visit_nepal/screens/hotel_detail.dart';
import 'package:visit_nepal/utils/widgets.dart';
import 'dart:math' as math;

import 'package:visit_nepal/widgets/retry_widget.dart';

class SlidingHotelsView extends StatefulWidget {
  final ThemeData themeData;

  SlidingHotelsView({this.themeData});

  @override
  _SlidingHotelsViewState createState() => _SlidingHotelsViewState();
}

class _SlidingHotelsViewState extends State<SlidingHotelsView> {
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
        options:
            QueryOptions(document: hotelList, variables: <String, dynamic>{}),
        builder: (
          QueryResult result, {
          VoidCallback refetch,
        }) {
          if (result.loading) {
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
                    'Loading hotels.',
                    style: Theme.of(context).textTheme.body2,
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
            List<Hotel> hotels = HotelListData.fromJson(result.data).hotelList;
            return Column(
              children: <Widget>[
                ShowMore(
                  text: 'Hotels',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllHotels(
                                  themeData: widget.themeData,
                                  hotels: hotels,
                                )));
                  },
                ),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: hotels.length >= 5 ? 5 : hotels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HotelDetail(
                                hotel: hotels[index],
                                heroId: hotels[index].name,
                                themeData: widget.themeData,
                              )));
                        },
                        child: SlidingCard(
                          name: hotels[index].name,
                          imageUrl: hotels[index].img[0],
                          location: hotels[index].district,
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
                        style: Theme.of(context).textTheme.body1,
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
                            style: Theme.of(context).textTheme.body2,
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
