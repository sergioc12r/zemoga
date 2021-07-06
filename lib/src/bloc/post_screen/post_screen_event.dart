import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PostScreenEvent extends Equatable{

  PostScreenEvent([List props = const []]):super();

  @override
  List<Object?> get props => [];
}

class LoadingDataPostScreenEvent extends PostScreenEvent{
}

class ReloadAlPostScreenEvent extends PostScreenEvent{
}

class DeleteAllPostScreenEvent extends PostScreenEvent{
}

class RefreshInformationPostScreenEvent extends PostScreenEvent{

}

class DeleteOnePostScreenEvent extends PostScreenEvent{
  final int? postId;
  DeleteOnePostScreenEvent({this.postId}):super([postId, UniqueKey()]);
}