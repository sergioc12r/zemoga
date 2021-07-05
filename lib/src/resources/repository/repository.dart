import 'package:http/http.dart';
import 'package:zemoga/src/models/api_response.dart';
import 'package:zemoga/src/models/comment.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/resources/api/data_provider.dart';

class Repository{
  static final Client client = Client();
  final DataProvider _data = DataProvider(client);


  Future<ApiResponse<List<Post>>>? fetchAllPosts({int? page}) {
    return _data.fetchAllPosts();
  }

  Future<ApiResponse<Post>>? fetchPostDetail({Post? post}) {
    return _data.fetchPostDetail(post: post);
  }

  Future<ApiResponse<List<Comment>>>? fetchPostComments({Post? post}) {
    return _data.fetchPostComments(post: post);
  }





}