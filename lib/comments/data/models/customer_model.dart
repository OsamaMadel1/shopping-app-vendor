// customer_model.dart

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends Equatable {
  final String firstName;
  final String lastName;

  const CustomerModel({required this.firstName, required this.lastName});

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  List<Object?> get props => [firstName, lastName];
}
