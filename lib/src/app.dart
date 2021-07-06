import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_bloc.dart';
import 'package:zemoga/src/bloc/post_screen/post_screen_state.dart';
import 'package:zemoga/src/common/utils/colors.dart';
import 'package:zemoga/src/common/utils/global_variables.dart';
import 'package:zemoga/src/screen/home_screen.dart';

class App extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App>{

  HomeScreen? _homeScreen;
  PostScreenBloc? _postScreenBloc;

  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  void initState() {
    _homeScreen = HomeScreen();
    _postScreenBloc = PostScreenBloc(InitPostScreenState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    GlobalVariables.lightTheme = brightness == Brightness.light;
    return InheritedData(
      routeObserver: routeObserver,
      widget: MaterialApp(
        navigatorObservers: <NavigatorObserver>[routeObserver],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ZemogaColors.getPrincipalColor(),
          accentColor: ZemogaColors.getPrincipalColor(),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: ZemogaColors.getPrincipalColor(),
          accentColor: ZemogaColors.getPrincipalColor(),
        ),
        onUnknownRoute: (settings)=> _buildMainApp(),
      ),
    );
  }

  MaterialPageRoute _buildMainApp() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return MultiBlocProvider(providers: [
        BlocProvider<PostScreenBloc>(
          create: (BuildContext context) => _postScreenBloc!,
        ),
      ], child: Center(
        child: Material(
          child: _homeScreen,
        ),
      ));
    });
  }

}

class InheritedData extends InheritedWidget {
  final RouteObserver<PageRoute>? routeObserver;
  final Widget? widget;

  InheritedData({this.routeObserver, required this.widget}): super(child: widget!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static InheritedData? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<InheritedData>();
}