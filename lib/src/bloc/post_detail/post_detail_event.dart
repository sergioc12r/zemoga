import 'package:equatable/equatable.dart';

class PostDetailEvent extends Equatable{
  PostDetailEvent([List props = const []]):super();
  @override
  List<Object?> get props => [];
}

class LoadPostDetailEvent extends PostDetailEvent{
  LoadPostDetailEvent():super();
}