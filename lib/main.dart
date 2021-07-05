import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:zemoga/src/app.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/resources/repository/repository.dart';

void main() async {

  await injectDependencies();

  FlutterError.onError = (FlutterErrorDetails details) {
    print("Flutter error $details");
  };

  debugPaintLayerBordersEnabled = false;
  debugPaintSizeEnabled = false;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
        (_) {
      runApp(App());
    },
  );
}

injectDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = Repository();
  Utils.inject(repository: repository);
}