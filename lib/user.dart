import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  late int? contatoID;
  final String name;
  final String email;
  final String phonenumber;

  User(
      {this.contatoID,
      required this.name,
      required this.email,
      required this.phonenumber});

  @override
  List<Object?> get props => [contatoID];
}
