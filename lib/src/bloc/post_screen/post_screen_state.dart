import 'package:equatable/equatable.dart';

class PostScreenState extends Equatable{
  PostScreenState([List props = const []]):super();
  List<Object?> get props => [];
}

class LoadingPostScreenState extends PostScreenState{
  LoadingPostScreenState():super();
}
class InitPostScreenState extends PostScreenState{
  InitPostScreenState():super();
}
class FetchDataPostScreenState extends PostScreenState{
  FetchDataPostScreenState():super();
}
class EmptyDataPostScreenState extends PostScreenState{
  EmptyDataPostScreenState():super();
}