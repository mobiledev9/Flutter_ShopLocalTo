// ignore: avoid_web_libraries_in_flutter
import 'dart:io';

abstract class UpdateEvent {}

class OnUpdate extends UpdateEvent {
  final String username;
  final String email;
  final String phone;
  final String address;
  final String info;
  final String website;
  final File image;

  OnUpdate({this.username, this.email, this.phone, this.address, this.info, this.website,this.image});
}

class AfterUpdate extends UpdateEvent {
  AfterUpdate();
}