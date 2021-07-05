import 'package:equatable/equatable.dart';
import 'package:zemoga/src/models/company.dart';

class User extends Equatable{

  final int? id;
  final String? name;
  final String? userName;
  final String? email;
  final String? phone;
  final String? website;
  final Company? company;

  User({this.id, this.name, this.userName, this.email, this.phone, this.website, this.company}):super();

  @override
  List<Object?> get props => [id,name,userName,email,phone,website,company];

  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User(
      id: parsedJson["id"],
      name: parsedJson["name"],
      userName: parsedJson["username"],
      email: parsedJson["email"],
      phone: parsedJson["phone"],
      website: parsedJson["website"],
      company: parsedJson.containsKey("company") ? Company.fromJson(parsedJson["company"]) : null,
    );
  }

}