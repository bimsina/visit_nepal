import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final ThemeData themeData;
  final String title;
  final VoidCallback onTap;
  final IconData iconData;

  const MainButton(
      {Key key, this.themeData, this.title, this.onTap, this.iconData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 2, color: themeData.accentColor)),
        child: FlatButton(
          onPressed: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData, size: 30, color: themeData.accentColor),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: themeData.textTheme.body2)),
            ],
          ),
        ),
      ),
    );
  }
}
