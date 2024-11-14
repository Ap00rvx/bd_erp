import 'package:bd_erp/static/theme/app_theme.dart';
import 'package:get_it/get_it.dart';
  
final locator = GetIt.instance;
void setUp() {
  locator.registerFactory(() => AppThemes());
}
