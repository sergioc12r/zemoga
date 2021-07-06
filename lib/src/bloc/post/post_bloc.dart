import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post/post_event.dart';
import 'package:zemoga/src/bloc/post/post_state.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_event.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/resources/repository/repository.dart';

class PostBloc extends Bloc<PostEvent,PostState>{

  Post? post;
  Repository? _repository = Utils.repository;
  BuildContext? context;
  PostScreenBloc? postScreenBloc;

  PostBloc(PostState initialState,{this.post,this.postScreenBloc}) : super(initialState);


  @override
  Stream<PostState> mapEventToState(PostEvent event) async*{
    if(event is OnFavoritePostEvent){
      _repository!.db.favorite.addItem(post?.id ?? 0);
      post = post?.copyWith(isFavorite: true);
      yield OnFetchedPostSate(post: post, loadLike: true,key:UniqueKey());
      postScreenBloc?.add(ReloadAlPostScreenEvent());
      yield OnFetchedPostSate(post: post, loadLike: false,key:UniqueKey());
    }

    if(event is OnUnFavoritePostEvent){
        _repository!.db.favorite.delete(post!.id ?? 0);
        post = post?.copyWith(isFavorite: false);
        yield OnFetchedPostSate(post: post, loadLike: true,key:UniqueKey());
        postScreenBloc?.add(ReloadAlPostScreenEvent());
        yield OnFetchedPostSate(post: post, loadLike: false,key:UniqueKey());
    }

    if(event is OnRemovePostEvent){
      _repository!.db.postsEliminated.addItem(post!.id ?? 0);
      postScreenBloc?.add(ReloadAlPostScreenEvent());
      yield OnFetchedPostSate(post: post, loadLike: false,key:UniqueKey());
    }


  }

}