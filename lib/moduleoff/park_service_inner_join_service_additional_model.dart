import 'package:json_annotation/json_annotation.dart';

part 'park_service_inner_join_service_additional_model.g.dart';

@JsonSerializable()
class ParkServiceInnerJoinServiceAdditionalModel {
  int id_servico;
  String name;
  int id;
  int status;
  double price;
  double price_p;
  String tolerance;
  int sort_order;
  String type;
  int tickado;

  ParkServiceInnerJoinServiceAdditionalModel(
      this.id_servico,
      this.name,
      this.id,
      this.status,
      this.price,
      this.price_p,
      this.tolerance,
      this.sort_order,
      this.type);

  factory ParkServiceInnerJoinServiceAdditionalModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkServiceInnerJoinServiceAdditionalModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkServiceInnerJoinServiceAdditionalModelToJson(this);
}
