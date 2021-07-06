import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zemoga/src/models/post.dart';

class PostState extends Equatable{

  PostState([List props = const []]) : super();

  @override
  List<Object?> get props => [];
}

class OnFetchedPostSate extends PostState{
  final Post? post;
  final bool? loadLike;
  OnFetchedPostSate({this.post, this.loadLike}):super([post,loadLike,UniqueKey()]);
}

class OnLoadPostState extends PostState{}