import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_event.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_state.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/models/api_response.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/resources/repository/repository.dart';

class PostScreenBloc extends Bloc<PostScreenEvent,PostScreenState> {

  PostScreenBloc(PostScreenState initialState) : super(initialState);

  List<Post>? posts = [];
  Repository? _repository = Utils.repository;
  int? page = 0;


  @override
  Stream<PostScreenState> mapEventToState(PostScreenEvent event) async* {
    if (event is LoadingDataPostScreenEvent) {
      yield LoadingPostScreenState();
      ApiResponse<List<Post>>? response = await _repository!.fetchAllPosts();
      if (response!.failure) {
        yield EmptyDataPostScreenState();
        return;
      }
      posts = response.body;
      posts = await parseEliminatedPost();
      posts = await parseFavoritePost();
      posts = await parseReadPost();
      if(posts!.isEmpty){
        yield EmptyDataPostScreenState();
        return;
      }
      yield FetchDataPostScreenState();
    }
    if (event is ReloadAlPostScreenEvent) {
      posts = await parseEliminatedPost();
      posts = await parseFavoritePost();
      posts = await parseReadPost();
      yield FetchDataPostScreenState();
    }

    if(event is DeleteAllPostScreenEvent){
      yield LoadingPostScreenState();
      _repository!.db.postsEliminated.clearData();
      _repository!.db.read.clearData();
      _repository!.db.favorite.clearData();
      posts = [];
      yield EmptyDataPostScreenState();
    }

    if(event is RefreshInformationPostScreenEvent){
      yield LoadingPostScreenState();
      _repository!.db.postsEliminated.clearData();
      _repository!.db.read.clearData();
      _repository!.db.favorite.clearData();
      posts = [];
      add(LoadingDataPostScreenEvent());
    }

    if(event is DeleteOnePostScreenEvent){
      _repository!.db.postsEliminated.addItem(event.postId!);
    }


  }

  Future<List<Post>> parseFavoritePost()async{
    List<Post> cache = [];
    posts?.forEach((element) {
      if(_repository!.db.favorite.exist(element.id!))
        cache.add(element.copyWith(isFavorite: true));
      else
        cache.add(element);
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
      if(!(_repository!.db.postsEliminated.exist(element.id!)))
        cache.add(element);
    });
    return cache;
  }

}