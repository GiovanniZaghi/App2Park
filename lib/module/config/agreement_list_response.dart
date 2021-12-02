import 'package:app2park/module/agreement/agreement_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agreement_list_response.g.dart';

@JsonSerializable()
class AgreementListResponse{
  String status;
  List<Agreements> data;
  String message;

  AgreementListResponse({this.status, this.data, this.message});

  factory AgreementListResponse.fromJson(Map<String, dynamic> json) => _$AgreementListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementListResponseToJson(this);

}