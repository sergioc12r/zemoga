import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zemoga/src/models/post.dart';

abstract class PostState extends Equatable{
  PostState([List props = const []]) : super();
}

class OnFetchedPostSate extends PostState{
  final Post? post;
  final bool? loadLike;
  final Key? key;
  OnFetchedPostSate({this.post, this.loadLike, this.key}):super();

  @override
  List<Object?> get props => [post,loadLike,key];
}

class OnLoadPostState extends PostState{
  @override
  List<Object?> get props => [];
}