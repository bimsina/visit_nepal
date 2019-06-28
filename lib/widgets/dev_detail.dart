import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevDetail extends StatelessWidget {
  final ThemeData themeData;
  final String name, mail, url, job;

  const DevDetail(
      {Key key, this.themeData, this.name, this.mail, this.url, this.job})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: themeData.primaryColorDark,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ClipOval(
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: FadeInImage(
                    image: NetworkImage(url),
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/images/loading.gif'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: themeData.textTheme.body1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        job,
                        style: themeData.textTheme.body2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.mail_outline,
                  color: themeData.accentColor,
                ),
                onPressed: () async {
                  String url =
                      "mailto:$mail?subject=About%20the%20app&body=I%20would";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print('cannot launch');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
