
import 'package:app2park/db/dao/agreement/agreement_dao.dart';
import 'package:app2park/db/dao/cart/cart_dao.dart';
import 'package:app2park/db/dao/cart/cart_item_dao.dart';
import 'package:app2park/db/dao/cashier/cashs_dao.dart';
import 'package:app2park/db/dao/cashier/movement/cash_movement_dao.dart';
import 'package:app2park/db/dao/cashier/type/cash_type_movement_dao.dart';
import 'package:app2park/db/dao/customers_dao.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/nota_fiscal_assinatura/nota_fiscal_assinatura_dao.dart';
import 'package:app2park/db/dao/objects_dao.dart';
import 'package:app2park/db/dao/park_service_additional_dao.dart';
import 'package:app2park/db/dao/payment/payment_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_base_dao.dart';
import 'package:app2park/db/dao/payment/price_detached_item_dao.dart';
import 'package:app2park/db/dao/receipt/receipt_dao.dart';
import 'package:app2park/db/dao/service_additional_dao.dart';
import 'package:app2park/db/dao/subscription/subscription_dao.dart';
import 'package:app2park/db/dao/subscription/subscription_item_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/ticket_historic_photo_dao.dart';
import 'package:app2park/db/dao/ticket_historic_status_dao.dart';
import 'package:app2park/db/dao/ticket_object_dao.dart';
import 'package:app2park/db/dao/ticket_service_additional_dao.dart';
import 'package:app2park/db/dao/tickets_dao.dart';
import 'package:app2park/db/dao/user/user_dao.dart';
import 'package:app2park/db/dao/vehicle_customer_dao.dart';
import 'package:app2park/db/dao/vehicles_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/office/offices_dao.dart';
import 'dao/park/ParkDao.dart';
import 'dao/park/park_user_dao.dart';
import 'dao/payment/payment_method_dao.dart';
import 'dao/payment/payment_method_park_dao.dart';
import 'dao/status/status_dao.dart';
import 'dao/vehicle/vehicle_type_dao.dart';
import 'dao/vehicle/vehicle_type_park_dao.dart';
import 'dao/version_dao.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'app2park.db');
  var db = await openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ObjectsDao.tableObjects);
      db.execute(ServiceAdditionalDao.tableServiceAdditional);
      db.execute(TicketObjectDao.tableTicketObject);
      db.execute(ParkServiceAdditionalDao.tableParkServiceAdditional);
      db.execute(VehiclesDao.tableVehicles);
      db.execute(CustomersDao.tableCustomers);
      db.execute(VehicleCustomerDao.tableVehicleCustomer);
      db.execute(ParkDao.tablePark);
      db.execute(VehicleTypeDao.tableVehicleType);
      db.execute(VehicleTypeParkDao.tableVehicleParkType);
      db.execute(OfficeDao.tableOffices);
      db.execute(ParkUserDao.tableParkUser);
      db.execute(StatusDao.tableStatus);
      db.execute(PaymentMethodDao.tablePaymentsMethod);
      db.execute(PaymentMethodParkDao.tablePaymentsMethodPark);
      db.execute(TicketsDao.tableTickets);
      db.execute(TicketHistoricDao.tableTickethistoric);
      db.execute(TicketHistoricPhotoDao.tableTicketHistoricPhoto);
      db.execute(TicketHistoricStatusDao.tableTicketHistoricStatus);
      db.execute(TicketServiceAdditionalDao.tableTicketServiceAdditional);
      db.execute(CashMovementDao.tableCashMovement);
      db.execute(CashTypeMovementDao.tableCashTypeMovement);
      db.execute(CashsDao.tableCashs);
      db.execute(PaymentDao.tablePayment);
      db.execute(PriceDetachedDao.tablePriceDetached);
      db.execute(PriceDetachedItemBaseDao.tablePriceDetachedItemBase);
      db.execute(PriceDetachedItemDao.tablePriceDetachedItem);
      db.execute(AgreementsDao.tableAgreements);
      db.execute(UserDao.tableUser);
      db.execute(VersionDao.tableVersion);
      db.execute(NotaFiscalAssinaturaDao.tableNotaFiscalAssinatura);
      db.execute(SubscriptionDao.tableSubscription);
      db.execute(SubscriptionItemDao.tableSubscriptionItem);
      db.execute(CartDao.tableCart);
      db.execute(CartItemDao.tableCartItem);
      db.execute(LogDao.tableLogs);
      db.execute(ReceiptDao.tableReceipt);
      db.execute('INSERT INTO customers(id, cell, email, name, doc, id_status) VALUES(1, "", "", "", "", 1);');
    },
    onUpgrade: (db, oldVersion, newVersion){
      print(oldVersion);
      print(newVersion);
      print('hre');
      if(oldVersion == 1){
        db.execute(LogDao.tableLogs);
        db.execute(ReceiptDao.tableReceipt);
        db.execute('ALTER TABLE `agreements` ADD `until_payment` TEXT NULL;');
        db.execute('UPDATE customers SET cell = "", email = "", id = 1 WHERE id_customer_app = 1;');
        db.execute('ALTER TABLE `cash_movement` ADD `id_agreement` INT NULL;');
        db.execute('ALTER TABLE `cash_movement` ADD `id_agreement_app` INT NULL;');
      }
      if(oldVersion == 2){
        db.execute('ALTER TABLE `cash_movement` ADD `id_price_detached` INT NULL;');
        db.execute('ALTER TABLE `cash_movement` ADD `id_price_detached_app` INT NULL;');
        db.execute('ALTER TABLE `tickets` ADD `id_price_detached` INT NULL;');
        db.execute('ALTER TABLE `tickets` ADD `id_price_detached_app` INT NULL;');
        db.execute('ALTER TABLE `cash_movement` ADD `value_initial` TEXT NULL;');
        db.execute('ALTER TABLE `tickets` ADD `pay_until` TEXT NULL;');
      }

  },
    version: 3,

  );
  return db;
}