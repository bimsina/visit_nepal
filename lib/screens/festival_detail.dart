import 'package:flutter/material.dart';
import 'package:visit_nepal/modals/festivaldata.dart';
import 'package:visit_nepal/utils/custom_image.dart';
import '../widgets/custom_carousel.dart';

class FestivalDetail extends StatefulWidget {
  final String heroId;
  final Festival festival;
  final ThemeData themeData;

  FestivalDetail(
      {@required this.heroId,
      @required this.festival,
      @required this.themeData});
  @override
  _FestivalDetailState createState() => _FestivalDetailState();
}

class _FestivalDetailState extends State<FestivalDetail> {
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
                widget.festival.name,
                style: widget.themeData.textTheme.headline5,
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
                      image: customImage(widget.festival.image),
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
    );
  }

  Widget generalTab() {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(0),
      children: <Widget>[
        widget.festival.img.length == 0
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Photos',
                          style: widget.themeData.textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CustomCarousel(
                        imageUrls: widget.festival.img,
                        themeData: widget.themeData),
                  ),
                ],
              ),
        ExpansionTile(
          title: Text(
            'Description',
            style: widget.themeData.textTheme.bodyText2,
          ),
          initiallyExpanded: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.festival.description.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    widget.festival.description[index],
                    style: widget.themeData.textTheme.bodyText1,
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
