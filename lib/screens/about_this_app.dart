import 'package:flutter/material.dart';
import 'package:visit_nepal/widgets/dev_detail.dart';

class AboutScreen extends StatelessWidget {
  final ThemeData themeData;
  AboutScreen({this.themeData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'About this app',
            style: themeData.textTheme.headline,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: themeData.accentColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: themeData.primaryColor,
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 8.0),
          color: themeData.primaryColor,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'This is an app developed with the intention of providing useful information about our country Nepal. And to further flourish the Tourism Industry of Nepal.',
                  style: themeData.textTheme.body2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: themeData.accentColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Developers',
                    style: themeData.textTheme.body1,
                  ),
                ],
              ),
              DevDetail(
                themeData: themeData,
                name: 'Bibek Timsina',
                job: 'Mobile Application Developer.',
                mail: 'timsinabibek960@gmail.com',
                url:
                    'https://avatars1.githubusercontent.com/u/29589003?s=460&v=4',
              ),
              DevDetail(
                themeData: themeData,
                name: 'Animesh Timsina',
                job: 'Backend Developer.',
                mail: 'antim.timsina7777@gmail.com',
                url:
                    'https://avatars1.githubusercontent.com/u/43087414?s=460&v=4',
              ),
              DevDetail(
                themeData: themeData,
                name: 'Lakshya Pandit',
                job: 'Data Scientist | Backend',
                mail: 'lakshyapandit2054@gmail.com',
                url:
                    'https://media.licdn.com/dms/image/C5103AQFr9aEhmsPeJA/profile-displayphoto-shrink_200_200/0?e=1567036800&v=beta&t=9lweHGplQnEbLOaaiDGdh3VySvePdbD05VF4giEQ7XY',
              ),
            ],
          ),
        ));
  }
}
