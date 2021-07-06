import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/favorites_screen/fav_event.dart';
import 'package:zemoga/src/bloc/favorites_screen/fav_state.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_event.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/resources/repository/repository.dart';

class FavBloc extends Bloc<FavEvent,FavState> {

  final PostScreenBloc? postScreenBloc;

  FavBloc(FavState initialState,{this.postScreenBloc}) : super(initialState);

  List<Post>? posts = [];
  Repository? _repository = Utils.repository;
  int? page = 0;


  @override
  Stream<FavState> mapEventToState(FavEvent event) async* {
    if (event is LoadingDataFavEvent) {
      yield LoadingFavState();
      posts = postScreenBloc!.posts;
      posts = await parseEliminatedPost();
      posts = await parseFavoritePost();
      posts = await parseReadPost();
      if(posts!.isEmpty){
        yield EmptyDataFavState();
        return;
      }
      yield FetchDataFavState();
    }
    if (event is ReloadAlFavEvent) {
      posts = await parseEliminatedPost();
      posts = await parseFavoritePost();
      posts = await parseReadPost();
      yield FetchDataFavState();
    }

    if(event is DeleteOneFavEvent){
      _repository!.db.postsEliminated.addItem(event.postId!);
      postScreenBloc!.add(ReloadAlPostScreenEvent());

    }


  }

  Future<List<Post>> parseFavoritePost()async{
    List<Post> cache = [];
    posts?.forEach((element) {
      if(_repository!.db.favorite.exist(element.id!))
        cache.add(element.copyWith(isFavorite: true));
    });
    return cache;
  }

  Future<List<Post>> parseReadPost()async{
    List<Post> cache = [];
    posts?.forEach((element) {
      if(_repository!.db.read.exist(element.id!))
        cache.add(element.copyWith(isRead: true));
      else
        cache.add(element);
    });
    return cache;
  }

  Future<List<Post>> parseEliminatedPost()async{
    List<Post> cache = [];
    posts?.forEach((element) {
      if(_repository!.db.postsEliminated.exist(element.id!))
        print("eliminated");
      else
        cache.add(element);
    });
    return cache;
  }

}