import 'package:core/core.dart';
import 'package:base/base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_finder/core.dart';

class Setup {
  static Future initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Load environment variables
    await dotenv.load(fileName: ".env");

    if (!kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    newRouter = router;

    // Load SVG
    await loadSVG();

    // Initialize Hive
    try {
      if (!kIsWeb) {
        var path = await getTemporaryDirectory();
        Hive.init(path.path);
      }

      if (!Hive.isAdapterRegistered(1)) {
        //Theme Model
        Hive.registerAdapter(ThemeModeAdapter());

        //User Data Model
        Hive.registerAdapter(ListRestaurantModelAdapter());
        Hive.registerAdapter(RestaurantsAdapter());
      }

      mainStorage = await Hive.openBox("restaurant_finder");

      await SessionDatabase.load();
      await ThemeDatabase.load();
      await UserDataDatabase.load();
    } catch (e) {
      // Fix masalah dengan database
      await Hive.deleteBoxFromDisk('restaurant_finder');
    }
    //END Initialize Hive
  }
}
