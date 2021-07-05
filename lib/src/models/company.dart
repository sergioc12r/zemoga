import 'package:equatable/equatable.dart';

class Company extends Equatable{

  final String? name;
  final String? catchPhrase;
  final String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  @override
  List<Object?> get props => [name, catchPhrase, bs];

  factory Company.fromJson(Map<String,dynamic> parsedJson){
    return Company(
      name: parsedJson["name"],
      catchPhrase: parsedJson["catchPhrase"],
      bs: parsedJson["bs"]
    );
  }


}