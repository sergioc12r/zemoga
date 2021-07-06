import 'package:http/http.dart';
import 'package:zemoga/src/models/api_response.dart';
import 'package:zemoga/src/models/comment.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/models/user.dart';
import 'package:zemoga/src/resources/api/data_provider.dart';
import 'package:zemoga/src/resources/database/database.dart';

class Repository{
  static final Client client = Client();
  final DataProvider _data = DataProvider(client);
  final db = DataBase();


  Future<ApiResponse<List<Post>>>? fetchAllPosts() {
    return _data.fetchAllPosts();
  }

  Future<ApiResponse<Post>>? fetchPostDetail({int? postId}) {
    return _data.fetchPostDetail(postId: postId);
  }

  Future<ApiResponse<List<Comment>>>? fetchPostComments({int? postId}) {
    return _data.fetchPostComments(postId: postId);
  }

  Future<ApiResponse<User>>? fetchUserAuthor({int? userId}) {
    return _data.fetchUserAuthor(userId: userId);
  }





}