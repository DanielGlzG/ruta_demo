import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static intEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No se encontro varabile api url';
}
