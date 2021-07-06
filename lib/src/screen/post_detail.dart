import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post/post_bloc.dart';
import 'package:zemoga/src/bloc/post/post_state.dart';
import 'package:zemoga/src/bloc/post_detail/post_detail_bloc.dart';
import 'package:zemoga/src/bloc/post_detail/post_detail_event.dart';
import 'package:zemoga/src/bloc/post_detail/post_detail_state.dart';
import 'package:zemoga/src/common/ui/animated_favorite.dart';
import 'package:zemoga/src/common/ui/comment_card.dart';
import 'package:zemoga/src/common/ui/post_card_place_holder.dart';
import 'package:zemoga/src/common/utils/colors.dart';
import 'package:zemoga/src/common/utils/text_styles.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/models/post.dart';

class PostDetail extends StatefulWidget{
  final int? postId;

  PostDetail({Key? key, this.postId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDetail();
}

class _PostDetail extends State<PostDetail>{

  PostDetailBloc? _bloc;
  Post? post;

  bool? authorExpanded;

  @override
  void initState() {
    _bloc = PostDetailBloc(InitPostDetailState(), postId: widget.postId)..add(LoadPostDetailEvent());
    authorExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, PostDetailState state){
        if(state is InitPostDetailState)
          return _loadingWidget();
        if(state is LoadingDataDetailState)
          return _loadingWidget();
        if(state is FetchDataDetailState)
          return _allData(state);
        return Container();
      },
    );
  }

  Widget _loadingWidget(){
    return Center(child: CardPlaceHolder());
  }

  Widget _allData(FetchDataDetailState state){
    post = _bloc!.post;
    return BlocProvider(
      create: (context) => PostBloc(OnFetchedPostSate(post: post), post: post),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Post',style: ZemogaTextStyles.robotoBold.copyWith(fontSize: 22, color: ZemogaColors.getTitleColor())),
          actions: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedFavoriteButton()
            )
          ],
        ),
        body: _body(state),
      ),
    );
  }

  Widget _body(FetchDataDetailState state){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min  ,
        children: [
          _bloc?.user == null ? Container() : _profileView(),
          SizedBox(height: 10),
          _titleView(),
          SizedBox(height: 10),
          _bodyView(),
          SizedBox(height: 10),
          Divider(),
          _commentView(),
          SizedBox(height: 10 + MediaQuery.of(context).padding.bottom)
        ],
      ),
    );
  }

  Widget _profileView(){
    return Column(
      children: [
        GestureDetector(
          onTap: authorTap,
          child: Row(children: [
            Text('Author: ', style: ZemogaTextStyles.robotoBold.copyWith(fontSize: 15, color: ZemogaColors.getTitleColor())),
            SizedBox(width: 10),
            Text(_bloc?.user?.name ?? 'Name', style: ZemogaTextStyles.robotoBold.copyWith(fontSize: 15, color: ZemogaColors.getSecondaryColor())),
            SizedBox(width: 5),
            GestureDetector(onTap: authorTap,
              child: Icon(authorExpanded! ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 20,),
            ),
          ],),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 50),
          curve: Curves.easeIn,
          height: authorExpanded ?? false  ? 150 : 0,
          child: Row(
            mainAxisSize: MainAxisSize.min  ,
            children: [
              Container(
                  width: 50,
                  height: 50,
                  child: _buildPhoto()),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Email: ${_bloc?.user?.email}',style: ZemogaTextStyles.robotoRegular.copyWith(fontSize: 13),),
                    Text('Phone: ${_bloc?.user?.phone}',style: ZemogaTextStyles.robotoRegular.copyWith(fontSize: 13),),
                    Text('Website: ${_bloc?.user?.website}',style: ZemogaTextStyles.robotoRegular.copyWith(fontSize: 13),),
                    Text('Address: ${_bloc?.user?.address?.city} ${_bloc?.user?.address?.street}',style: ZemogaTextStyles.robotoRegular.copyWith(fontSize: 13),maxLines: 2,),
                    Text('Company: ${_bloc?.user?.company?.name}',style: ZemogaTextStyles.robotoRegular.copyWith(fontSize: 13),),
                    Text('Company Catch Phrase: ${_bloc?.user?.company?.catchPhrase}',style: ZemogaTextStyles.robotoRegular.copyWith(fontSize: 13),maxLines: 2,),
                    Row(children: [Expanded(child: SizedBox(),)],),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],

    );
  }

  Widget _buildPhoto(){
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
  Widget _titleView(){
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Title:', style: ZemogaTextStyles.robotoBold.copyWith(fontSize: 15, color: ZemogaColors.getTitleColor())),
        SizedBox(width: 10),
        Expanded(child: Text(_bloc?.post?.title ?? 'Title', style: ZemogaTextStyles.robotoBold.copyWith(fontSize: 15, color: ZemogaColors.getTitleColor()), maxLines: 5)),
      ],
    );
  }

  Widget _bodyView(){
    return Row(
      children: [
        Expanded(child: Text(_bloc?.post?.body ?? 'body', style: ZemogaTextStyles.robotoBold.copyWith(fontSize: 13, color: ZemogaColors.getTitleColor()), maxLines: 25)),
      ],
    );
  }

  Widget _commentView(){
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:_bloc?.comments.length ?? 0,
        itemBuilder: (context,index){
          return  CommentCard(comment: _bloc?.comments[index]);
        });
  }

  authorTap(){
    setState(() {
      authorExpanded = !(authorExpanded ?? false);
    });
  }


}