import 'package:equatable/equatable.dart';
import 'package:zemoga/src/models/comment.dart';

class Post extends Equatable{

  final int? id;
  final int? userId;
  final String? title;
  final String? body;
  final bool? isRead;
  final List<Comment>? comments;
  final bool? isFavorite;

  Post({this.id, this.userId, this.title, this.body, this.isRead, this.comments, this.isFavorite}):super();

  @override
  List<Object?> get props => [id,userId,title,body,isRead,comments,isFavorite];

  factory Post.fromJson(Map<String,dynamic> parsedJson){
    return Post(
      id: parsedJson["id"],
      userId: parsedJson["userId"],
      title: parsedJson["title"],
      body: parsedJson["body"],
      isRead: false,
      comments: <Comment>[],
      isFavorite: false,
    );
  }

  Post copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
    bool? isRead,
    List<Comment>? comments,
    bool? isFavorite
  }){
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      comments: comments ?? this.comments,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

}