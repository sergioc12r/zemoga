import 'package:equatable/equatable.dart';

class Post extends Equatable{

  final int? id;
  final int? userId;
  final String? title;
  final String? body;

  Post({this.id, this.userId, this.title, this.body}):super();

  @override
  List<Object?> get props => [id,userId,title,body];

  factory Post.fromJson(Map<String,dynamic> parsedJson){
    return Post(
      id: parsedJson["id"],
      userId: parsedJson["userId"],
      title: parsedJson["title"],
      body: parsedJson["body"],
    );
  }

}