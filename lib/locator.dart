import 'package:bd_erp/features/authentication/repository/auth_rpository.dart';
import 'package:bd_erp/features/home/repository/home_repository.dart';
import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
  
final locator = GetIt.instance;
void setUp() {
  locator.registerFactory(() => AppThemes());
  locator.registerSingleton<AuthRepository>(AuthRepository());
  locator.registerSingleton<HomeRepository>(HomeRepository());
}
