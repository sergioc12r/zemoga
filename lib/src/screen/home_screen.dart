import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_event.dart';
import 'package:zemoga/src/common/utils/colors.dart';
import 'package:zemoga/src/common/utils/text_styles.dart';
import 'package:zemoga/src/screen/favorites_screen.dart';
import 'package:zemoga/src/screen/posts_screen.dart';

import '../app.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with SingleTickerProviderStateMixin, RouteAware{

  PostScreenBloc? _postScreenBloc;
  int? _currentIndex;
  TabController? _tabController;
  PostsScreen? _postScreen;
  FavScreen? _favScreen;
  RouteObserver<PageRoute>? routeObserver;


  @override
  void didChangeDependencies() {
    routeObserver = InheritedData.of(context)!.routeObserver;
    routeObserver!.subscribe(this, ModalRoute.of(context) as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    routeObserver!.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    _postScreenBloc = BlocProvider.of<PostScreenBloc>(context)..add(LoadingDataPostScreenEvent());
    _currentIndex = 0;
    _tabController = TabController(length: 2, vsync: this, initialIndex: _currentIndex ?? 0);
    _tabController!.addListener(() {
      if(_currentIndex == 0) _postScreenBloc!.add(LoadingDataPostScreenEvent());
      setState(() {
        _currentIndex = _tabController!.index;
      });
    });
    _postScreen = PostsScreen();
    _favScreen = FavScreen();
    super.initState();
  }

  @override
  void didPopNext() {
    _postScreenBloc = BlocProvider.of<PostScreenBloc>(context)..add(LoadingDataPostScreenEvent());
    _currentIndex = 0;
    _tabController!.animateTo(0, duration: Duration(milliseconds: 10));
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Posts',style: ZemogaTextStyles.robotoBold.copyWith(fontSize: 22, color: ZemogaColors.getTitleColor())),
        actions: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: ()=> _postScreenBloc!.add(RefreshInformationPostScreenEvent()),
              child: Icon(Icons.refresh, color: ZemogaColors.getTitleColor(),),
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.list),text: 'All Post'),
            Tab(icon: Icon(Icons.ac_unit_rounded), text: 'Favorites',)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _postScreenBloc!.add(DeleteAllPostScreenEvent()),
        child: Icon(Icons.delete, color: ZemogaColors.getTitleColor()),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          _postScreen!,
          _favScreen!
        ],
      )
    );
  }

}