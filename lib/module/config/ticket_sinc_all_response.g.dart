// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_sinc_all_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketSincAllResponse _$TicketSincAllResponseFromJson(
    Map<String, dynamic> json) {
  return TicketSincAllResponse(
    status: json['status'] as String,
    message: json['message'] as String,
    tickets: (json['tickets'] as List)
        ?.map((e) =>
            e == null ? null : Ticket.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    ticket_historic: (json['ticket_historic'] as List)
        ?.map((e) => e == null
            ? null
            : TicketHistoricModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    ticket_object: (json['ticket_object'] as List)
        ?.map((e) => e == null
            ? null
            : TicketObjectModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    ticket_service_additional: (json['ticket_service_additional'] as List)
        ?.map((e) => e == null
            ? null
            : TicketServiceAdditionalModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    ticket_historic_photo: (json['ticket_historic_photo'] as List)
        ?.map((e) => e == null
            ? null
            : TicketHistoricPhotoModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tickets_vehicle: (json['tickets_vehicle'] as List)
        ?.map((e) =>
            e == null ? null : Vehicle.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    tickets_customers: (json['tickets_customers'] as List)
        ?.map((e) =>
            e == null ? null : Customer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TicketSincAllResponseToJson(
        TicketSincAllResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'tickets': instance.tickets,
      'ticket_historic': instance.ticket_historic,
      'ticket_object': instance.ticket_object,
      'ticket_service_additional': instance.ticket_service_additional,
      'ticket_historic_photo': instance.ticket_historic_photo,
      'tickets_vehicle': instance.tickets_vehicle,
      'tickets_customers': instance.tickets_customers,
    };
