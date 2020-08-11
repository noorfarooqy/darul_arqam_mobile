import 'package:darularqam/widgets/CustomBottomNavigation.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                        'assets/images/logo2.png',
                      ),
                      height: 40,
                    ),
                    Text(
                      'DAARUL ARQAM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'This application is a product of Drongo Technology.'
                      ' It is a free application for learning Islamic knowledge'
                      ' from well known and credited Somali Scholars. Currently the application content is '
                      'based solely on the Somali language. But in the future, we will add '
                      'more languages in sha Allah.',
                  style: TextStyle(
                    wordSpacing: 3.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'For feedback or more information. Contact us from the info below',
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.email),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text('daarularqam@drongo.vip'),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.web),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text('www.drongo.tech'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:60.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Image(
                        height: 100,
                        image: AssetImage('assets/images/drongoLogo.png'),
                      ),
                    ),
                    Text(
                      'Drongo Technology',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Squada'
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
      bottomNavigationBar: BuildCustomBottomNavigationWidget(currentIndex: 4,),
    );
  }
}
