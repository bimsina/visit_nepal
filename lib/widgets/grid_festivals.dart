import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:visit_nepal/modals/festivaldata.dart';
import 'package:visit_nepal/screens/festival_detail.dart';

class GridFestivals extends StatelessWidget {
  final List<Festival> festivals;
  final ThemeData themeData;
  GridFestivals({this.festivals, this.themeData});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeData.primaryColor,
      padding: EdgeInsets.only(top: 8),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: festivals.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FestivalDetail(
                            festival: festivals[index],
                            heroId: festivals[index].name,
                            themeData: themeData,
                          )));
            },
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
                      tag: festivals[index].name,
                      child: FadeInImage(
                        image: NetworkImage(festivals[index].image),
                        width: double.infinity,
                        height: double.infinity,
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
                    color: themeData.primaryColorDark,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(festivals[index].name,
                            style: themeData.textTheme.body2,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
