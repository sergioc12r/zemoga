import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post/post_bloc.dart';
import 'package:zemoga/src/bloc/post/post_state.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_bloc.dart';
import 'package:zemoga/src/common/ui/animated_favorite.dart';
import 'package:zemoga/src/common/utils/colors.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/screen/post_detail.dart';

class PostCard extends StatefulWidget{
  final Post? post;
  final PostScreenBloc? postScreenBloc;

  PostCard({Key? key,this.post,this.postScreenBloc}): super(key: key);

  @override
  State<StatefulWidget> createState() => _PostCardState();

}

class _PostCardState extends State<PostCard>{

  Post? post;
  PostBloc? _postBloc;

  @override
  void initState() {
    post = widget.post;
    _postBloc = PostBloc(OnFetchedPostSate(post: post), post: post,postScreenBloc: widget.postScreenBloc);
    _postBloc!.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      return BlocProvider(
        create: (context)=> _postBloc!,
        child: BlocBuilder(
            bloc: _postBloc,
            builder: (BuildContext context, PostState state){
              if(state is OnFetchedPostSate)
                post = _postBloc!.post;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedFavoriteButton(key: UniqueKey()),
                        SizedBox(width: 10),
                        Expanded(child: GestureDetector(onTap:_goToPost,child: Text(post!.title  ?? ""))),
                        post!.isRead ?? false ? Container():SizedBox(width: 10),
                        post!.isRead ?? false ? Container(): Container(width: 15, height: 15, decoration: BoxDecoration(color: Colors.lightBlue,shape: BoxShape.circle),),
                        post!.isRead ?? false ? Container():SizedBox(width: 10),
                        GestureDetector(
                          onTap: _goToPost,
                          child: Icon(Icons.arrow_forward_ios_rounded, color: ZemogaColors.getSecondaryIconsColor(), size: 20,),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            }),
      );
    });
  }

  _goToPost(){
    Navigator.push(context,MaterialPageRoute(builder: (context) => PostDetail(postId: post!.id)));
  }


}