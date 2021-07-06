import 'package:equatable/equatable.dart';
import 'package:zemoga/src/models/address.dart';
import 'package:zemoga/src/models/company.dart';

class User extends Equatable{

  final int? id;
  final String? name;
  final String? userName;
  final String? email;
  final String? phone;
  final String? website;
  final Company? company;
  final Address? address;

  User({this.id, this.name, this.userName, this.email, this.phone, this.website, this.company,this.address}):super();

  @override
  List<Object?> get props => [id,name,userName,email,phone,website,company,address];

  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User(
      id: parsedJson["id"],
      name: parsedJson["name"],
      userName: parsedJson["username"],
      email: parsedJson["email"],
      phone: parsedJson["phone"],
      website: parsedJson["website"],
      company: parsedJson.containsKey("company") ? Company.fromJson(parsedJson["company"]) : null,
      address: parsedJson.containsKey("address") ? Address.fromJson(parsedJson["address"]) : null
    );
  }

}