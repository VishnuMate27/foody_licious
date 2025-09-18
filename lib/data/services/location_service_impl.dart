import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'location_service.dart';

class LocationServiceImpl implements LocationService {
  @override
  Future<Position> determinePosition() async {
    // 1. Check if services are enabled
    final serviceStatus = await Permission.location.serviceStatus;
    if (!serviceStatus.isEnabled) {
      throw LocationServicesDisabledFailure();
    }

    // 2. Check permission status
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

    // 3. Fetch location
    return await Geolocator.getCurrentPosition();
  }
}
