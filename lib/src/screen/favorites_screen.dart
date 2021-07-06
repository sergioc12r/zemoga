import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/favorites_screen/fav_bloc.dart';
import 'package:zemoga/src/bloc/favorites_screen/fav_event.dart';
import 'package:zemoga/src/bloc/favorites_screen/fav_state.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_bloc.dart';
import 'package:zemoga/src/common/ui/post_card.dart';
import 'package:zemoga/src/common/ui/post_card_place_holder.dart';
import 'package:zemoga/src/common/utils/colors.dart';

class FavScreen extends StatefulWidget{
  final Function()? reload;

  const FavScreen({Key? key, this.reload}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen>{

  PostScreenBloc? bloc;
  FavBloc? favBloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PostScreenBloc>(context);
    favBloc = FavBloc(InitFavState(),postScreenBloc: bloc)..add(LoadingDataFavEvent());
    super.initState();
  }

  @override
  void dispose() {
    favBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: BlocBuilder(
        bloc: favBloc!,
        builder: (context,state){
          if(state is InitFavState)
            return _loadingWidget();
          if(state is LoadingFavState)
            return _loadingWidget();
          if(state is EmptyDataFavState)
            return _emptySpace();
          if(state is FetchDataFavState)
            return _data(state);
          return Container();
        },
      ),
    );
  }

  Widget _emptySpace(){
    return Container(child: Center(child: Column(
      children: [
        SizedBox(height: 50),
        Text('Empty data, reload for retry'),
        GestureDetector(
          onTap: ()=> widget.reload!(),
          child: Icon(Icons.refresh, color: ZemogaColors.getTitleColor(),size: 50,),
        ),
      ],
    ),),);
  }

  Widget _data(FetchDataFavState? state) {
    if(favBloc!.posts!.isEmpty) return Center(child: Text('Empty'),);
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
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  favBloc!.add(DeleteOneFavEvent(postId: bloc?.posts?[index].id));
                  favBloc!.posts!.remove(bloc?.posts?[index]);
                  setState(() {
                  });
                },
                key: ObjectKey(favBloc?.posts?[index]),
                child: PostCard(
                  key: UniqueKey(),
                  post: favBloc?.posts?[index],
                  postScreenBloc: bloc,
                ),
              )),
          childCount: favBloc?.posts?.length ?? 0,
        ));
  }

  Widget _loadingWidget(){
    return Center(child: CardPlaceHolder());
  }

}