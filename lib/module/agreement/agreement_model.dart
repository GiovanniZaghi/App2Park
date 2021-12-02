import 'package:json_annotation/json_annotation.dart';

part 'agreement_model.g.dart';

@JsonSerializable()
class Agreements{
  String id;
  String id_agreement_app;
  String id_park;
  String id_user;
  String agreement_type;
  String date_time;
  String agreement_begin;
  String agreement_end;
  String accountable_name;
  String accountable_doc;
  String accountable_cell;
  String accountable_email;
  String send_nf;
  String doc_nf;
  String company_name;
  String company_doc;
  String company_cell;
  String company_email;
  String bank_slip_send;
  String payment_day;
  String mon;
  String tue;
  String wed;
  String thur;
  String fri;
  String sat;
  String sun;
  String time_on;
  String time_off;
  String id_price_detached;
  String parking_spaces;
  String price;
  String plates;
  String comment;
  String status_payment;
  String until_payment;

  Agreements({
      this.id,
      this.id_agreement_app,
      this.id_park,
      this.id_user,
      this.agreement_type,
      this.date_time,
      this.agreement_begin,
      this.agreement_end,
      this.accountable_name,
      this.accountable_doc,
      this.accountable_cell,
      this.accountable_email,
      this.send_nf,
      this.doc_nf,
      this.company_name,
      this.company_doc,
      this.company_cell,
      this.company_email,
      this.bank_slip_send,
      this.payment_day,
      this.mon,
      this.tue,
      this.wed,
      this.thur,
      this.fri,
      this.sat,
      this.sun,
      this.time_on,
      this.time_off,
      this.id_price_detached,
      this.parking_spaces,
      this.price,
      this.plates,
      this.comment,
      this.status_payment,
      this.until_payment});


  @override
  String toString() {
    return 'Agreements{id: $id, id_agreement_app: $id_agreement_app, id_park: $id_park, id_user: $id_user, agreement_type: $agreement_type, date_time: $date_time, agreement_begin: $agreement_begin, agreement_end: $agreement_end, accountable_name: $accountable_name, accountable_doc: $accountable_doc, accountable_cell: $accountable_cell, accountable_email: $accountable_email, send_nf: $send_nf, doc_nf: $doc_nf, company_name: $company_name, company_doc: $company_doc, company_cell: $company_cell, company_email: $company_email, bank_slip_send: $bank_slip_send, payment_day: $payment_day, mon: $mon, tue: $tue, wed: $wed, thur: $thur, fri: $fri, sat: $sat, sun: $sun, time_on: $time_on, time_off: $time_off, id_price_detached: $id_price_detached, parking_spaces: $parking_spaces, price: $price, plates: $plates, comment: $comment, status_payment: $status_payment, until_payment: $until_payment}';
  }

  factory Agreements.fromJson(Map<String, dynamic> json) => _$AgreementsFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementsToJson(this);
}