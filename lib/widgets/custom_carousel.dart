import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final ThemeData themeData;
  CustomCarousel({this.imageUrls, this.themeData});
  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.themeData.primaryColor,
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            height: double.infinity,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            items: widget.imageUrls.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    child: FadeInImage(
                      image: NetworkImage(i),
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/loading.gif'),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              height: 12,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.imageUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 5,
                      width: index == pageIndex ? 30 : 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: widget.themeData.accentColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
