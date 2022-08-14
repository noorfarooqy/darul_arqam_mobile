import 'package:darularqam/models/ColorCodesModel.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SheekhGridShimmer extends StatelessWidget {
  const SheekhGridShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.14,
          child: Shimmer.fromColors(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        color: ColorCodesModel.swatch1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        color: ColorCodesModel.swatch1,
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        color: ColorCodesModel.swatch1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        color: ColorCodesModel.swatch1,
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        color: ColorCodesModel.swatch1,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        color: ColorCodesModel.swatch1,
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            baseColor: ColorCodesModel.swatch2,
            highlightColor: ColorCodesModel.swatch1,
          ),
        ),
      ],
    );
  }
}
