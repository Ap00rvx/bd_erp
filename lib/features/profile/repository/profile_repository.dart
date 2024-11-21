import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  Future<void> signOut() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove("username");
    await sp.remove("password");
    return; 
  }
}
