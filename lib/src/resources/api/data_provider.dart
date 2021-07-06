import 'dart:convert';

import 'package:http/http.dart';
import 'package:zemoga/src/models/api_response.dart';
import 'package:zemoga/src/models/comment.dart';
import 'package:zemoga/src/models/post.dart';
import 'package:zemoga/src/models/user.dart';
import 'package:zemoga/src/resources/service/data_service.dart';

class DataProvider extends DataService{

  DataProvider(Client client) : super(client);

  Future<ApiResponse<List<Post>>>? fetchAllPosts()async{
    try{
      final response = await client.get(Uri.parse('$root/posts'));
      if(response.statusCode != 200) return ApiResponse(statusCode: 500, success: false, body:<Post>[],message: response.body);
      final parsedJson = jsonDecode(response.body);
      Iterable i = parsedJson;
      return ApiResponse(
        success: true,
        statusCode: response.statusCode,
        body: i.map((post) => Post.fromJson(post)).toList(),
      );

    }catch(e){
      print('error in fetchAllPosts $e');
      return ApiResponse(statusCode: 500, success: false, body:<Post>[]);
    }
  }

  Future<ApiResponse<List<Comment>>>? fetchPostComments({int? postId})async{
    try{
      final response = await client.get(Uri.parse('$root/posts/$postId/comments'));
      if(response.statusCode != 200) return ApiResponse(statusCode: 500, success: false, body:<Comment>[],message: response.body);
      final parsedJson = jsonDecode(response.body);
      Iterable i = parsedJson;
      return ApiResponse(
          success: true,
          statusCode: response.statusCode,
          body: i.map((comment) => Comment.fromJson(comment)).toList(),
      );
    }catch(e){
      print('error in fetchAllPosts $e');
      return ApiResponse(statusCode: 500, success: false, body:<Comment>[]);
    }
  }

  Future<ApiResponse<Post>>? fetchPostDetail({int? postId})async{
    try{
      final response = await client.get(Uri.parse('$root/posts/$postId'));
      if(response.statusCode != 200) return ApiResponse(statusCode: 500, success: false,message: response.body);
      final parsedJson = jsonDecode(response.body);
      return ApiResponse(
          success: true,
          statusCode: response.statusCode,
          body: Post.fromJson(parsedJson)
      );
    }catch(e){
      print('error in fetchAllPosts $e');
      return ApiResponse(statusCode: 500, success: false);
    }
  }

  Future<ApiResponse<User>>? fetchUserAuthor({int? userId})async{
    try{
      final response = await client.get(Uri.parse('$root/users/$userId'));
      if(response.statusCode != 200) return ApiResponse(statusCode: 500, success: false,message: response.body);
      final parsedJson = jsonDecode(response.body);
      return ApiResponse(
          success: true,
          statusCode: response.statusCode,
          body: User.fromJson(parsedJson)
      );
    }catch(e){
      print('error in fetchUserPost $e');
      return ApiResponse(statusCode: 500, success: false);
    }
  }

}