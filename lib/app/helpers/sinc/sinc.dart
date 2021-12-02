import 'dart:convert';
import 'dart:io';

import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/agreement/agreement_dao.dart';
import 'package:app2park/db/dao/cashier/cashs_dao.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/db/dao/customers_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/park/ParkDao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/db/dao/payment/payment_method_park_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_dao.dart';
import 'package:app2park/db/dao/receipt/receipt_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/ticket_historic_photo_dao.dart';
import 'package:app2park/db/dao/ticket_object_dao.dart';
import 'package:app2park/db/dao/ticket_service_additional_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/user/user_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_park_dao.dart';
import 'package:app2park/db/dao/vehicles_dao.dart';
import 'package:app2park/db/dao/version_dao.dart';
import 'package:app2park/module/agreement/agreement_model.dart';
import 'package:app2park/module/cashier/cashs_model.dart';
import 'package:app2park/module/cashier/movement/cash_movement_model.dart';
import 'package:app2park/module/cashier/service/cash_service.dart';
import 'package:app2park/module/config/CustomerResponse.dart';
import 'package:app2park/module/config/ParkResponseGet.dart';
import 'package:app2park/module/config/ParkUserResponse.dart';
import 'package:app2park/module/config/TicketResponse.dart';
import 'package:app2park/module/config/VehicleResponse.dart';
import 'package:app2park/module/config/agreement_list_response.dart';
import 'package:app2park/module/config/agreement_response.dart';
import 'package:app2park/module/config/cash_movement_response.dart';
import 'package:app2park/module/config/cash_response.dart';
import 'package:app2park/module/config/get_parkuser_response.dart';
import 'package:app2park/module/config/park_list_response.dart';
import 'package:app2park/module/config/park_service_additional_response.dart';
import 'package:app2park/module/config/payment_method_park_response.dart';
import 'package:app2park/module/config/price_detached_item_response.dart';
import 'package:app2park/module/config/price_detached_response.dart';
import 'package:app2park/module/config/price_detached_sinc_response.dart';
import 'package:app2park/module/config/receipt_response.dart';
import 'package:app2park/module/config/subscription_update_response.dart';
import 'package:app2park/module/config/ticket_historic_response.dart';
import 'package:app2park/module/config/ticket_object_response.dart';
import 'package:app2park/module/config/ticket_online_response.dart';
import 'package:app2park/module/config/ticket_service_additional_response.dart';
import 'package:app2park/module/config/ticket_sinc_all_response.dart';
import 'package:app2park/module/config/ticket_sinc_response.dart';
import 'package:app2park/module/config/user_list_response.dart';
import 'package:app2park/module/config/vehicle_type_park_response.dart';
import 'package:app2park/module/config/version_response.dart';
import 'package:app2park/module/log/log.dart';
import 'package:app2park/module/log/service/log_service.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/customer/Customer.dart';
import 'package:app2park/module/park/payments/payment_method_park_model.dart';
import 'package:app2park/module/park/payments/services/payments_service.dart';
import 'package:app2park/module/park/services/ParkService.dart';
import 'package:app2park/module/park/ticket/Ticket.dart';
import 'package:app2park/module/park/ticket/send_ticket_model.dart';
import 'package:app2park/module/park/ticket/service/TicketService.dart';
import 'package:app2park/module/park/ticket/ticket_historic_model.dart';
import 'package:app2park/module/park/ticket/ticket_historic_photo_model.dart';
import 'package:app2park/module/park/ticket/ticket_object_model.dart';
import 'package:app2park/module/park/ticket/ticket_online_model.dart';
import 'package:app2park/module/park/ticket/ticket_service_additional_model.dart';
import 'package:app2park/module/park/vehicle/Vehicle.dart';
import 'package:app2park/module/park/vehicle/service/VehicleService.dart';
import 'package:app2park/module/park/vehicle/vehicle_type_park_model.dart';
import 'package:app2park/module/park_service_additional.dart';
import 'package:app2park/module/payment/price/price_detached_model.dart';
import 'package:app2park/module/payment/priceitem/price_detached_item_model.dart';
import 'package:app2park/module/payment/service/price_service.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:app2park/module/puser/service/park_user_service.dart';
import 'package:app2park/module/receipt/receipt.dart';
import 'package:app2park/module/receipt/receipt_send.dart';
import 'package:app2park/module/receipt/service/receipt_service.dart';
import 'package:app2park/module/sinc_model.dart';
import 'package:app2park/module/ticket_sinc_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/module/version.dart';
import 'package:app2park/moduleoff/agreements/agreements_off_model.dart';
import 'package:app2park/moduleoff/cashier/cashs_off_model.dart';
import 'package:app2park/moduleoff/cashier/movement/cash_movement_off_model.dart';
import 'package:app2park/moduleoff/customer/customers_off_model.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/park/ParkOff.dart';
import 'package:app2park/moduleoff/park/paymentOff/payment_method_park_off_model.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_park_off_model.dart';
import 'package:app2park/moduleoff/park_service_additional_off_model.dart';
import 'package:app2park/moduleoff/payment/price/price_detached_off_model.dart';
import 'package:app2park/moduleoff/payment/priceitem/price_detached_item_off_model.dart';
import 'package:app2park/moduleoff/puser/park_user_off_model.dart';
import 'package:app2park/moduleoff/receipt/receipt_off.dart';
import 'package:app2park/moduleoff/ticket/TicketOff.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_off_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_photo_off_model.dart';
import 'package:app2park/moduleoff/ticket/ticket_service_additional_off_model.dart';
import 'package:app2park/moduleoff/ticket/tickets_off_model.dart';
import 'package:app2park/moduleoff/ticket_object_off_model.dart';
import 'package:app2park/moduleoff/user/user_off_model.dart';
import 'package:app2park/moduleoff/vehicles/vehicles_off_model.dart';
import 'package:app2park/moduleoff/version_off.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:notification_banner/notification_banner.dart';

class Sinc {
  NeatPeriodicTaskScheduler scheduler;
  NeatPeriodicTaskScheduler scheduler2;
  NeatPeriodicTaskScheduler scheduler3;
  NeatPeriodicTaskScheduler scheduler4;
  SharedPref sharedPref = SharedPref();
  TicketsDao ticketsDao = TicketsDao();
  VehiclesDao vehiclesDao = VehiclesDao();
  CustomersDao customersDao = CustomersDao();
  TicketHistoricDao ticketHistoricDao = TicketHistoricDao();
  TicketObjectDao ticketObjectDao = TicketObjectDao();
  TicketServiceAdditionalDao ticketServiceAdditionalDao =
      TicketServiceAdditionalDao();
  TicketHistoricPhotoDao ticketHistoricPhotoDao = TicketHistoricPhotoDao();
  ParkDao parkDao = ParkDao();
  ParkUserDao parkUserDao = ParkUserDao();
  UserDao userDao = UserDao();
  PriceDetachedDao priceDetachedDao = PriceDetachedDao();
  PriceDetachedItemDao priceDetachedItemDao = PriceDetachedItemDao();
  VehicleTypeParkDao vehicleTypeParkDao = VehicleTypeParkDao();
  ParkServiceAdditionalDao parkServiceAdditionalDao =
      ParkServiceAdditionalDao();
  PaymentMethodParkDao paymentMethodParkDao = PaymentMethodParkDao();
  CashsDao cashDao = CashsDao();
  CashMovementDao cashMovementDao = CashMovementDao();
  AgreementsDao agreementsDao = AgreementsDao();
  VersionDao versionDao = VersionDao();
  CustomersDao customerDao = CustomersDao();
  ReceiptDao receiptDao = ReceiptDao();
  LogDao logDao = LogDao();

