import 'package:http/http.dart';
import 'package:zemoga/src/common/utils/utils.dart';
import 'package:zemoga/src/resources/service/api_service.dart';

class DataService extends ApiService{
  DataService(Client client) : super(client);

  @override
  String get root => Utils.environment.apiJson ?? "";
}