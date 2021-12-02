import 'package:app2park/generated/i18n.dart';
import 'package:app2park/routes/ConstRoutes.dart';
import 'package:app2park/routes/Routes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

List<CameraDescription> cameras = [];

void logError(String code, String message) => print('Error: $code\nError Message: $message');
Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App2Park',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: LoginViewRoute,
      onGenerateRoute: Routes.pathRoute,
    );
  }

}
