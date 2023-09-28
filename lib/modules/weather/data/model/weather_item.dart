// ignore_for_file: non_constant_identifier_names

import 'package:structure_lesson/modules/weather/domain/entity/weather_item.dart';

class WeatherItemModel extends WeatherItemEntity {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  WeatherItemModel(
      {required this.avatar,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.id})
      : super(email: email, first_name: first_name);

  factory WeatherItemModel.fromJson(Map<String, dynamic> json) {
    return WeatherItemModel(
      id: json['id'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