  Future<void> sincSingle([String id_park = '1', String id_user = '1']) async {
    this.scheduler = NeatPeriodicTaskScheduler(
      interval: Duration(minutes: 20),
      name: 'hello-world',
      //timeout: Duration(minutes: 1),
      timeout: Duration(minutes: 5),
      task: () async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            String datasinc = DateFormat("yyyy-MM-dd HH:mm:ss")
                .format(DateTime.now())
                .toString();

            DateTime dataParam = DateTime.now();

            dataParam = dataParam.subtract(Duration(days: 15));

            String data = DateFormat("yyyy-MM-dd").format(dataParam);

            sincPrices(id_park);
            sincVehicleTypePark(id_park);
            sincParkServiceAdditional(id_park);
            sincPaymentMethodPark(id_park);
            sincParkUser(id_park);
            sincAgreements(id_user);

          }
        } catch (e) {
          DateTime now = DateTime.now();
          LogOff logOff = LogOff('0', id_user, id_park, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO SINC', 'APP');
          LogDao logDao = LogDao();
          logDao.saveLog(logOff);
        }
      },
      minCycle: Duration(seconds: 5),
    );
  }

  Future<void> sincPeriodic(
      [String id_park = '1', String id_user = '1']) async {
    this.scheduler2 = NeatPeriodicTaskScheduler(
      interval: Duration(minutes: 15),
      name: 'hello-world',
      //timeout: Duration(minutes: 1),
      timeout: Duration(minutes: 10),
      task: () async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            /* String ultimaSinc = await sharedPref.read('last_sinc');
            if(ultimaSinc != null){

            }*/

            String datasinc = DateFormat("yyyy-MM-dd HH:mm:ss")
                .format(DateTime.now())
                .toString();
            sharedPref.save("last_sinc", datasinc);

            DateTime dataParam = DateTime.now();

            dataParam = dataParam.subtract(Duration(days: 15));

            String data = DateFormat("yyyy-MM-dd HH:mm:ss").format(dataParam);

            sincParkUser(id_park);
            sincTickets(id_user, data);
            sincCashs(id_user, data);
            sincSendTickets(id_park, id_user);
            sincSendCashs();
            sincSendPrices();
            sincSendAgreements();
            sendReceiptSinc();
            sendLogSinc();

          }
        } catch (e) {
          DateTime now = DateTime.now();
          LogOff logOff = LogOff('0', id_user, id_park, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO SINC', 'APP');
          LogDao logDao = LogDao();
          logDao.saveLog(logOff);
        }
      },
      minCycle: Duration(seconds: 5),
    );
  }

  Future<void> sincVersio() async {
    this.scheduler4 = NeatPeriodicTaskScheduler(
      interval: Duration(minutes: 15),
      name: 'hello-world',
      //timeout: Duration(minutes: 1),
      timeout: Duration(minutes: 5),
      task: () async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            /* String ultimaSinc = await sharedPref.read('last_sinc');
            if(ultimaSinc != null){
            }*/
            sincVersion();

          }
        } catch (e) {
          DateTime now = DateTime.now();
          LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO SINC', 'APP');
          LogDao logDao = LogDao();
          logDao.saveLog(logOff);
        }
      },
      minCycle: Duration(seconds: 5),
    );
  }

  Future<void> sincPeriodicPark(BuildContext context,
      [String id_user = '1']) async {
    this.scheduler3 = NeatPeriodicTaskScheduler(
      interval: Duration(minutes: 15),
      name: 'hello-world',
      //timeout: Duration(minutes: 1),
      timeout: Duration(minutes: 5),
      task: () async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi) {
            /* String ultimaSinc = await sharedPref.read('last_sinc');
            if(ultimaSinc != null){
            }*/

            String datasinc = DateFormat("yyyy-MM-dd HH:mm:ss")
                .format(DateTime.now())
                .toString();
            sharedPref.save("last_sinc", datasinc);

            sincVersion();
            sincParks(id_user, context);
            sincParkUserOut(id_user);
            subscriptionUpdatePark(id_user);

          }
        } catch (e) {
          DateTime now = DateTime.now();
          LogOff logOff = LogOff('0', id_user, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO SINC', 'APP');
          LogDao logDao = LogDao();
          logDao.saveLog(logOff);
        }
      },
      minCycle: Duration(seconds: 5),
    );
  }

  void sendLogSinc() async{
      List<LogOff> listLogOff = await logDao.getLogNoSincronized();

      for(int i = 0; i < listLogOff.length; i++){

        LogOff logOff = listLogOff[i];

        Log log = Log();
        log.id_user = logOff.id_user;
        log.id_park = logOff.id_park;
        log.error = logOff.error;
        log.version = logOff.version;
        log.created = logOff.created;
        log.screen_error = logOff.screen_error;
        log.platform = logOff.platform;

        await LogService.CriarLog(log);

        logDao.deleteLog(logOff.id_mob);
      }
  }

  void sendReceiptSinc() async{
      List<ReceiptOff> receiptOffList = await receiptDao.getReceiptNoSincronized();

      for(int i = 0; i < receiptOffList.length; i++){

        ReceiptOff receiptOff = receiptOffList[i];

        TicketsOffModel ticketOff = await ticketsDao.getTicketByIdTicketApp(receiptOff.id_ticket_app);

        if(ticketOff.id != 0){
          bool ok = await receiptDao.updateReceiptIdTicket(receiptOff.id_ticket_app, ticketOff.id);
        }

        ReceiptSend r = ReceiptSend.fromJson((jsonDecode(receiptOff.res)));

        Receipt receipt = Receipt();
        receipt.res = r.toString();
        receipt.id_ticket = ticketOff.id.toString();
        receipt.id_cupom = ticketOff.id_cupom.toString();

        await ReceiptService.CriarRecibo(receipt);

        receiptDao.deleteReceipt(receiptOff.id_receipt_app);
      }
  }

  void subscriptionUpdatePark(String id_user) async {
      SubscriptionUpdateResponse subscriptionUpdateResponse = await ParkService.subscriptionUpdate(id_user);

      if(subscriptionUpdateResponse.status == 'COMPLETED'){

        if(subscriptionUpdateResponse.data != null){

          List<Park> listParks = subscriptionUpdateResponse.data;

          for (int i = 0; i < listParks.length; i++){

            Park park =  listParks[i];

            bool ok = await parkDao.updateSubscriptionPark(park.id, park.subscription);

          }
        }
      }
  }

  void sincParkUserOut(String id_user) async {
      GetParkUserResponse getParkUserResponse =
      await ParkUserService.sincPuserOut(id_user);

      if (getParkUserResponse.status == 'COMPLETED') {
        if (getParkUserResponse.data != null) {
          List<ParkUser> listParkUser = getParkUserResponse.data;

          for (int i = 0; i < listParkUser.length; i++) {
            ParkUser parkUser = listParkUser[i];

            bool ok = await parkUserDao.verifyPuser(int.tryParse(parkUser.id));

            if (!ok) {
              int id = int.parse(parkUser.id);
              int id_park = int.parse(parkUser.id_park);
              int id_user = int.parse(parkUser.id_user);
              int id_office = int.parse(parkUser.id_office);
              int id_status = int.parse(parkUser.id_status);
              ParkUserOff puserOff = ParkUserOff(
                  id,
                  id_park,
                  id_user,
                  id_office,
                  id_status,
                  parkUser.keyval,
                  parkUser.date_added,
                  parkUser.date_edited);
              parkUserDao.saveParkUser(puserOff);
            } else {
              bool ok = await parkUserDao.SincupdateParkUser(
                  int.tryParse(parkUser.id),
                  int.tryParse(parkUser.id_status),
                  int.tryParse(parkUser.id_office));

            }
          }
        }
      }
  }

  void sincParkUser(String id_park) async {
      GetParkUserResponse getParkUserResponse =
      await ParkUserService.getallPuser(id_park);

      if (getParkUserResponse.status == 'COMPLETED') {
        if (getParkUserResponse.data != null) {
          List<ParkUser> listParkUser = getParkUserResponse.data;

          for (int i = 0; i < listParkUser.length; i++) {
            ParkUser parkUser = listParkUser[i];

            bool ok = await parkUserDao.verifyPuser(int.tryParse(parkUser.id));

            if (!ok) {
              int id = int.parse(parkUser.id);
              int id_park = int.parse(parkUser.id_park);
              int id_user = int.parse(parkUser.id_user);
              int id_office = int.parse(parkUser.id_office);
              int id_status = int.parse(parkUser.id_status);
              ParkUserOff puserOff = ParkUserOff(
                  id,
                  id_park,
                  id_user,
                  id_office,
                  id_status,
                  parkUser.keyval,
                  parkUser.date_added,
                  parkUser.date_edited);
              parkUserDao.saveParkUser(puserOff);
            } else {
              bool ok = await parkUserDao.SincupdateParkUser(
                  int.tryParse(parkUser.id),
                  int.tryParse(parkUser.id_status),
                  int.tryParse(parkUser.id_office));

            }
          }
        }
      }
  }

  void sincPaymentMethodPark(String id_park) async {
      PaymentMethodParkResponse paymentMethodParkResponse =
      await PaymentService.SincPaymentMethodPark(id_park);

      if (paymentMethodParkResponse.status == 'COMPLETED') {
        if (paymentMethodParkResponse.data != null) {
          List<PaymentMethodParkModel> listPaymentMethodPark =
              paymentMethodParkResponse.data;

          for (int i = 0; i < listPaymentMethodPark.length; i++) {
            PaymentMethodParkModel paymentMethodParkModel =
            listPaymentMethodPark[i];

            bool ok = await paymentMethodParkDao
                .verifyPaymentMethodPark(int.tryParse(paymentMethodParkModel.id));

            if (!ok) {
              int id = int.parse(paymentMethodParkModel.id);
              int id_park = int.parse(paymentMethodParkModel.id_park);
              int id_payment_method =
              int.parse(paymentMethodParkModel.id_payment_method);
              double flat_rate = double.parse(paymentMethodParkModel.flat_rate);
              double variable_rate =
              double.parse(paymentMethodParkModel.variable_rate);
              double min_value = double.parse(paymentMethodParkModel.min_value);
              int status = int.parse(paymentMethodParkModel.status);
              int sort_order = int.parse(paymentMethodParkModel.sort_order);
              PaymentMethodParkOffModel paymentMethodParkOffModel =
              PaymentMethodParkOffModel(id, id_park, id_payment_method,
                  flat_rate, variable_rate, min_value, status, sort_order);

              paymentMethodParkDao
                  .savePaymentMethodPark(paymentMethodParkOffModel);
            } else {
              bool ok = await paymentMethodParkDao.SincupdatePaymentMethodPark(
                  int.tryParse(paymentMethodParkModel.id),
                  double.parse(paymentMethodParkModel.flat_rate),
                  double.parse(paymentMethodParkModel.variable_rate),
                  double.parse(paymentMethodParkModel.min_value),
                  int.tryParse(paymentMethodParkModel.status),
                  int.tryParse(paymentMethodParkModel.sort_order));

            }
          }
        }
      }
  }

  void sincParkServiceAdditional(String id_park) async {
      ParkServiceAdditionalResponse parkServiceAdditionalResponse =
      await ParkService.sincParkServiceAdditional(id_park);

      if (parkServiceAdditionalResponse.status == 'COMPLETED') {
        if (parkServiceAdditionalResponse.data != null) {
          List<ParkServiceAdditional> parkServiceAdditionalList =
          await parkServiceAdditionalResponse.data;

          for (int i = 0; i < parkServiceAdditionalList.length; i++) {
            ParkServiceAdditional parkServiceAdditional =
            parkServiceAdditionalList[i];

            bool ok = await parkServiceAdditionalDao.verifyParkServiceAdditional(
                int.tryParse(parkServiceAdditional.id));

            if (!ok) {
              int id = int.parse(parkServiceAdditional.id);
              int id_service_additional =
              int.parse(parkServiceAdditional.id_service_additional);
              int id_park = int.parse(parkServiceAdditional.id_park);
              double price = double.parse(parkServiceAdditional.price);
              String tolerance = parkServiceAdditional.tolerance;
              int sort_order = int.parse(parkServiceAdditional.sort_order);
              int status = int.parse(parkServiceAdditional.status);
              String date_edited = parkServiceAdditional.date_edited;

              ParkServiceAdditionalOffModel parkServOff =
              ParkServiceAdditionalOffModel(id, id_service_additional,
                  id_park, price, tolerance, sort_order, status, date_edited);

              int id_servic = await parkServiceAdditionalDao
                  .saveParkServiceAdditional(parkServOff);

            } else {
              bool ok =
              await parkServiceAdditionalDao.SincupdateParkServiceAdditional(
                  int.tryParse(parkServiceAdditional.id),
                  double.parse(parkServiceAdditional.price),
                  parkServiceAdditional.tolerance,
                  int.tryParse(parkServiceAdditional.status),
                  int.tryParse(parkServiceAdditional.sort_order));

            }
          }
        }
      }
  }

  void sincVehicleTypePark(String id_park) async {
      VehicleTypeParkResponse vehicleTypeParkResponse =
      await VehicleService.sincVehicleTypePark(id_park);

      if (vehicleTypeParkResponse.status == 'COMPLETED') {
        if (vehicleTypeParkResponse.data != null) {
          List<VehicleTypeParkModel> vehicleTypeParkList =
              vehicleTypeParkResponse.data;

          for (int i = 0; i < vehicleTypeParkList.length; i++) {
            VehicleTypeParkModel vehicleTypeParkModel = vehicleTypeParkList[i];

            bool ok = await vehicleTypeParkDao.verifyVehicleTypeParkOffModelById(
                int.tryParse(vehicleTypeParkModel.id));

            if (!ok) {
              VehicleTypeParkOffModel vehicleTypeParkOffModel =
              VehicleTypeParkOffModel(
                  int.tryParse(vehicleTypeParkModel.id),
                  int.tryParse(vehicleTypeParkModel.id_vehicle_type),
                  int.tryParse(vehicleTypeParkModel.id_park),
                  int.tryParse(vehicleTypeParkModel.status),
                  int.tryParse(vehicleTypeParkModel.sort_order));

              int id_vehicle_type_park_app = await vehicleTypeParkDao
                  .saveVehicleType(vehicleTypeParkOffModel);

            } else {
              bool oks = await vehicleTypeParkDao.SincupdateVehicleTypePark(
                  int.tryParse(vehicleTypeParkModel.id),
                  int.tryParse(vehicleTypeParkModel.status),
                  int.tryParse(vehicleTypeParkModel.sort_order));

            }
          }
        }
      }
  }

  void sincPrices(String id_park) async {
      PriceDetachedResponse priceDetachedResponse =
      await PriceService.getAllPricesDetachedByPark(id_park);

      if (priceDetachedResponse.status == 'COMPLETED') {
        if (priceDetachedResponse.data != null) {
          List<PriceDetached> priceDetachedList = priceDetachedResponse.data;

          for (int i = 0; i < priceDetachedList.length; i++) {
            PriceDetached priceDetached = priceDetachedList[i];

            bool ok = await priceDetachedDao
                .verifyPriceDetached(int.tryParse(priceDetached.id));

            if (!ok) {
              PriceDetachedOff priceDetachedOff = PriceDetachedOff(
                  int.tryParse(priceDetached.id),
                  int.tryParse(priceDetached.id_park),
                  priceDetached.name,
                  priceDetached.daily_start,
                  int.tryParse(priceDetached.id_vehicle_type),
                  int.tryParse(priceDetached.id_status),
                  int.tryParse(priceDetached.cash),
                  int.tryParse(priceDetached.sort_order),
                  priceDetached.data_sinc);

              int id_price_detached_app =
              await priceDetachedDao.savePriceDetached(priceDetachedOff);


              PriceDetachedItemResponse priceDetachedItemResponse =
              await PriceService.sincGetPriceDetachedItem(priceDetached.id);

              if (priceDetachedItemResponse.status == 'COMPLETED') {
                if (priceDetachedItemResponse.data != null) {
                  List<PriceDetachedItem> priceDetachedItemList =
                  await priceDetachedItemResponse.data;

                  for (int i = 0; i < priceDetachedItemList.length; i++) {
                    PriceDetachedItem priceDetachedItem =
                    priceDetachedItemList[i];

                    bool ok = await priceDetachedItemDao
                        .verifyPriceDetachedItem(
                        int.tryParse(priceDetachedItem.id));

                    if (!ok) {
                      PriceDetachedItemOff priceDetachedItemOff =
                      PriceDetachedItemOff(
                          int.tryParse(priceDetachedItem.id),
                          int.tryParse(priceDetachedItem.id_price_detached),
                          id_price_detached_app,
                          int.tryParse(
                              priceDetachedItem.id_price_detached_item_base),
                          double.parse(priceDetachedItem.price),
                          priceDetachedItem.tolerance);

                      int id_price_detached_item_app = await priceDetachedItemDao
                          .savePriceDetachedItem(priceDetachedItemOff);

                    }
                  }
                }
              }
            } else {
              List<PriceDetachedOff> priceDetachedList = await priceDetachedDao
                  .getPriceDetachedSinc(int.tryParse(priceDetached.id));

              PriceDetachedOff priceDetachedOff = priceDetachedList.first;

              PriceDetached priceDetached2 = PriceDetached();
              priceDetached2.id = priceDetachedOff.id.toString();
              priceDetached2.id_park = priceDetachedOff.id_park.toString();
              priceDetached2.name = priceDetachedOff.name;
              priceDetached2.daily_start = priceDetachedOff.daily_start;
              priceDetached2.id_vehicle_type =
                  priceDetachedOff.id_vehicle_type.toString();
              priceDetached2.sort_order =
                  priceDetachedOff.sort_order.toString();
              priceDetached2.id_status = priceDetachedOff.id_status.toString();
              priceDetached2.cash = priceDetachedOff.cash.toString();
              priceDetached2.data_sinc = priceDetachedOff.data_sinc;

              PriceDetachedSincResponse priceDetachedSincResponse2 =
              await PriceService.sincPriceDetached(
                  priceDetached2, priceDetachedOff.id.toString());

              if (priceDetachedSincResponse2.status == 'COMPLETED') {
                if (priceDetachedSincResponse2.mode == '1') {

                  List<PriceDetached> priceDetachedList =
                      priceDetachedSincResponse2.data;

                  for (int i = 0; i < priceDetachedList.length; i++) {
                    PriceDetached priceDetached2 = priceDetachedList[i];

                    List<PriceDetachedItemOff> priceDetachedItemList =
                    await priceDetachedItemDao.sincPriceDetachedItemSend(
                        int.tryParse(priceDetached2.id));

                    for (int i = 0; i < priceDetachedItemList.length; i++) {
                      PriceDetachedItemOff priceDetachedItemOff2 =
                      priceDetachedItemList[i];

                      PriceDetachedItem priceDetachedItem2 = PriceDetachedItem();
                      priceDetachedItem2.id =
                          priceDetachedItemOff2.id.toString();
                      priceDetachedItem2.id_price_detached =
                          priceDetachedItemOff2.id_price_detached.toString();
                      priceDetachedItem2.id_price_detached_item_base =
                          priceDetachedItemOff2.id_price_detached_item_base
                              .toString();
                      priceDetachedItem2.price =
                          priceDetachedItemOff2.price.toString();
                      priceDetachedItem2.tolerance =
                          priceDetachedItemOff2.tolerance;

                      PriceDetachedItemResponse priceDetachedItemResponse2 =
                      await PriceService.updatePriceDetachedItem(
                          priceDetachedItemOff2.id.toString(),
                          priceDetachedItem2);

                    }
                  }
                } else if (priceDetachedSincResponse2.mode == '2') {
                  // Não fazer nada
                } else {
                  //Baixar Informação Servidor

                  List<PriceDetached> priceDetachedList =
                      priceDetachedSincResponse2.data;

                  for (int i = 0; i < priceDetachedList.length; i++) {
                    PriceDetached priceDetached3 = priceDetachedList[i];

                    bool ok = await priceDetachedDao.updatePriceDetachedSincro(
                        int.tryParse(priceDetached3.id),
                        priceDetached3.name,
                        priceDetached3.daily_start,
                        int.tryParse(priceDetached3.id_vehicle_type),
                        int.tryParse(priceDetached3.id_status),
                        int.tryParse(priceDetached3.cash),
                        int.tryParse(priceDetached3.sort_order),
                        priceDetached3.data_sinc);


                    PriceDetachedItemResponse priceDetachedItemResponse =
                    await PriceService.sincGetPriceDetachedItem(
                        priceDetached3.id);

                    priceDetachedItemDao.deletePriceDetachedItemSinc(
                        int.tryParse(priceDetached3.id));

                    if (priceDetachedItemResponse.status == 'COMPLETED') {
                      if (priceDetachedItemResponse.data != null) {
                        List<PriceDetachedItem> priceDetachedItemList =
                            priceDetachedItemResponse.data;

                        for (int i = 0; i < priceDetachedItemList.length; i++) {
                          PriceDetachedItem priceDetachedItem3 =
                          priceDetachedItemList[i];

                          bool ok =
                          await priceDetachedItemDao.verifyPriceDetachedItem(
                              int.tryParse(priceDetachedItem3.id));

                          if (!ok) {
                            PriceDetachedItemOff priceDetachedItemOff3 =
                            PriceDetachedItemOff(
                                int.tryParse(priceDetachedItem3.id),
                                int.tryParse(
                                    priceDetachedItem3.id_price_detached),
                                priceDetachedOff.id_price_detached_app,
                                int.tryParse(priceDetachedItem3
                                    .id_price_detached_item_base),
                                double.parse(priceDetachedItem3.price),
                                priceDetachedItem3.tolerance);

                            int id_price_detached_item_app =
                            await priceDetachedItemDao
                                .savePriceDetachedItem(priceDetachedItemOff3);

                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
  }

  void sincParks(String id_user, BuildContext context) async {
      ParkUser parkUser = ParkUser();
      parkUser.id_user = id_user;

      ParkListResponse parkListRes = await ParkService.sincParksIdUser(parkUser);

      if (parkListRes.status == 'COMPLETED') {
        if (parkListRes.data != null) {
          List<Park> listPark = parkListRes.data;

          for (int i = 0; i < listPark.length; i++) {
            Park park = listPark[i];

            bool ok = await parkDao.verifyPark(int.tryParse(park.id));

            if (!ok) {
              ParkOff parkOff = ParkOff(
                park.id,
                park.type,
                park.doc,
                park.name_park,
                park.business_name,
                park.cell,
                park.photo,
                park.postal_code,
                park.street,
                park.number,
                park.complement,
                park.neighborhood,
                park.city,
                park.state,
                park.country,
                park.vacancy,
                park.subscription,
                park.id_status,
                park.date_added,
                park.date_edited,
              );

              int id_park = await parkDao.savePark(parkOff);

            }

            ParkUser parkUser4 = ParkUser();
            parkUser4.id_park = park.id;

            UserListResponse userListResponse =
            await ParkService.sincUserParkUserByIdPark(parkUser4);

            if (userListResponse.status == 'COMPLETED') {
              if (userListResponse.data != null) {
                List<User> userList = userListResponse.data;

                for (int i = 0; i < userList.length; i++) {
                  User user = userList[i];

                  bool ok = await userDao.verifyUser(int.tryParse(user.id));

                  if (!ok) {
                    UserOff useroff = UserOff(
                        user.id,
                        user.first_name,
                        user.last_name,
                        user.cell,
                        user.doc,
                        user.email,
                        user.pass,
                        user.id_status);

                    int id_user = await userDao.saveUser(useroff);

                  }
                }
              }
            }

            GetParkUserResponse getParkUserResponse =
            await ParkUserService.getallPuser(park.id);

            if (getParkUserResponse.status == 'COMPLETD') {
              if (getParkUserResponse.data != null) {
                List<ParkUser> listParkUser = getParkUserResponse.data;

                for (int i = 0; i < listParkUser.length; i++) {
                  ParkUser parkUser = listParkUser[i];

                  bool ok =
                  await parkUserDao.verifyPuser(int.tryParse(parkUser.id));

                  if (!ok) {
                    int id = int.parse(parkUser.id);
                    int id_park = int.parse(parkUser.id_park);
                    int id_user = int.parse(parkUser.id_user);
                    int id_office = int.parse(parkUser.id_office);
                    int id_status = int.parse(parkUser.id_status);
                    ParkUserOff puserOff = ParkUserOff(
                        id,
                        id_park,
                        id_user,
                        id_office,
                        id_status,
                        parkUser.keyval,
                        parkUser.date_added,
                        parkUser.date_edited);
                    parkUserDao.saveParkUser(puserOff);
                  } else {
                    bool ok = await parkUserDao.SincupdateParkUser(
                        int.tryParse(parkUser.id),
                        int.tryParse(parkUser.id_status),
                        int.tryParse(parkUser.id_office));

                  }
                }
              }
            }
            ParkUser parkUser2 = ParkUser();
            parkUser2.id_park = park.id;
            parkUser2.id_user = id_user;

            ParkUserResponse parkUserRes =
            await ParkService.sincParkUserIdParkIdUser(parkUser2);

            if (parkUserRes.status == 'COMPLETED') {
              if (parkUserRes.data != null) {
                List<ParkUser> listParkUser = parkUserRes.data;

                for (int i = 0; i < listParkUser.length; i++) {
                  ParkUser parkU = listParkUser[i];

                  bool ok = await parkUserDao.verifyPuser(int.tryParse(parkU.id));

                  if (!ok) {
                    ParkUserOff parkUserOff = ParkUserOff(
                        int.tryParse(parkU.id),
                        int.tryParse(parkU.id_park),
                        int.tryParse(parkU.id_user),
                        int.tryParse(parkU.id_office),
                        int.tryParse(parkU.id_status),
                        parkU.keyval,
                        parkU.date_added,
                        parkU.date_edited);

                    int id_park_user =
                    await parkUserDao.saveParkUser(parkUserOff);
                  }
                }
              }
            }

            ParkUserResponse parkUserResponse = await ParkUserService.getParks(
                id_user.toString(),
                'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiMSJ9.zWu-2dZEJSic1enji5CFoeSDr8Cbpc7KkRBK1ezPKwo');
            if (parkUserResponse.status == 'COMPLETED') {
              if (parkUserResponse.data != null) {
                List<ParkUser> listParkUser = parkUserResponse.data;

                ParkDao parkDao = ParkDao();

                for (var i = 0; i < listParkUser.length; i++) {
                  ParkUser parkUser = listParkUser[i];
                  bool parkOff =
                  await parkDao.getParkById(int.parse(parkUser.id_park));
                  if (!parkOff) {

                    ParkResponseGet res = await ParkService.getPark(
                        parkUser.id_park ?? '0',
                        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZF91c2VyIjoiMSJ9.zWu-2dZEJSic1enji5CFoeSDr8Cbpc7KkRBK1ezPKwo');
                    ParkOff parkOff2 = ParkOff(
                      res.data.id,
                      res.data.type,
                      res.data.doc,
                      res.data.name_park,
                      res.data.business_name,
                      res.data.cell,
                      res.data.photo,
                      res.data.postal_code,
                      res.data.street,
                      res.data.number,
                      res.data.complement,
                      res.data.neighborhood,
                      res.data.city,
                      res.data.state,
                      res.data.country,
                      res.data.vacancy,
                      res.data.subscription,
                      res.data.id_status,
                      res.data.date_added,
                      res.data.date_edited,
                    );
                    parkDao.savePark(parkOff2);
                    ParkUserDao puserDao = ParkUserDao();
                    int id = int.parse(parkUser.id);
                    int id_park = int.parse(parkUser.id_park);
                    int id_user = int.parse(parkUser.id_user);
                    int id_office = int.parse(parkUser.id_office);
                    int id_status = int.parse(parkUser.id_status);
                    ParkUserOff puserOff = ParkUserOff(
                        id,
                        id_park,
                        id_user,
                        id_office,
                        id_status,
                        parkUser.keyval,
                        parkUser.date_added,
                        parkUser.date_edited);
                    puserDao.saveParkUser(puserOff);
                  } else {
                    ParkUserDao puserDao = ParkUserDao();
                    int id = int.parse(parkUser.id);
                    int id_park = int.parse(parkUser.id_park);
                    int id_user = int.parse(parkUser.id_user);
                    int id_office = int.parse(parkUser.id_office);
                    int id_status = int.parse(parkUser.id_status);
                    bool ok = await puserDao.verifyPuser(id);
                    if (!ok) {
                      ParkUserOff puserOff = ParkUserOff(
                          id,
                          id_park,
                          id_user,
                          id_office,
                          id_status,
                          parkUser.keyval,
                          parkUser.date_added,
                          parkUser.date_edited);
                      puserDao.saveParkUser(puserOff);
                    }
                  }

                  PaymentMethodParkResponse paymentMethodParkResponse =
                  await PaymentService.getPaymentMethodPark(parkUser.id_park);
                  List<PaymentMethodParkModel> paymentMethodParkModelList =
                      paymentMethodParkResponse.data;
                  for (int i = 0; i < paymentMethodParkModelList.length; i++) {
                    PaymentMethodParkModel paymentMethodParkModel =
                    paymentMethodParkModelList[i];
                    PaymentMethodParkDao paymentMethodParkDao =
                    new PaymentMethodParkDao();
                    int id = int.parse(paymentMethodParkModel.id);
                    int id_park = int.parse(paymentMethodParkModel.id_park);
                    int id_payment_method =
                    int.parse(paymentMethodParkModel.id_payment_method);
                    double flat_rate =
                    double.parse(paymentMethodParkModel.flat_rate);
                    double variable_rate =
                    double.parse(paymentMethodParkModel.variable_rate);
                    double min_value =
                    double.parse(paymentMethodParkModel.min_value);
                    int status = int.parse(paymentMethodParkModel.status);
                    int sort_order = int.parse(paymentMethodParkModel.sort_order);
                    bool ok =
                    await paymentMethodParkDao.verifyPaymentMethodPark(id);
                    if (!ok) {
                      PaymentMethodParkOffModel paymentMethodParkOffModel =
                      PaymentMethodParkOffModel(
                          id,
                          id_park,
                          id_payment_method,
                          flat_rate,
                          variable_rate,
                          min_value,
                          status,
                          sort_order);

                      paymentMethodParkDao
                          .savePaymentMethodPark(paymentMethodParkOffModel);
                    }
                  }

                  PriceDetachedResponse priceDetachedRes =
                  await PriceService.getAllPricesDetachedByPark(
                      parkUser.id_park);

                  if (priceDetachedRes.status == 'COMPLETED') {
                    if (priceDetachedRes.data != null) {
                      List<PriceDetached> priceDetachedList =
                          priceDetachedRes.data;
                      PriceDetachedDao priceDetachedDao = PriceDetachedDao();
                      PriceDetachedItemDao priceDetachedItemDao =
                      PriceDetachedItemDao();

                      for (int i = 0; i < priceDetachedList.length; i++) {
                        PriceDetached priceDetached = priceDetachedList[i];

                        bool ok = await priceDetachedDao
                            .verifyPriceDetached(int.tryParse(priceDetached.id));

                        if (!ok) {
                          PriceDetachedOff priceDetachedOff = PriceDetachedOff(
                              int.tryParse(priceDetached.id),
                              int.tryParse(priceDetached.id_park),
                              priceDetached.name,
                              priceDetached.daily_start,
                              int.tryParse(priceDetached.id_vehicle_type),
                              int.tryParse(priceDetached.id_status),
                              int.tryParse(priceDetached.cash),
                              int.tryParse(priceDetached.sort_order),
                              priceDetached.data_sinc);

                          int id_price_detached_app = await priceDetachedDao
                              .savePriceDetached(priceDetachedOff);


                          PriceDetached priceD = PriceDetached();
                          priceD.id_price_detached_app =
                              id_price_detached_app.toString();

                          PriceDetachedResponse priceDRes =
                          await PriceService.updatePriceDetached(
                              priceDetached.id, priceD);


                          PriceDetachedItemResponse priceDetachedItemRes =
                          await PriceService.getAllPricesDetachedByIdDetached(
                              priceDetached.id);

                          if (priceDetachedItemRes.status == 'COMPLETED') {
                            if (priceDetachedItemRes.data != null) {
                              List<PriceDetachedItem> priceDetachedItemList =
                                  priceDetachedItemRes.data;

                              for (int i = 0;
                              i < priceDetachedItemList.length;
                              i++) {
                                PriceDetachedItem priceDetachedItem =
                                priceDetachedItemList[i];

                                bool ok = await priceDetachedItemDao
                                    .verifyPriceDetachedItem(
                                    int.tryParse(priceDetachedItem.id));

                                if (!ok) {
                                  PriceDetachedItemOff priceDetachedItemOff =
                                  PriceDetachedItemOff(
                                      int.tryParse(priceDetachedItem.id),
                                      int.tryParse(priceDetachedItem
                                          .id_price_detached),
                                      id_price_detached_app,
                                      int.tryParse(priceDetachedItem
                                          .id_price_detached_item_base),
                                      double.parse(priceDetachedItem.price),
                                      priceDetachedItem.tolerance);

                                  int id_price_detached_item_off =
                                  await priceDetachedItemDao
                                      .savePriceDetachedItem(
                                      priceDetachedItemOff);


                                  PriceDetachedItem priceDI = PriceDetachedItem();
                                  priceDI.id_price_detached_item_app =
                                      id_price_detached_item_off.toString();

                                  PriceDetachedItemResponse priceDIRes =
                                  await PriceService.updatePriceDetachedItem(
                                      priceDetachedItem.id, priceDI);

                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }

                  VehicleTypeParkResponse vehicleTypeParkResponse =
                  await VehicleService.getVehicleTypePark(parkUser.id_park);
                  List<VehicleTypeParkModel> vehicleTypeParkModelList =
                      vehicleTypeParkResponse.data;
                  for (int i = 0; i < vehicleTypeParkModelList.length; i++) {
                    VehicleTypeParkModel vehicleTypeParkModel =
                    vehicleTypeParkModelList[i];
                    VehicleTypeParkDao vehicleTypeParkDao =
                    new VehicleTypeParkDao();
                    int idPark = int.parse(vehicleTypeParkModel.id);
                    bool ok = await vehicleTypeParkDao
                        .verifyVehicleTypeParkOffModelById(idPark);
                    if (!ok) {
                      int id = int.parse(vehicleTypeParkModel.id);
                      int id_vehicle_type =
                      int.parse(vehicleTypeParkModel.id_vehicle_type);
                      int id_park = int.parse(vehicleTypeParkModel.id_park);
                      int status = int.parse(vehicleTypeParkModel.status);
                      int sort_order = int.parse(vehicleTypeParkModel.sort_order);
                      VehicleTypeParkOffModel vehicleTypeParkOffModel =
                      new VehicleTypeParkOffModel(
                          id, id_vehicle_type, id_park, status, sort_order);
                      vehicleTypeParkDao.saveVehicleType(vehicleTypeParkOffModel);
                    }
                  }

                  ParkServiceAdditionalResponse parkServiceAdditionalRes =
                  await ParkService.getParkServiceAdditional(
                      parkUser.id_park);
                  List<ParkServiceAdditional> parkServiceAdditionalList =
                      parkServiceAdditionalRes.data;

                  for (int i = 0; i < parkServiceAdditionalList.length; i++) {
                    ParkServiceAdditional parkServ = parkServiceAdditionalList[i];

                    int id = int.parse(parkServ.id);
                    int id_service_additional =
                    int.parse(parkServ.id_service_additional);
                    int id_park = int.parse(parkServ.id_park);
                    double price = double.parse(parkServ.price);
                    String tolerance = parkServ.tolerance;
                    int sort_order = int.parse(parkServ.sort_order);
                    int status = int.parse(parkServ.status);
                    String date_edited = parkServ.date_edited;

                    ParkServiceAdditionalDao parkServDao =
                    ParkServiceAdditionalDao();

                    bool ok = await parkServDao.verifyParkServiceAdditional(id);

                    if (!ok) {
                      ParkServiceAdditionalOffModel parkServOff =
                      ParkServiceAdditionalOffModel(
                          id,
                          id_service_additional,
                          id_park,
                          price,
                          tolerance,
                          sort_order,
                          status,
                          date_edited);

                      int id_servic = await parkServDao
                          .saveParkServiceAdditional(parkServOff);

                    }
                  }
                }
              }
            }
          }
        }
      }
  }

  void sincCashs(String id_user, String sinc_time) async {
      SincModel sincModel = SincModel();
      sincModel.id_user = id_user;
      sincModel.sinc_time = sinc_time;

      CashResponse cashRes = await CashTypeService.cashSinc(sincModel);

      if (cashRes.status == 'COMPLETED') {
        if (cashRes.data != null) {
          List<Cashs> cashList = cashRes.data;

          for (int i = 0; i < cashList.length; i++) {
            Cashs cash = cashList[i];

            int id_cash_app = await cashDao.getsCashs(int.tryParse(cash.id));

            //bool ok = await cashDao.verifyCashs(int.tryParse(cash.id));

            if (id_cash_app == null) {
              CashsOff cashsOff = CashsOff(int.tryParse(cash.id),
                  int.tryParse(cash.id_park), int.tryParse(cash.id_user));

              id_cash_app = await cashDao.saveCash(cashsOff);

            }

            CashMovementResponse cashMovementResponse =
            await CashTypeService.getTicketInfoSinc(cash.id);

            if (cashMovementResponse.status == 'COMPLETED') {
              if (cashMovementResponse.data != null) {
                List<CashMovement> cashMovementList = cashMovementResponse.data;

                for (int i = 0; i < cashMovementList.length; i++) {
                  CashMovement cashMovement = cashMovementList[i];

                  int id_cash_movement_app = 0;

                  bool ok = await cashMovementDao
                      .verifyCashMovement(int.tryParse(cashMovement.id));

                  int id_ticket_app = await ticketsDao.getTicketappsinc(
                      cashMovement.id_ticket == null
                          ? 0
                          : int.tryParse(cashMovement.id_ticket));

                  if (!ok) {
                    CashMovementOff cashMovementOff = CashMovementOff(
                        int.tryParse(cashMovement.id),
                        int.tryParse(cashMovement.id_cash),
                        id_cash_app,
                        cashMovement.id_ticket == null
                            ? 0
                            : int.tryParse(cashMovement.id_ticket),
                        cashMovement.id_ticket == null ? 0 : id_ticket_app,
                        cashMovement.id_agreement == null ? 0 : int.tryParse(cashMovement.id_agreement),
                        cashMovement.id_agreement_app == null ? 0 : int.tryParse(cashMovement.id_agreement_app),
                        cashMovement.date_added,
                        int.tryParse(cashMovement.id_cash_type_movement),
                        cashMovement.id_payment_method == null
                            ? 0
                            : int.tryParse(cashMovement.id_payment_method),
                        0,0,
                        cashMovement.value_initial == null ? '0' : cashMovement.value_initial,
                        cashMovement.value,
                        cashMovement.comment);

                    id_cash_movement_app =
                    await cashMovementDao.saveCashMovement(cashMovementOff);
                  }
                }
              }
            }
          }
        }
      }
  }

  void sincTickets(String id_user, String sinc_time) async {
      SincModel sincModel = SincModel();
      sincModel.id_user = id_user;
      sincModel.sinc_time = sinc_time;

      TicketSincResponse ticketSincResponse =
      await TicketService.getAllTicketsOpenSinc(sincModel);

      if (ticketSincResponse.status == 'COMPLETED') {
        if (ticketSincResponse.allticketsopen != null) {
          List<TicketSincModel> ticketSincList =
              ticketSincResponse.allticketsopen;

          for (int i = 0; i < ticketSincList.length; i++) {
            TicketSincModel ticketSincModel = ticketSincList[i];

            int id_vehicle_app = 0;
            int id_ticket_app = 0;
            int id_ticket_historic_app = 0;
            int id_customer_app = 0;


            TicketSincAllResponse ticketSincAllResponse =
            await TicketService.getTicketInfoSinc(ticketSincModel.id_ticket);

            if (ticketSincAllResponse.status == 'COMPLETED') {
              if (ticketSincAllResponse.tickets_vehicle != null) {
                List<Vehicle> vehicleList = ticketSincAllResponse.tickets_vehicle;

                for (int i = 0; i < vehicleList.length; i++) {
                  Vehicle vehicle = vehicleList[i];

                  bool ok =
                  await vehiclesDao.verifyVehicles(vehicle.id == null ? 0 : int.tryParse(vehicle.id));

                  if (!ok) {
                    VehiclesOffModel vehiclesOffModel = VehiclesOffModel(
                        vehicle.id == null ? 0 : int.tryParse(vehicle.id),
                        1,
                        vehicle.maker,
                        vehicle.model,
                        vehicle.color,
                        vehicle.plate,
                        vehicle.year);

                    id_vehicle_app =
                    await vehiclesDao.saveVehicles(vehiclesOffModel);

                  } else {
                    id_vehicle_app =
                    await vehiclesDao.getVehicleByPlateSincOn(vehicle.plate);
                  }
                }
              }

              if (ticketSincAllResponse.tickets_customers != null) {
                List<Customer> customerList =
                    ticketSincAllResponse.tickets_customers;

                for (int i = 0; i < customerList.length; i++) {
                  Customer customer = customerList[i];

                  if(customer.id != null) {
                    id_customer_app =
                    await customerDao.getCustomerApp(int.tryParse(customer.id));

                    //bool ok = await customersDao.verifyCustomer(int.tryParse(customer.id));

                    if (id_customer_app == null) {
                      CustomersOffModel customersOffModel = CustomersOffModel(
                          int.tryParse(customer.id),
                          customer.cell == null ? " " : customer.cell,
                          customer.email == null ? " " : customer.email,
                          customer.name == null ? " " : customer.name,
                          customer.doc == null ? " " : customer.doc,
                          int.tryParse(customer.id_status));

                      id_customer_app =
                      await customersDao.saveCustomers(customersOffModel);

                    }
                  }
                }
              }

              if (ticketSincAllResponse.tickets != null) {
                List<Ticket> ticketList = ticketSincAllResponse.tickets;

                for (int i = 0; i < ticketList.length; i++) {
                  Ticket ticket = ticketList[i];

                  id_ticket_app =
                  await ticketsDao.getTicketApp(int.tryParse(ticket.id));

                  var id_agreement_app = null;
                  if(ticket.id_agreement != null) {
                    id_agreement_app =
                    await agreementsDao.getAgreement(int.tryParse(ticket.id_agreement));
                    //bool ok = await ticketsDao.verifyTicket(int.tryParse(ticket.id));
                  }

                  if (id_ticket_app == null) {
                    TicketsOffModel ticketsOffModel = TicketsOffModel(
                        int.tryParse(ticket.id),
                        int.tryParse(ticket.id_park),
                        int.tryParse(ticket.id_user),
                        ticket.id_vehicle == null
                            ? 0
                            : int.tryParse(ticket.id_vehicle),
                        ticket.id_vehicle_app == null ? 0 : id_vehicle_app,
                        ticket.id_customer == null
                            ? 0
                            : int.tryParse(ticket.id_customer),
                        id_customer_app == null ? 0 : id_customer_app,
                        ticket.id_agreement == null
                            ? 0
                            : int.tryParse(ticket.id_agreement),
                        ticket.id_agreement_app == null
                            ? 0
                            : id_agreement_app,
                        int.tryParse(ticket.id_cupom),
                      ticket.id_price_detached == null
                          ? 0
                          : int.tryParse(ticket.id_customer),
                      ticket.id_price_detached_app == null
                          ? 0
                          : int.tryParse(ticket.id_customer),
                        ticket.cupom_entrance_datetime,
                    ticket.pay_until == null ? '' : ticket.pay_until);




                    id_ticket_app = await ticketsDao.saveTickets(ticketsOffModel);

                  }
                }
              }

              if (ticketSincAllResponse.ticket_historic != null) {
                List<TicketHistoricModel> ticketHistoricList =
                    ticketSincAllResponse.ticket_historic;

                for (int i = 0; i < ticketHistoricList.length; i++) {
                  TicketHistoricModel ticketHistoricModel = ticketHistoricList[i];

                  bool ok = await ticketHistoricDao
                      .verifyTicketHistoric(int.tryParse(ticketHistoricModel.id));

                  if (!ok) {
                    TicketHistoricOffModel ticketHistoricOffModel =
                    TicketHistoricOffModel(
                        int.tryParse(ticketHistoricModel.id),
                        int.tryParse(ticketHistoricModel.id_ticket),
                        id_ticket_app,
                        int.tryParse(
                            ticketHistoricModel.id_ticket_historic_status),
                        int.tryParse(ticketHistoricModel.id_user),
                        ticketHistoricModel.id_service_additional == null
                            ? 0
                            : int.tryParse(
                            ticketHistoricModel.id_service_additional),
                        0,
                        ticketHistoricModel.date_time);

                    id_ticket_historic_app = await ticketHistoricDao
                        .saveTicketHistoric(ticketHistoricOffModel);

                  }
                }
              }

              if (ticketSincAllResponse.ticket_object != null) {
                List<TicketObjectModel> ticketObjectList =
                    ticketSincAllResponse.ticket_object;

                for (int i = 0; i < ticketObjectList.length; i++) {
                  TicketObjectModel ticketObjectModel = ticketObjectList[i];

                  bool ok = await ticketObjectDao
                      .verifyTicketObjects(int.tryParse(ticketObjectModel.id));

                  if (!ok) {
                    TicketObjectOffModel ticketObjectOffModel =
                    TicketObjectOffModel(
                        int.tryParse(ticketObjectModel.id),
                        int.tryParse(ticketObjectModel.id_ticket),
                        id_ticket_app,
                        int.tryParse(ticketObjectModel.id_object));

                    int id_ticket_object_app = await ticketObjectDao
                        .saveTicketObject(ticketObjectOffModel);

                  }
                }
              }

              if (ticketSincAllResponse.ticket_service_additional != null) {
                List<TicketServiceAdditionalModel> ticketServiceAdditionalList =
                    ticketSincAllResponse.ticket_service_additional;

                for (int i = 0; i < ticketServiceAdditionalList.length; i++) {
                  TicketServiceAdditionalModel ticketServiceAdditionalModel =
                  ticketServiceAdditionalList[i];

                  bool ok = await ticketServiceAdditionalDao
                      .verifyTicketServiceAdditional(
                      int.tryParse(ticketServiceAdditionalModel.id));

                  if (!ok) {
                    TicketServiceAdditionalOffModel
                    ticketServiceAdditionalOffModel =
                    TicketServiceAdditionalOffModel(
                        int.tryParse(ticketServiceAdditionalModel.id),
                        int.tryParse(ticketServiceAdditionalModel.id_ticket),
                        id_ticket_app,
                        int.tryParse(ticketServiceAdditionalModel
                            .id_park_service_additional),
                        ticketServiceAdditionalModel.name,
                        double.parse(ticketServiceAdditionalModel.price),
                        ticketServiceAdditionalModel.tolerance,
                        ticketServiceAdditionalModel.finish_estimate,
                        ticketServiceAdditionalModel.price_justification,
                        ticketServiceAdditionalModel.observation,
                        int.tryParse(ticketServiceAdditionalModel.id_status));

                    int id_ticket_service_additional_app =
                    await ticketServiceAdditionalDao
                        .saveTicketServiceAdditional(
                        ticketServiceAdditionalOffModel);

                  }
                }
              }

              if (ticketSincAllResponse.ticket_historic_photo != null) {
                List<TicketHistoricPhotoModel> ticketHistoricPhotoList =
                    ticketSincAllResponse.ticket_historic_photo;

                for (int i = 0; i < ticketHistoricPhotoList.length; i++) {
                  TicketHistoricPhotoModel ticketHistoricPhotoModel =
                  ticketHistoricPhotoList[i];

                  bool ok =
                  await ticketHistoricPhotoDao.verifyTicketHistoricPhoto(
                      int.tryParse(ticketHistoricPhotoModel.id));

                  if (!ok) {
                    TicketHistoricPhotoOffModel ticketHistoricPhotoOffModel =
                    TicketHistoricPhotoOffModel(
                        int.tryParse(ticketHistoricPhotoModel.id),
                        int.tryParse(
                            ticketHistoricPhotoModel.id_ticket_historic),
                        id_ticket_historic_app,
                        ticketHistoricPhotoModel.photo,
                        ticketHistoricPhotoModel.date_time);

                    int id_ticket_historic_photo_app =
                    await ticketHistoricPhotoDao
                        .saveTicketHistoricPhoto(ticketHistoricPhotoOffModel);
                  }
                }
              }
            }
          }
        }
      }
  }

  void sincSendTickets(String id_park, String id_user) async {
      List<TicketsOffModel> ticketOffList =
      await ticketsDao.getTicketsNoSincronized(int.parse(id_user));

      if (ticketOffList != null) {
        if (ticketOffList.length > 0) {
          for (int i = 0; i < ticketOffList.length; i++) {
            TicketsOffModel ticketsOffModel = ticketOffList[i];

            VehiclesOffModel vehiclesOffModel =
            await vehiclesDao.getVehicleById(ticketsOffModel.id_vehicle_app);
            if (vehiclesOffModel != null) {
              if (vehiclesOffModel.id == 0) {
                VehicleResponse vehicleRes =
                await VehicleService.getVehicle(vehiclesOffModel.plate);

                Vehicle vehicle = vehicleRes.data;

                bool ok = await vehiclesDao.updateVehicles(
                    int.tryParse(vehicle.id),
                    vehicle.maker,
                    vehicle.model,
                    vehicle.color,
                    vehicle.year,
                    vehiclesOffModel.id_vehicle_app);

              } else {
                VehiclesOffModel vehiclesOffModel = await vehiclesDao
                    .getVehicleById(ticketsOffModel.id_vehicle_app);

                if (ticketsOffModel.id_customer == 0) {
                  CustomersOffModel customerOffModel = await customersDao
                      .getCustomerById(ticketsOffModel.id_customer_app);

                  Customer customer = Customer();
                  customer.id_customer_app =
                      customerOffModel.id_customer_app.toString();
                  customer.cell = customerOffModel.cell;
                  customer.email = customerOffModel.email;
                  CustomerResponse customerRes =
                  await ParkService.insertCustomer(customer);

                  Customer customerResposta = await customerRes.data.first;

                  bool ok = await customersDao.updateCustomers(
                      int.parse(customerResposta.id),
                      ticketsOffModel.id_customer_app);

                }

                CustomersOffModel customerOffModel = await customersDao
                    .getCustomerById(ticketsOffModel.id_customer_app);

                Ticket ticket = Ticket();
                ticket.id_ticket_app = ticketsOffModel.id_ticket_app.toString();
                ticket.id_park = ticketsOffModel.id_park.toString();
                ticket.id_user = ticketsOffModel.id_user.toString();
                ticket.id_vehicle = vehiclesOffModel.id.toString();
                ticket.id_vehicle_app = ticketsOffModel.id_vehicle_app.toString();
                ticket.id_customer = customerOffModel.id.toString();
                ticket.id_customer_app =
                    customerOffModel.id_customer_app.toString();
                ticket.id_cupom = ticketsOffModel.id_cupom.toString();
                ticket.id_agreement = ticketsOffModel.id_agreement.toString();
                ticket.id_agreement_app = ticketsOffModel.id_agreement_app.toString();
                ticket.cupom_entrance_datetime =
                    ticketsOffModel.cupom_entrance_datetime;
                ticket.pay_until = ticketsOffModel.pay_until;

                TicketResponse ticketRes =
                await TicketService.createTicketOn(ticket);


                if (ticketRes.status == 'COMPLETED') {
                  if (ticketRes.data != null) {
                    Ticket ticketr = ticketRes.data;

                    bool ok = await ticketsDao.updateTicketsIdOnSinc(
                        int.tryParse(ticketr.id ?? 0),
                        int.tryParse(ticketr.id_vehicle),
                        int.tryParse(ticketr.id_customer),
                        ticketsOffModel.id_ticket_app);

                  }
                }

                TicketsOffModel ticketsOffModels = await ticketsDao
                    .getTicketByIdTicketApp(ticketsOffModel.id_ticket_app);

                List<TicketHistoricOffModel> ticketHistoricListOff =
                await ticketHistoricDao.getTicketHistoricByIdTicketApp(
                    ticketsOffModel.id_ticket_app);

                for (int i = 0; i < ticketHistoricListOff.length; i++) {
                  TicketHistoricOffModel ticketHistoricOffModel =
                  ticketHistoricListOff[i];

                  TicketHistoricModel ticketHistoricModel = TicketHistoricModel();
                  ticketHistoricModel.id_ticket_historic_app =
                      ticketHistoricOffModel.id_ticket_historic_app.toString();
                  ticketHistoricModel.id_ticket = ticketsOffModels.id.toString();
                  ticketHistoricModel.id_ticket_app =
                      ticketsOffModels.id_ticket_app.toString();
                  ticketHistoricModel.id_ticket_historic_status =
                      ticketHistoricOffModel.id_ticket_historic_status.toString();
                  ticketHistoricModel.id_user =
                      ticketHistoricOffModel.id_user.toString();
                  if (ticketHistoricOffModel.id_service_additional != 0) {
                    ticketHistoricModel.id_service_additional =
                        ticketHistoricOffModel.id_service_additional.toString();
                  }
                  ticketHistoricModel.date_time =
                      ticketHistoricOffModel.date_time;

                  TicketHistoricResponse ticketHistoricResponse =
                  await TicketService.createTicketHistoric(
                      ticketHistoricModel);

                  if (ticketHistoricResponse.status == 'COMPLETED') {
                    if (ticketHistoricResponse.data != null) {
                      TicketHistoricModel ticketHistoricModelr =
                          ticketHistoricResponse.data;

                      bool ok = await ticketHistoricDao.updateTicketHistoricIdOn(
                          int.tryParse(ticketHistoricModelr.id),
                          int.tryParse(ticketHistoricModelr.id_ticket),
                          ticketHistoricOffModel.id_ticket_historic_app);

                    }
                  }
                }

                List<TicketObjectOffModel> ticketObjectListOff =
                await ticketObjectDao.getTicketsObjectsNoSincronized(
                    ticketsOffModel.id_ticket_app);

                for (int i = 0; i < ticketObjectListOff.length; i++) {
                  TicketObjectOffModel ticketObjectOffModel =
                  ticketObjectListOff[i];

                  TicketObjectModel ticketObject = TicketObjectModel();
                  ticketObject.id_ticket_object_app =
                      ticketObjectOffModel.id_ticket_object_app.toString();
                  ticketObject.id_ticket = ticketsOffModels.id.toString();
                  ticketObject.id_ticket_app =
                      ticketsOffModels.id_ticket_app.toString();
                  ticketObject.id_object =
                      ticketObjectOffModel.id_object.toString();

                  TicketObjectResponse ticketObjectRes =
                  await TicketService.createTicketObject(ticketObject);

                  TicketObjectModel ticketObjectR = ticketObjectRes.data.first;

                  bool ok = await ticketObjectDao.updateTicketObjectIdOnSinc(
                      int.tryParse(ticketObjectR.id),
                      int.tryParse(ticketObjectR.id_ticket),
                      ticketObjectOffModel.id_ticket_object_app);
                }

                List<TicketServiceAdditionalOffModel>
                ticketServiceAdditionalLstOff =
                await ticketServiceAdditionalDao
                    .getAllServicesAdditionalByIdTicketAppSinc(
                    ticketsOffModels.id_ticket_app);

                for (int i = 0; i < ticketServiceAdditionalLstOff.length; i++) {
                  TicketServiceAdditionalOffModel
                  ticketServiceAdditionalOffModel =
                  ticketServiceAdditionalLstOff[i];

                  TicketServiceAdditionalModel ticketServiceAdditionalModel =
                  TicketServiceAdditionalModel();
                  ticketServiceAdditionalModel.id_ticket_service_additional_app =
                      ticketServiceAdditionalOffModel
                          .id_ticket_service_additional_app
                          .toString();
                  ticketServiceAdditionalModel.id_ticket =
                      ticketsOffModels.id.toString();
                  ticketServiceAdditionalModel.id_ticket_app =
                      ticketServiceAdditionalOffModel.id_ticket_app.toString();
                  ticketServiceAdditionalModel.id_park_service_additional =
                      ticketServiceAdditionalOffModel.id_park_service_additional
                          .toString();
                  ticketServiceAdditionalModel.name =
                      ticketServiceAdditionalOffModel.name;
                  ticketServiceAdditionalModel.price =
                      ticketServiceAdditionalOffModel.price.toString();
                  ticketServiceAdditionalModel.tolerance =
                      ticketServiceAdditionalOffModel.lack;
                  if (ticketServiceAdditionalOffModel.finish_estimate != '') {
                    ticketServiceAdditionalModel.finish_estimate =
                        ticketServiceAdditionalOffModel.finish_estimate;
                  }
                  if (ticketServiceAdditionalOffModel.price_justification != '') {
                    ticketServiceAdditionalModel.price_justification =
                        ticketServiceAdditionalOffModel.price_justification;
                  }
                  if (ticketServiceAdditionalOffModel.observation != '') {
                    ticketServiceAdditionalModel.observation =
                        ticketServiceAdditionalOffModel.observation;
                  }
                  ticketServiceAdditionalModel.id_status = '1';

                  TicketServiceAdditionalResponse ticketServiceAdditionalRes =
                  await TicketService.createTicketServiceAdditional(
                      ticketServiceAdditionalModel);

                  TicketServiceAdditionalModel ticketServiceAdditionalModelR =
                      ticketServiceAdditionalRes.data;

                  bool ok = await ticketServiceAdditionalDao
                      .updateTicketServiceAdditionalSinc(
                      int.tryParse(ticketServiceAdditionalModelR.id),
                      int.tryParse(ticketServiceAdditionalModelR.id_ticket),
                      ticketServiceAdditionalOffModel
                          .id_ticket_service_additional_app);

                }

                TicketsOffModel ticketsOffIDs = await ticketsDao
                    .getTicketByIdTicketApp(ticketsOffModel.id_ticket_app);

                SendTicketModelModel ticketsend = SendTicketModelModel();
                ticketsend.id_ticket = ticketsOffIDs.id.toString();

                TicketOnlineResponse ticketOnlineRes =
                await TicketService.SendTicket(ticketsend);

                TicketOnlineModel ticketOnlineModel = ticketOnlineRes.data;

              }
            }
          }
        }
      }
  }

  void sincSendCashs() async {
      List<CashsOff> listCashOff = await cashDao.getCashOffSinc();

      if (listCashOff.length > 0) {
        for (int i = 0; i < listCashOff.length; i++) {
          CashsOff cashOff = listCashOff[i];

          Cashs cashs = Cashs();
          cashs.id_cash_app = cashOff.id_cash_app.toString();
          cashs.id_user = cashOff.id_user.toString();
          cashs.id_park = cashOff.id_park.toString();

          CashResponse cashResponse = await CashTypeService.cash(cashs);

          Cashs cashss = cashResponse.data.first;

          bool s = await cashDao.verifyCashs(int.tryParse(cashss.id));

          if (!s) {
            bool ok = await cashDao.updateCashs(
                int.parse(cashss.id), cashOff.id_cash_app);

          }

          List<CashMovementOff> listCashMovementOff = await cashMovementDao
              .getCashMovementOffSincByIdCashApp(cashOff.id_cash_app);

          if (listCashMovementOff.length > 0) {
            for (int i = 0; i < listCashMovementOff.length; i++) {
              CashMovementOff cashMovementOff = listCashMovementOff[i];

              CashMovement cashMovement = CashMovement();
              cashMovement.id_cash = int.parse(cashss.id).toString();
              cashMovement.id_ticket = cashMovementOff.id_ticket.toString();
              cashMovement.id_ticket_app = cashMovementOff.id_ticket_app.toString();
              cashMovement.id_agreement = cashMovementOff.id_agreement.toString();
              cashMovement.id_agreement_app = cashMovementOff.id_agreement_app.toString();
              cashMovement.id_cash_movement_app =
                  cashMovementOff.id_cash_movement_app.toString();
              cashMovement.date_added = cashMovementOff.date_added;
              cashMovement.id_cash_type_movement =
                  cashMovementOff.id_cash_type_movement.toString();
              cashMovement.id_payment_method =
                  cashMovementOff.id_payment_method.toString();
              cashMovement.value_initial = cashMovementOff.value_initial;
              cashMovement.value = cashMovementOff.value.toString();
              cashMovement.comment = cashMovementOff.comment;

              CashMovementResponse cashMovementResponse =
              await CashTypeService.cashMovement(cashMovement);

              CashMovement cashMovements = cashMovementResponse.data.first;

              bool s = await cashMovementDao
                  .verifyCashMovement(int.tryParse(cashMovements.id));

              if (!s) {
                bool oks = await cashMovementDao.updateCashMovement(
                    int.parse(cashMovements.id),
                    cashMovementOff.id_cash_movement_app);

              }
            }
          }
        }
      }
  }

  void sincSendPrices() async {
      List<PriceDetachedOff> listPriceDetachedOff =
      await priceDetachedDao.getPriceDetachedSincSend();

      for (int i = 0; i < listPriceDetachedOff.length; i++) {
        PriceDetachedOff priceDetachedOff = listPriceDetachedOff[i];

        PriceDetached priceDetached = PriceDetached();
        priceDetached.id_price_detached_app =
            priceDetachedOff.id_price_detached_app.toString();
        priceDetached.name = priceDetachedOff.name;
        priceDetached.daily_start = priceDetachedOff.daily_start;
        priceDetached.id_park = priceDetachedOff.id_park.toString();
        priceDetached.id_vehicle_type =
            priceDetachedOff.id_vehicle_type.toString();
        priceDetached.id_status = priceDetachedOff.id_status.toString();
        priceDetached.sort_order = priceDetachedOff.sort_order.toString();
        priceDetached.data_sinc = priceDetachedOff.data_sinc;

        PriceDetachedResponse priceRes =
        await PriceService.insertPriceDetached(priceDetached);

        if (priceRes.status == "COMPLETED") {
          if (priceRes.data != null) {
            PriceDetached priceDetachR = priceRes.data.first;

            bool ok = await priceDetachedDao.updatePriceDetachedSincSend(
                int.tryParse(priceDetachR.id),
                priceDetachedOff.id_price_detached_app);


            bool oks = await priceDetachedDao.updatePriceDetachedItemSincSend(
                int.tryParse(priceDetachR.id),
                priceDetachedOff.id_price_detached_app);

          }
        }

        List<PriceDetachedItemOff> listPriceDetachedItemOff =
        await priceDetachedItemDao.sincPriceDetachedItemSendPriceDetachedApp(
            priceDetachedOff.id_price_detached_app);

        for (int i = 0; i < listPriceDetachedItemOff.length; i++) {
          PriceDetachedItemOff priceDetachedItemOff = listPriceDetachedItemOff[i];

          PriceDetachedItem priceDetachedItem = PriceDetachedItem();
          priceDetachedItem.id_price_detached =
              priceDetachedItemOff.id_price_detached.toString();
          priceDetachedItem.id_price_detached_item_app =
              priceDetachedItemOff.id_price_detached_item_app.toString();
          priceDetachedItem.id_price_detached_item_base =
              priceDetachedItemOff.id_price_detached_item_base.toString();
          priceDetachedItem.price = priceDetachedItemOff.price.toString();
          priceDetachedItem.tolerance = priceDetachedItemOff.tolerance;

          PriceDetachedItemResponse priceDetachedItemres =
          await PriceService.insertPriceDetachedItem(priceDetachedItem);

          if (priceDetachedItemres.status == 'COMPLETED') {
            if (priceDetachedItemres.data != null) {
              PriceDetachedItem priceDItem = priceDetachedItemres.data.first;

              bool ok = await priceDetachedItemDao.updatePriceDetachedItemSinc(
                  int.tryParse(priceDItem.id),
                  priceDetachedItemOff.id_price_detached_item_app);

            }
          }
        }
      }
  }

  void sincAgreements(String id_user) async {
      AgreementListResponse agreementListResponse =
      await ParkService.sincAgreement(id_user);

      if (agreementListResponse.status == 'COMPLETED') {
        if (agreementListResponse.data != null) {
          List<Agreements> listAgreement = agreementListResponse.data;

          for (int i = 0; i < listAgreement.length; i++) {
            Agreements agreement = listAgreement[i];

            bool ok =
            await agreementsDao.verifyAgreement(int.tryParse(agreement.id));

            if (!ok) {
              AgreementsOff agreementsOff = AgreementsOff(
                  int.tryParse(agreement.id),
                  int.tryParse(agreement.id_park),
                  int.tryParse(agreement.id_user),
                  int.tryParse(agreement.agreement_type),
                  agreement.date_time,
                  agreement.agreement_begin,
                  agreement.agreement_end,
                  agreement.accountable_name,
                  agreement.accountable_doc,
                  agreement.accountable_cell,
                  agreement.accountable_email,
                  int.tryParse(agreement.send_nf),
                  int.tryParse(agreement.doc_nf),
                  agreement.company_name == null ? " " : agreement.company_name,
                  agreement.company_doc == null ? " " : agreement.company_doc,
                  agreement.company_cell == null ? " " : agreement.company_cell,
                  agreement.company_email == null ? " " : agreement.company_email,
                  int.tryParse(agreement.bank_slip_send),
                  int.tryParse(agreement.payment_day),
                  int.tryParse(agreement.mon),
                  int.tryParse(agreement.tue),
                  int.tryParse(agreement.wed),
                  int.tryParse(agreement.thur),
                  int.tryParse(agreement.fri),
                  int.tryParse(agreement.sat),
                  int.tryParse(agreement.sun),
                  agreement.time_on,
                  agreement.time_off,
                  int.tryParse(agreement.id_price_detached),
                  int.tryParse(agreement.parking_spaces),
                  double.tryParse(agreement.price),
                  agreement.plates,
                  agreement.comment == null ? " " : agreement.comment,
                  int.tryParse(agreement.status_payment),
                  agreement.until_payment
              );

              int id_agreement_app =
              await agreementsDao.saveAgreement(agreementsOff);

            } else {
              List<AgreementsOff> listUAgreementoff =
              await agreementsDao.SincUpdateAgreementById(
                  int.tryParse(agreement.id));

              AgreementsOff agreementsUOff = listUAgreementoff.first;

              bool ok = await agreementsDao.updateAgreement(
                  int.tryParse(agreement.id_park),
                  agreementsUOff.id_agreement_app,
                  agreement.agreement_begin,
                  agreement.agreement_end,
                  agreement.accountable_name,
                  agreement.accountable_doc,
                  agreement.accountable_cell,
                  agreement.accountable_email,
                  int.tryParse(agreement.send_nf),
                  int.tryParse(agreement.doc_nf),
                  agreement.company_name == null ? " " : agreement.company_name,
                  agreement.company_doc == null ? " " : agreement.company_doc,
                  agreement.company_cell == null ? " " : agreement.company_cell,
                  agreement.company_email == null ? " " : agreement.company_email,
                  int.tryParse(agreement.bank_slip_send),
                  int.tryParse(agreement.payment_day),
                  int.tryParse(agreement.mon),
                  int.tryParse(agreement.tue),
                  int.tryParse(agreement.wed),
                  int.tryParse(agreement.thur),
                  int.tryParse(agreement.fri),
                  int.tryParse(agreement.sat),
                  int.tryParse(agreement.sun),
                  agreement.time_on,
                  agreement.time_off,
                  int.tryParse(agreement.id_price_detached),
                  int.tryParse(agreement.parking_spaces),
                  double.parse(agreement.price),
                  agreement.plates,
                  agreement.comment == null ? " " : agreement.comment,
                  int.tryParse(agreement.status_payment),
                  agreement.until_payment
              );

            }
          }
        }
      }
  }

  void sincSendAgreements() async {
      List<AgreementsOff> listAgreementOff =
      await agreementsDao.SincAgreementOff();

      for (int i = 0; i < listAgreementOff.length; i++) {
        AgreementsOff agreementsOff = listAgreementOff[i];

        Agreements agreement = Agreements();
        agreement.id_agreement_app = agreementsOff.id_agreement_app.toString();
        agreement.id_park = agreementsOff.id_park.toString();
        agreement.id_user = agreementsOff.id_user.toString();
        agreement.agreement_type = agreementsOff.agreement_type.toString();
        agreement.date_time = agreementsOff.date_time;
        agreement.agreement_begin = agreementsOff.agreement_begin;
        agreement.agreement_end = agreementsOff.agreement_end;
        agreement.accountable_name = agreementsOff.accountable_name;
        agreement.accountable_doc = agreementsOff.accountable_doc;
        agreement.accountable_cell = agreementsOff.accountable_cell;
        agreement.accountable_email = agreementsOff.accountable_email;
        agreement.send_nf = agreementsOff.send_nf.toString();
        agreement.doc_nf = agreementsOff.doc_nf.toString();
        agreement.company_name = agreementsOff.company_name;
        agreement.company_doc = agreementsOff.company_doc;
        agreement.company_cell = agreementsOff.company_cell;
        agreement.company_email = agreementsOff.company_email;
        agreement.bank_slip_send = agreementsOff.bank_slip_send.toString();
        agreement.payment_day = agreementsOff.payment_day.toString();
        agreement.mon = agreementsOff.mon.toString();
        agreement.tue = agreementsOff.tue.toString();
        agreement.wed = agreementsOff.wed.toString();
        agreement.thur = agreementsOff.thur.toString();
        agreement.fri = agreementsOff.fri.toString();
        agreement.sat = agreementsOff.sat.toString();
        agreement.sun = agreementsOff.sun.toString();
        agreement.time_on = agreementsOff.time_on;
        agreement.time_off = agreementsOff.time_off;
        agreement.id_price_detached = agreementsOff.id_price_detached.toString();
        agreement.parking_spaces = agreementsOff.parking_spaces.toString();
        agreement.price = agreementsOff.price.toString();
        agreement.plates = agreementsOff.plates;
        agreement.comment = agreementsOff.comment;
        agreement.status_payment = agreementsOff.status_payment.toString();
        agreement.until_payment = agreementsOff.until_payment;

        AgreementResponse agreementRes =
        await ParkService.saveAgreement(agreement);

        if (agreementRes.status == 'COMPLETED') {
          if (agreementRes.data != null) {
            Agreements agreements = agreementRes.data;


            bool ok = await agreementsDao.updateAgreements(
                int.parse(agreements.id), agreementsOff.id_agreement_app);

          }
        }
      }
  }

  void sincVersion() async {
      VersionResponse versionRes = await ParkService.Version();

      if (versionRes.status == 'COMPLETED') {
        if (versionRes.data != null) {
          List<Version> listVersion = versionRes.data;

          for (int i = 0; i < listVersion.length; i++) {
            Version version = listVersion[i];

            bool ok = await versionDao.verifyVersion(int.tryParse(version.id));

            if (!ok) {
              VersionOff versionOff = VersionOff(int.tryParse(version.id),
                  version.name, int.tryParse(version.id_status));

              versionDao.saveVersion(versionOff);
            } else {
              bool oks = await versionDao.updateVersion(
                  int.tryParse(version.id), int.tryParse(version.id_status));
            }
          }
        }
      }
  }

  //---------------------------------------------------------------------------------------- || ---------------------------------------------//
  void start() async {
    scheduler.start();
  }

  void start2() async {
    scheduler2.start();
  }

  void start3() async {
    scheduler3.start();
  }

  void processSignal() async {
    await ProcessSignal.sigterm.watch().first;
  }
}
