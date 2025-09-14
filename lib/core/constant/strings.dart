import 'package:flutter_dotenv/flutter_dotenv.dart';

String get kBaseUrl => dotenv.env['BASE_URL'] ?? "";
String kServerClientId = dotenv.env['SERVER_CLIENT_ID'] ?? "";