import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseModel<T> {
  final bool succeeded;
  final T? data;
  final Map<String, List<String>>? errors;

  ResponseModel({required this.succeeded, this.data, this.errors});

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResponseModelToJson(this, toJsonT);
}
