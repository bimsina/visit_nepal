import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:visit_nepal/modals/hoteldata.dart';
import '../modals/openweather.dart';
import '../widgets/custom_carousel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HotelDetail extends StatefulWidget {
  final String heroId;
  final Hotel hotel;
  final ThemeData themeData;

  HotelDetail(
      {@required this.heroId, @required this.hotel, @required this.themeData});
  @override
  _HotelDetailState createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  OpenWeatherMap weatherData;

  void initState() {
    super.initState();
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    try {
      var res = await http.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=${widget.hotel.latitude}&lon=${widget.hotel.longitude}&appid=f1141e173a1ba2b8f2d7cbfa740d13bd");
      var decodeRes = jsonDecode(res.body);
      weatherData = OpenWeatherMap.fromJson(decodeRes);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: _height / 3,
              floating: true,
              title: Text(
                widget.hotel.name,
                style: widget.themeData.textTheme.headline,
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: widget.themeData.accentColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: widget.themeData.primaryColor,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.heroId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    child: FadeInImage(
                      image: NetworkImage(widget.hotel.img[0]),
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/loading.gif'),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
            color: widget.themeData.primaryColor, child: generalTab()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String url =
              "google.navigation:q=${widget.hotel.latitude},${widget.hotel.longitude}";
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            print('cannot launch');
          }
        },
        backgroundColor: widget.themeData.accentColor,
        tooltip: 'Navigate',
        child: Transform.rotate(
            angle: math.pi / 4.0,
            child:
                Icon(Icons.navigation, color: widget.themeData.primaryColor)),
      ),
    );
  }

  Widget weatherWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: widget.themeData.primaryColorDark,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                      weatherData == null
                          ? 'assets/images/weather.gif'
                          : 'assets/images/weather/${weatherData.weather[0].icon}.png',
                      fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          weatherData == null
                              ? 'Fetching...'
                              : '${(weatherData.main.temp - 273.15).toStringAsFixed(2)} °C',
                          overflow: TextOverflow.ellipsis,
                          style: widget.themeData.textTheme.body1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                          weatherData == null
                              ? 'Fetching...'
                              : '${weatherData.weather[0].description}',
                          overflow: TextOverflow.ellipsis,
                          style: widget.themeData.textTheme.body2),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        weatherData == null
                            ? '...'
                            : '${(weatherData.main.tempMin - 273.15).toStringAsFixed(2)} / ${(weatherData.main.tempMax - 273.15).toStringAsFixed(2)} °C',
                        overflow: TextOverflow.ellipsis,
                        style: widget.themeData.textTheme.caption),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                        weatherData == null
                            ? '...'
                            : 'Humidity : ${weatherData.main.humidity} %',
                        overflow: TextOverflow.ellipsis,
                        style: widget.themeData.textTheme.body2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget generalTab() {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(0),
      children: <Widget>[
        weatherWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Cost : ${widget.hotel.cost}',
                  style: widget.themeData.textTheme.body1),
            ),
            // RaisedButton(
            //     color: widget.themeData.accentColor,
            //     onPressed: () {},
            //     child: Text(
            //       'Book Now!',
            //       style: widget.themeData.textTheme.body2
            //           .copyWith(color: widget.themeData.primaryColor),
            //     ))
          ],
        ),
        widget.hotel.img.length == 0 ? Container() : _imageWidget(),
        ExpansionTile(
          title: Text(
            'Amneties',
            style: widget.themeData.textTheme.body1,
          ),
          initiallyExpanded: true,
          children: <Widget>[
            ListView.builder(
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: widget.hotel.amenities.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius: 12,
                          backgroundColor: widget.themeData.accentColor,
                          child: Icon(
                            Icons.done,
                            size: 12,
                            color: widget.themeData.primaryColor,
                          )),
                    ),
                    Expanded(
                      child: Text(
                        widget.hotel.amenities[index],
                        style: widget.themeData.textTheme.body2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        ExpansionTile(
          title: Text(
            'Description',
            style: widget.themeData.textTheme.body1,
          ),
          initiallyExpanded: true,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.hotel.description,
                  style: widget.themeData.textTheme.body2,
                )),
          ],
        )
      ],
    );
  }

  Widget _imageWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Photos',
                style: widget.themeData.textTheme.body1,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: CustomCarousel(
              imageUrls: widget.hotel.img, themeData: widget.themeData),
        ),
      ],
    );
  }
}
