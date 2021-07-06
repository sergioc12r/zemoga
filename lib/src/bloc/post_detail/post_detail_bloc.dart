import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post_detail/post_detail_event.dart';
import 'package:zemoga/src/bloc/post_detail/post_detail_state.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/models/api_response.dart';
import 'package:zemoga/src/models/comment.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/models/user.dart';
import 'package:zemoga/src/resources/repository/repository.dart';

class PostDetailBloc extends Bloc<PostDetailEvent,PostDetailState>{

  final int? postId;
  Post? post;
  Repository? _repository = Utils.repository;
  List<Comment> comments = [];
  User? user;

  PostDetailBloc(PostDetailState initialState,{this.postId}) : super(initialState);

  @override
  Stream<PostDetailState> mapEventToState(PostDetailEvent event)async* {
    if(event is LoadPostDetailEvent){
      yield LoadingDataDetailState();
      ApiResponse<Post>? response = await _repository!.fetchPostDetail(postId: postId);
      if(response?.failure ?? true){
        yield ErrorDataDetailState();
        return;
      }
      post = response!.body;
      post = post!.copyWith(isFavorite: _repository!.db.favorite.exist(post!.id!), isRead: true);
      _repository!.db.read.addItem(post!.id!);
      ApiResponse<User>? responseUser = await _repository!.fetchUserAuthor(userId: post!.userId);
      user = responseUser?.body;
      ApiResponse<List<Comment>>? responseComments = await _repository!.fetchPostComments(postId: postId);
      comments = responseComments?.body ?? <Comment> [];
      yield FetchDataDetailState(isLoadingComments: false);
    }
  }

}