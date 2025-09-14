import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

String kBaseUrlTest = '';

/// Ensures dotenv is loaded before tests run.
/// Call [loadTestDotEnv] in your test files.
Future<void> loadTestDotEnv() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/utils/.env"); // create this file with test values
  kBaseUrlTest = dotenv.env['BASE_URL'] ?? ""; 
}