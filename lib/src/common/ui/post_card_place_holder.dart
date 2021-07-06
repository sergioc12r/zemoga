import 'package:zemoga/src/common/ui/base_card.dart';
import 'package:zemoga/src/common/ui/place_holder_mixin.dart';
import 'package:flutter/material.dart';

class CardPlaceHolder extends StatelessWidget with PlaceholderMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseCard(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(15),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                emptyContainer(
                    maxHeight: 30,
                    maxWidth: 120, margin: EdgeInsets.only(bottom: 15)
                ),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
                buildItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }






}