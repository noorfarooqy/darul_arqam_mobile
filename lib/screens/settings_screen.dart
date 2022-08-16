import 'package:darularqam/constants/app_info.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/widgets/custom_app_bar.dart';
import 'package:darularqam/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SettingItemWidget(title: 'Application', text: appNameSL),
              SettingItemWidget(title: 'Version', text: appVersion),
              SettingItemWidget(
                  title: 'Developed & Managed by', text: developer),
              SettingItemWidget(title: 'Contact email', text: contactEmail),
              SettingItemWidget(title: 'Contact Phone', text: contactPhone),
              SettingItemWidget(title: 'About us', text: appInfo),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Image(
                        height: 100,
                        image: AssetImage('assets/images/drongo.png'),
                      ),
                    ),
                    Text(
                      'Drongo Technology',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Squada'),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
      bottomNavigationBar: BuildCustomBottomNavigationWidget(
        currentIndex: 4,
      ),
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({Key key, @required this.title, @required this.text})
      : super(key: key);
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorCodesModel.swatch1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Squada',
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
