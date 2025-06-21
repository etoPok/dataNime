import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesModel extends ChangeNotifier {
  static const _keyThemeMode = 'theme_mode';
  static const _keyShowSummary = 'show_summary';
  static const _keyPlatform = 'platformFilter';

  ThemeMode _themeMode = ThemeMode.system;
  bool _showSummary = true;
  String? _platformFilter;

  ThemeMode get themeMode => _themeMode;
  bool get showSummary => _showSummary;
  String? get platformFilter => _platformFilter;

  PreferencesModel() {
    _loadPreferences();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _savePreferences();
  }

  void setShowSummary(bool value) {
    _showSummary = value;
    notifyListeners();
    _savePreferences();
  }

  set platformFilter(String? platform) {
    _platformFilter = platform;
    _savePlatform(platform);
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _platformFilter = prefs.getString(_keyPlatform);
    final stored = prefs.getString(_keyThemeMode);
    if (stored != null) {
      switch (stored) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.system;
      }
      _showSummary = prefs.getBool(_keyShowSummary) ?? true;

      notifyListeners();
    }
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String value = 'system';
    if (_themeMode == ThemeMode.light) value = 'light';
    if (_themeMode == ThemeMode.dark) value = 'dark';
    await prefs.setString(_keyThemeMode, value);
    await prefs.setBool(_keyShowSummary, _showSummary);
  }

  Future<void> _savePlatform(String? platform) async {
    final prefs = await SharedPreferences.getInstance();
    if (platform == null) {
      await prefs.remove(_keyPlatform);
    } else {
      await prefs.setString(_keyPlatform, platform);
    }
  }
}
