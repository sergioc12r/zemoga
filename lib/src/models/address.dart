import 'package:equatable/equatable.dart';

class Address extends Equatable{

  final String? street;
  final String? suite;
  final String? city;
  final String? zipCode;
  final String? latitude;
  final String? longitude;

  Address({this.street, this.suite, this.city, this.zipCode, this.latitude, this.longitude}):super();

  @override
  List<Object?> get props => [street,suite,city,zipCode,latitude,longitude];

  factory Address.fromJson(Map<String,dynamic> parsedJson){
    return Address(
      street: parsedJson["street"],
      suite: parsedJson["suite"],
      city: parsedJson["city"],
      zipCode: parsedJson["zipcode"],
      latitude: parsedJson.containsKey("geo") ? parsedJson["lat"] : '',
      longitude: parsedJson.containsKey("geo") ? parsedJson["lng"]: ''
    );
  }

}