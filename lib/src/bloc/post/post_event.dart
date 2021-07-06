import 'package:equatable/equatable.dart';

class PostEvent extends Equatable{
  PostEvent([List props = const []]):super();
  @override
  List<Object?> get props => [];
}

class OnFavoritePostEvent extends PostEvent{
  OnFavoritePostEvent():super();
}

class OnUnFavoritePostEvent extends PostEvent{
  OnUnFavoritePostEvent():super();
}

class OnRemovePostEvent extends PostEvent{
  OnRemovePostEvent():super();
}