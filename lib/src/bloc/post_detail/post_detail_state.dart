import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PostDetailState extends Equatable{

  PostDetailState([List props = const []]):super();

  @override
  List<Object?> get props => [];
}

class InitPostDetailState extends PostDetailState{
  InitPostDetailState():super();
}

class FetchDataDetailState extends PostDetailState{
  final bool? isLoadingComments;
  FetchDataDetailState({this.isLoadingComments :false}):super([isLoadingComments, UniqueKey()]);
}

class LoadingDataDetailState extends PostDetailState{
  LoadingDataDetailState():super();
}

class ErrorDataDetailState extends PostDetailState{
  ErrorDataDetailState():super();
}