import 'package:equatable/equatable.dart';

class Comment extends Equatable{

  final int? id;
  final int? postId;
  final String? name;
  final String? email;
  final String? body;

  Comment({this.id, this.postId, this.name, this.email, this.body}):super();

  @override
  List<Object?> get props => [id,postId,name,email,body];

  factory Comment.fromJson(Map<String,dynamic>parsedJson){
    return Comment(
      id: parsedJson["id"],
      postId: parsedJson["postId"],
      name: parsedJson["name"],
      email: parsedJson["email"],
      body: parsedJson["body"],
    );
  }
}