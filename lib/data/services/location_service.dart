import 'package:foody_licious/core/error/failures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class LocationService {
  Future<Position> determinePosition();
}

class LocationServiceImpl implements LocationService {
  @override
  Future<Position> determinePosition() async {
    final serviceStatus = await Permission.location.serviceStatus;
    if (!serviceStatus.isEnabled) {
      throw LocationServicesDisabledFailure();
    }

    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isDenied) {
        throw LocationPermissionDeniedFailure();
      }
    }

    if (status.isPermanentlyDenied) {
      throw LocationPermissionPermanentlyDeniedFailure();
    }

    return await Geolocator.getCurrentPosition();
  }
}
