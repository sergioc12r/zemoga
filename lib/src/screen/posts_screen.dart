import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_event.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_state.dart';
import 'package:zemoga/src/common/ui/post_card.dart';
import 'package:zemoga/src/common/ui/post_card_place_holder.dart';
import 'package:zemoga/src/common/utils/colors.dart';
import 'package:zemoga/src/common/utils/text_styles.dart';

class PostsScreen extends StatefulWidget{
  final Function()? reload;

  const PostsScreen({Key? key, this.reload}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>{

  PostScreenBloc? bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PostScreenBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: BlocBuilder(
        bloc: bloc!,
        builder: (context,state){
          if(state is InitPostScreenState)
            return _loadingWidget();
          if(state is LoadingPostScreenState)
            return _loadingWidget();
          if(state is EmptyDataPostScreenState)
            return _emptySpace();
          if(state is FetchDataPostScreenState)
            return _data(state);
          return Container();
        },
      ),
    );
  }

  Widget _emptySpace(){
    return Container(child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 50),
        Text('Empty data, reload for retry', style: ZemogaTextStyles.robotoBold,),
        GestureDetector(
          onTap: ()=> widget.reload!(),
          child: Icon(Icons.refresh, color: ZemogaColors.getTitleColor(),size: 50,),
        ),
      ],
    ),),);
  }

  Widget _data(FetchDataPostScreenState? state) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      slivers: [
        _paddingContainer(),
        _movementsData(),
        SliverToBoxAdapter(child: SizedBox(height: 70 + MediaQuery.of(context).padding.bottom)),
      ],
    );
  }
  Widget _paddingContainer(){
    return SliverToBoxAdapter(child: SizedBox(height: 10));
  }

  Widget _movementsData() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical:0),
          child: Dismissible(
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              bloc!.add(DeleteOnePostScreenEvent(postId: bloc?.posts?[index].id));
              bloc!.posts!.remove(bloc?.posts?[index]);
              setState(() {
              });
            },
            key: ObjectKey(bloc?.posts?[index]),
            child: PostCard(
              key: UniqueKey(),
              post: bloc?.posts?[index],
              postScreenBloc: bloc,
            ),
          )),
      childCount: bloc?.posts?.length ?? 0,
    ));
  }

  Widget _loadingWidget(){
    return Center(child: CardPlaceHolder());
  }

}