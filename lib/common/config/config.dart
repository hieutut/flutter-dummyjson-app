import 'environment.dart';

abstract class Config {
  static late final Environment _env;
  static Environment get env => _env;
  static void setEnv(Environment env) => _env = env;
}