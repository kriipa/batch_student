import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  static Future<bool?> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
