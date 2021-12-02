import 'package:app2park/module/agreement/agreement_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agreement_response.g.dart';

@JsonSerializable()
class AgreementResponse{
  String status;
  Agreements data;
  String message;

  AgreementResponse({this.status, this.data, this.message});

  factory AgreementResponse.fromJson(Map<String, dynamic> json) => _$AgreementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementResponseToJson(this);

}