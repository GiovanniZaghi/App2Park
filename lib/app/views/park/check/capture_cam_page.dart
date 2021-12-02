import 'dart:convert';
import 'dart:io';

import 'package:app2park/app/helpers/alerts/Toast.dart';
import 'package:app2park/app/helpers/prefs/SharedPref.dart';
import 'package:app2park/db/dao/log/log_dao.dart';
import 'package:app2park/db/dao/ticket_historic_dao.dart';
import 'package:app2park/db/dao/ticket_historic_photo_dao.dart';
import 'package:app2park/module/config/ticket_historic_photo_response.dart';
import 'package:app2park/module/park/Park.dart';
import 'package:app2park/module/park/ticket/ticket_historic_photo_model.dart';
import 'package:app2park/module/user/User.dart';
import 'package:app2park/moduleoff/log/log_off.dart';
import 'package:app2park/moduleoff/ticket/ticket_historic_photo_off_model.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:camera/camera.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config_dev.dart';
import '../../../../main.dart';

class CaptureCamPage extends StatefulWidget {
  @override
  _CaptureCamPageState createState() => _CaptureCamPageState();
}

class _CaptureCamPageState extends State<CaptureCamPage> with WidgetsBindingObserver {

  SharedPref sharedPref = SharedPref();
  int id_historic_status = 0;
  int id_historic = 0;
  Park park = Park();
  User userLoad = User();
  int id_ticket_app = 0;
  int id_hist_on = 0;
  int id_historic_on = 0;
  TicketHistoricPhotoDao ticketHistoricPhotoDao = TicketHistoricPhotoDao();
  String ticket_date_time_now = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString();
  String dataSave = DateFormat("yyyy-MM-dd_HH:mm:ss").format(DateTime.now()).toString();
  CameraController controller;
  String imagePath;
  int id_ticket_historic_photo = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    requestPermission();
    loadSharedPrefs();
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  loadSharedPrefs() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      int id = await sharedPref.read("id_ticket_app");
      Park ps = Park.fromJson(await sharedPref.read("park"));
      User user = User.fromJson(await sharedPref.read("user"));
      int id_histor = await sharedPref.read("id_historic_app");
      int id_hist = await sharedPref.read("id_historic_app");
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
          id_hist_on = await sharedPref.read("id_historic");
      }
      setState(() {
        id_ticket_app = id;
        id_historic_status = id_histor;
        id_historic = id_hist;
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          id_historic_on = id_hist_on;
        }
        userLoad = user;
        park = ps;
      });
    } catch (e) {
      DateTime now = DateTime.now();
      LogOff logOff = LogOff('0', null, null, e.toString(), 'IN PROD VERSION', now.toString(), 'ERRO CAPTURE CAM', 'APP');
      LogDao logDao = LogDao();
      logDao.saveLog(logOff);
    }
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Depois de tirar a foto clique aqui'),
          backgroundColor: Color.fromRGBO(41, 202, 168, 3),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(ServiceAdditionalViewRoute);
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: _cameraPreviewWidget(),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: controller != null  ? Colors.redAccent : Colors.grey,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            _captureControlRowWidget(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _cameraTogglesRowWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(String msg) async {
    Fluttertoast.cancel(); //Hides previous toast message
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT , gravity: ToastGravity.CENTER);
  }

  Future<void> requestPermission() async {

    if (await Permission.camera.request().isUndetermined || await Permission.microphone.request().isUndetermined || await Permission.storage.request().isUndetermined) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
        Permission.storage,
      ].request();

    }

    if (await Permission.camera.request().isDenied || await Permission.microphone.request().isDenied || await Permission.storage.request().isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
        Permission.storage,
      ].request();

    }

    setState(() {
    });
  }


  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null && controller.value.isInitialized
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  /// Returns a suitable camera icon for [direction].
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw ArgumentError('Unknown lens direction');
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null ? null : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {

    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) showInSnackBar('Picture saved to $filePath');
      }
    });
  }

  Future<String> takePicture() async {

    var connectivityResult =
    await (Connectivity().checkConnectivity());

    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test/img';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    TicketHistoricPhotoOffModel ticketHistoricPhotoOffModel = TicketHistoricPhotoOffModel(0,0, id_historic_status, filePath, ticket_date_time_now);

    id_ticket_historic_photo = await ticketHistoricPhotoDao.saveTicketHistoricPhoto(ticketHistoricPhotoOffModel);

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      ImageProperties properties = await FlutterNativeImage.getImageProperties(
          filePath);
      File _image;
      if (properties.width > properties.height) {
        _image = await FlutterNativeImage.compressImage(filePath, quality: 80,
            targetWidth: 600,
            targetHeight: (properties.height * 600 / properties.width).round());
      } else {
        _image = await FlutterNativeImage.compressImage(filePath, quality: 80,
            targetHeight: 400,
            targetWidth: (properties.width * 400 / properties.height).round());
      }

      var res1 = await sendForm(urlRequest+'api/tickets/newtickethistoricphoto',
          {'id_park': '${park.id}', 'id_historic_photo_app' : '$id_ticket_historic_photo', 'id_ticket_historic_app' : '$id_historic_status', 'id_ticket_historic' : '$id_historic_on', 'date_time' : '$ticket_date_time_now'}, {'file': _image});
      if(res1.statusCode == 200){

        TicketHistoricPhotoResponse ticketHistoricPhotoRes = TicketHistoricPhotoResponse.fromJson(res1.data);

        TicketHistoricPhotoModel ticketHistoricPhotoModel = ticketHistoricPhotoRes.data;


        bool ok =  await ticketHistoricPhotoDao.updateTicketHistoricPhotoIdOn(int.tryParse(ticketHistoricPhotoModel.id), int.tryParse(ticketHistoricPhotoModel.id_ticket_historic), ticketHistoricPhotoModel.photo, id_ticket_historic_photo);


        final dir = Directory(filePath);
        dir.deleteSync(recursive: true);
      }
    }

    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void logError(String code, String message) => print('Error: $code\nError Message: $message');


  Future<Response> sendForm(
      String url, Map<String, dynamic> data, Map<String, File> files) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] =
          MultipartFile(file.openRead(), await file.length(), filename: fileName);
    }
    data.addAll(fileMap);
    var formData = FormData.fromMap(data);

    Dio dio = new Dio();
    return await dio.post(url,
        data: formData, options: Options(contentType: 'multipart/form-data'));
  }

  Future<Response> sendFile(String url, File file) async {
    Dio dio = new Dio();
    var len = await file.length();
    var response = await dio.post(url,
        data: file.openRead(),
        options: Options(headers: {
          Headers.contentLengthHeader: len,
        } // set content-length
        ));
    return response;
  }
}
