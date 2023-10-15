import 'package:unlimit_demo/configs/app_constants.dart';

// we can define app flavor as we need
enum FlavorModes { prod }

class Flavor {
  static FlavorModes? appFlavor;

  /// provide global data as per flavor
  static dynamic get data {
    switch (appFlavor) {
      case FlavorModes.prod:
        var data = {
          'base_url': AppConstants.prodBaseUrl,
        };
        return data;
      default:
        return null;
    }
  }
}
