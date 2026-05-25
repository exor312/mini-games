import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Provides access to environment variables loaded from the `.env` file.
///
/// All values fall back to sensible defaults so the app can run even when
/// the `.env` file is missing (e.g. during development or testing).
abstract final class EnvConfig {
  EnvConfig._();

  /// The application name as defined in the `.env` file.
  ///
  /// Falls back to `'Mini Games'` if the key is not present.
  static String get appName =>
      dotenv.env['APP_NAME'] ?? 'Mini Games';
}
