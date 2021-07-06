import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post/post_bloc.dart';
import 'package:zemoga/src/bloc/post/post_event.dart';
import 'package:zemoga/src/bloc/post/post_state.dart';
import 'package:zemoga/src/common/utils/colors.dart';

class AnimatedFavoriteButton extends StatefulWidget{
  final AnimationController? controller;

  AnimatedFavoriteButton({Key? key, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedFavoriteButtonState();

}

class _AnimatedFavoriteButtonState extends State<AnimatedFavoriteButton> with SingleTickerProviderStateMixin{

  AnimationController? controller;
  PostBloc? bloc;

  @override
  void initState() {
    controller = widget.controller ?? AnimationController(vsync: this, duration: Duration(milliseconds:  500));
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) controller!.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<PostBloc>(context);
    bloc!.context = context;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: builder,bloc: bloc);
  }

  void onPressed() async {
    if (bloc!.post!.isFavorite ?? false)
      bloc!.add(OnUnFavoritePostEvent());
    else
      bloc!.add(OnFavoritePostEvent());
  }

  Widget builder(BuildContext context, PostState state) {
    if (state is OnFetchedPostSate) {
      var icon = GestureDetector(
        onTap: state.loadLike ?? false ? null : onPressed,
        child: Icon(
          bloc?.post?.isFavorite ?? false
              ? Icons.star
              : Icons.star_border,
          color: state.post?.isFavorite ?? false
              ? Colors.yellow
              : ZemogaColors.getSecondaryIconsColor(),
          size: 30,
        ),
      );
      return GestureDetector(
        onTap: state.loadLike ?? false ? null : onPressed,
        child: icon,
      );
    }
    return Container();
  }

}