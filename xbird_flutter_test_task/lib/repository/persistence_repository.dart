import 'package:shared_preferences/shared_preferences.dart';

const _keyName = 'name';
const _keyAgeRange = 'ageRange';

class PersistenceRepository {
  saveData(String name, String ageRange) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyAgeRange, ageRange);
    print('${prefs.getString(_keyName)}, ${prefs.getString(_keyAgeRange)}');
  }
}
