import 'package:app2park/app/helpers/layout/button/ButtonApp2Park.dart';
import 'package:app2park/app/helpers/layout/isLoading.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/office/offices_dao.dart';
import 'package:app2park/db/dao/park/park_user_dao.dart';
import 'package:app2park/db/dao/status/status_dao.dart';
import 'package:app2park/db/dao/vehicle/vehicle_type_dao.dart';
import 'package:app2park/module/config/get_parkuser_response.dart';
import 'package:app2park/module/puser/invite_object_select.dart';
import 'package:app2park/module/puser/park_user_model.dart';
import 'package:app2park/module/puser/service/park_user_service.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/office/office_off_model.dart';
import 'package:app2park/moduleoff/park/typeVehicleOff/vehicle_type_off_model.dart';
import 'package:app2park/moduleoff/status/status_off_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(
  title: "Tutorial",
  home: ChangeEmployeePage(),
));
class ChangeEmployeePage extends StatefulWidget {
  @override
  _ChangeEmployeePageState createState() => _ChangeEmployeePageState();
}
class _ChangeEmployeePageState extends State<ChangeEmployeePage> {
  OfficeDao officeDao = OfficeDao();
  StatusDao _daostatus = StatusDao();
  SharedPref sharedPref = SharedPref();
  final _nome = new TextEditingController();
  final _email = new TextEditingController();
  final _telefone = new TextEditingController();
  List<OfficeOff> _dropdownItems = [
  ];
  List<DropdownMenuItem<OfficeOff>> _dropdownMenuItems;
  OfficeOff _selectedItem;
  StatusOff _selectedStatus;
  List<DropdownMenuItem<StatusOff>> _dropdownMenuItemsStatus;
  List<StatusOff> _dropdownItemsStatus = [
  ];

  String nome = '';
  String telefone = '';
  String email = '';

  int id_office;
  int id_status;
  InviteObjectSelect a;

  String id = '';
  String sucess = '';
  String msg = '';
  String salvo = '';
  int sta = 0;
  int car = 0;
  bool buttonenable = true;
  bool nomenable = true;
  bool emailenable = true;
  bool telenable = true;

  bool isLoading = false;

  void initState() {
    super.initState();
    loadSharedPrefs();
  }
  loadSharedPrefs () async{
    try{

      var connectivityResult = await (Connectivity().checkConnectivity());

      List<OfficeOff> listOffice = await officeDao.findAllOffices();
      for(int i = 0; i < listOffice.length; i++){
        OfficeOff officeType = listOffice[i];
        _dropdownItems.add(officeType);
      }
      InviteObjectSelect p = InviteObjectSelect.fromJson(await sharedPref.read("inviteoff"));
      List<StatusOff> listStatus = await _daostatus.findAllStatus();
      for(int i = 0; i < listStatus.length; i++){
        StatusOff statusList = listStatus[i];
        _dropdownItemsStatus.add(statusList);
      }
      setState((){

        a = p;
        nome = p.first_name;
        _nome.text = p.first_name;
        telefone = p.cell;
        _telefone.text = p.cell;
        email = p.email.toLowerCase();
        _email.text = p.email.toLowerCase();
        id_office = p.id_office - 1;
        id_status = p.id_status;

        _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
        _selectedItem = _dropdownMenuItems[id_office].value;

        // STATUS

        _dropdownMenuItemsStatus = buildDropDownMenuItemsStatus(_dropdownItemsStatus);
        _selectedStatus = _dropdownMenuItemsStatus[id_status].value;
      });

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {

        setState(() {
          nomenable = true;
          emailenable = true;
          telenable = true;
          buttonenable = true;
        });

      }else{
        setState(() {
          nomenable = false;
          emailenable = false;
          telenable = false;
          buttonenable = false;
        });
      }

    }catch(e){
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CHANGE EMPLOYEE PAGE', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }
  List<DropdownMenuItem<OfficeOff>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<OfficeOff>> items = List();
    for (OfficeOff listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.office,style: TextStyle(fontSize: 22),),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<StatusOff>> buildDropDownMenuItemsStatus(List listItems) {
    List<DropdownMenuItem<StatusOff>> items = List();
    for (StatusOff listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.status,style: TextStyle(fontSize: 22),),
          value: listItem,
        ),
      );
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Convidar Colaboradores"),
        backgroundColor: Color.fromRGBO(41, 202, 168, 3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading ? isLoadingPage() : ListView(
          children: <Widget>[
            Text(
              'Enviar convite por telefone e/ou email ?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Nome : ',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
            TextField(
              controller: _nome,
              enabled: nomenable,
              decoration: InputDecoration(
                hintText: 'nome',
                suffixIcon: Icon(Icons.contact_mail),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Telefone :',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
              ],
            ),

            TextField(
              controller: _telefone,
              enabled: telenable,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'telefone',
                suffixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Email ',style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
              ],
            ),
            TextField(
              controller: _email,
              enabled: emailenable,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'email',
                suffixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 30,),
            Text('Cargo : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: DropdownButton(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text('Status : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  child: DropdownButton(
                      value: _selectedStatus,
                      items: _dropdownMenuItemsStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      }),
                ),
              ],
            ),
            Text(
              sucess,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              salvo,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //share(context),
           buttonenable == true ? ButtonApp2Park(
              backgroundColor: Color.fromRGBO(41, 202, 168, 3),
              text: "Salvar",
              onPressed: () async {

                setState(() {
                  isLoading = true;
                });

                ParkUserDao parkUserDao = ParkUserDao();

                bool ok = await parkUserDao.updateParkUser(a.id, _selectedStatus.id, _selectedItem.id);

                ParkUser parkuser = ParkUser();
                parkuser.id = a.id.toString();
                parkuser.id_status = _selectedStatus.id.toString();
                parkuser.id_office = _selectedItem.id.toString();

                GetParkUserResponse getParkUserRes = await ParkUserService.updatePuser(parkuser);

                if(getParkUserRes.status == 'COMPLETED'){
                }
                setState(() {
                  isLoading = false;
                  sucess = 'Atualizado com sucesso!';
                });
              },
              textStyleApp2Park:
              TextStyle(color: Colors.white, fontSize: 20),
            ) : Container(child: Text('Você precisa estar conectado a internet para alterar!'),),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
}