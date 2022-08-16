import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BooksListViewShimmer extends StatelessWidget {
  const BooksListViewShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorCodesModel.swatch1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    color: ColorCodesModel.swatch1,
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorCodesModel.swatch1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    color: ColorCodesModel.swatch1,
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorCodesModel.swatch1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    color: ColorCodesModel.swatch1,
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorCodesModel.swatch1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    color: ColorCodesModel.swatch1,
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorCodesModel.swatch1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    color: ColorCodesModel.swatch1,
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorCodesModel.swatch1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    color: ColorCodesModel.swatch1,
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorCodesModel.swatch1,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    color: ColorCodesModel.swatch1,
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
          ],
        ),
        baseColor: ColorCodesModel.swatch2,
        highlightColor: ColorCodesModel.swatch1,
      ),
    );
  }
}
