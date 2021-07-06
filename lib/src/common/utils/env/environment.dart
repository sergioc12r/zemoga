import 'package:zemoga/src/common/utils/env/routes.dart';

class Environment{

  final String? apiJson;

  const Environment({this.apiJson});

  static const PRODUCTION = Environment(
    apiJson: ApiEnvironment.PRODUCTION
  );

}