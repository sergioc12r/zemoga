import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zemoga/src/common/utils/text_styles.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/models/comment.dart';

class CommentCard extends StatefulWidget {
  final Comment? comment;

  const CommentCard({Key? key, this.comment}): super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      child: ListTile(
        leading: buildPhoto(),
        subtitle: buildBody(),
      ),
    );
  }

  Widget buildPhoto() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: Container(
        height: 36,
        width: 36,
        decoration: ShapeDecoration(
          shape: CircleBorder(),
        ),
        child: GestureDetector(
          onTap: (){},
          child: CachedNetworkImage(
            imageUrl: Utils.profilePlaceHolder,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Text(
      widget.comment?.body ?? '',
      style: ZemogaTextStyles.robotoRegular.copyWith(fontSize: 14),
    );
  }

}