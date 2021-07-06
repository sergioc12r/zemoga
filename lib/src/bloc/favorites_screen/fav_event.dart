import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FavEvent extends Equatable{

  FavEvent([List props = const []]):super();

  @override
  List<Object?> get props => [];
}

class LoadingDataFavEvent extends FavEvent{}

class ReloadAlFavEvent extends FavEvent{}

class DeleteOneFavEvent extends FavEvent{
  final int? postId;
  DeleteOneFavEvent({this.postId}):super([postId, UniqueKey()]);
}