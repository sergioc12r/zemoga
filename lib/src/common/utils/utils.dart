import 'package:zemoga/src/common/utils/env/environment.dart';
import 'package:zemoga/src/resources/repository/repository.dart';

class Utils{

  static const Environment environment = Environment.PRODUCTION;

  static Repository? _repository;

  static Repository? get repository => _repository;

  static String profilePlaceHolder = "https://180dc.org/wp-content/uploads/2017/11/profile-placeholder.png";

  static void inject({required Repository repository}) {
    _repository = repository;
  }

}