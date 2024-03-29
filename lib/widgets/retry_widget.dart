import 'package:flutter/material.dart';

class RetryWidget extends StatefulWidget {
  final ThemeData? themeData;
  final VoidCallback? onRetried;

  const RetryWidget({Key? key, this.themeData, this.onRetried})
      : super(key: key);

  @override
  _RetryWidgetState createState() => _RetryWidgetState();
}

class _RetryWidgetState extends State<RetryWidget> {
  bool isRetried = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: isRetried
          ? <Widget>[
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(widget.themeData!.accentColor),
              )
            ]
          : <Widget>[
              Text("Oops! Something went wrong !",
                  style: Theme.of(context).textTheme.bodyText1),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        widget.themeData!.accentColor)),
                child: Text("Retry",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: widget.themeData!.primaryColor)),
                onPressed: () {
                  setState(() {
                    isRetried = true;
                  });
                  widget.onRetried!();
                },
              )
            ],
    );
  }
}
