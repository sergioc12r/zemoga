import 'package:equatable/equatable.dart';

class FavState extends Equatable{
  FavState([List props = const []]):super();
  List<Object?> get props => [];
}

class LoadingFavState extends FavState{
  LoadingFavState():super();
}
class InitFavState extends FavState{
  InitFavState():super();
}
class FetchDataFavState extends FavState{
  FetchDataFavState():super();
}
class EmptyDataFavState extends FavState{
  EmptyDataFavState():super();
}