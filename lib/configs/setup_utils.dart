import 'package:flutter/material.dart';
import 'package:unlimit_demo/configs/flavor.dart';
import 'package:unlimit_demo/configs/logging_utils.dart';
import 'package:unlimit_demo/data/local/app_storage_impl.dart';
import 'package:unlimit_demo/ui/widget/app.dart';

class SetupUtils {
  SetupUtils._();

  static initializeApp(var appFlavor) async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppStorageImpl().init();
    Flavor.appFlavor = appFlavor;
    FlutterError.onError = (errorDetails) {
      // To print errors
      Logging().logger.e('Error:- ', error: errorDetails);
      FlutterError.presentError(errorDetails);
      FlutterError.dumpErrorToConsole(errorDetails, forceReport: true);
    };
    runApp(const App());
  }
}
