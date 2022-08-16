import 'package:darularqam/models/ApiEndpoints.dart';
import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:darularqam/models/CustomHttpRequest.dart';
import 'package:darularqam/models/SermonModel.dart';
import 'package:darularqam/services/sermon_services.dart';
import 'package:darularqam/widgets/books_listview_shimmer.dart';
import 'package:darularqam/widgets/custom_app_bar.dart';
import 'package:darularqam/widgets/custom_bottom_navigation.dart';
import 'package:darularqam/widgets/custom_error_widget.dart';
import 'package:darularqam/widgets/sermon_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:toast/toast.dart';

class SermonScreen extends StatelessWidget {
  getSermonsList(BuildContext context) async {
    SermonServices sermonServices = SermonServices();
    await sermonServices.getLatestSermons();
    List sermonList = sermonServices.sermonList;
    int lessonCount = sermonList.length;
    List<SermonModel> sermons = [];
    for (int i = 0; i < lessonCount; i++) {
      sermons.add(SermonModel(sermonList[i]));
    }
    return sermons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: SafeArea(
        child: Stack(
          // overflow: Overflow.visible,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Muxaadarooyinka / Qudbooyinka',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getSermonsList(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return BooksListViewShimmer();
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Center(
                          child: Text(
                              'This is embarrassing. Something went wrong '),
                        );
                      }
                      List<SermonModel> sermons = snapshot.data;
                      if (sermons.length <= 0) {
                        return Center(
                          child: Text('Wax Muxaadaro ah kuma jiro'),
                        );
                      }
                      return SermonListViewBuilder(
                        sermons: sermons,
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuildCustomBottomNavigationWidget(
        currentIndex: 3,
      ),
    );
  }
}
