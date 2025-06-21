/*import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String themeKey = 'theme';
  static const String showSummaryKey = 'showSummary';
  static const String filterPlatformKey = 'filterPlatform';

  Future<void> setThemeMode(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeKey, theme);
  }

  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeKey) ?? 'light';
  }

  Future<void> setShowSummary(bool show) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(showSummaryKey, show);
  }

  Future<bool> getShowSummary() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(showSummaryKey) ?? true;
  }

  Future<void> setFilterPlatform(String platform) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(filterPlatformKey, platform);
  }

  Future<String> getFilterPlatform() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(filterPlatformKey) ?? 'Todas';
  }
}
*/
