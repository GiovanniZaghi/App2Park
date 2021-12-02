// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_online_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketOnlineModel _$TicketOnlineModelFromJson(Map<String, dynamic> json) {
  return TicketOnlineModel(
    id: json['id'] as String,
    id_cupom: json['id_cupom'] as String,
    plate: json['plate'] as String,
    color: json['color'] as String,
    year: json['year'] as String,
    maker: json['maker'] as String,
    model: json['model'] as String,
    cupom_entrance_datetime: json['cupom_entrance_datetime'] as String,
    name_park: json['name_park'] as String,
    doc: json['doc'] as String,
    postal_code: json['postal_code'] as String,
    street: json['street'] as String,
    number: json['number'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    neighborhood: json['neighborhood'] as String,
    cell: json['cell'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    id_customer: json['id_customer'] as String,
    email: json['email'] as String,
    cell_customer: json['cell_customer'] as String,
    nome_customer: json['nome_customer'] as String,
  );
}

Map<String, dynamic> _$TicketOnlineModelToJson(TicketOnlineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_cupom': instance.id_cupom,
      'plate': instance.plate,
      'color': instance.color,
      'year': instance.year,
      'maker': instance.maker,
      'model': instance.model,
      'cupom_entrance_datetime': instance.cupom_entrance_datetime,
      'name_park': instance.name_park,
      'doc': instance.doc,
      'postal_code': instance.postal_code,
      'street': instance.street,
      'number': instance.number,
      'city': instance.city,
      'state': instance.state,
      'neighborhood': instance.neighborhood,
      'cell': instance.cell,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'id_customer': instance.id_customer,
      'email': instance.email,
      'cell_customer': instance.cell_customer,
      'nome_customer': instance.nome_customer,
    };
