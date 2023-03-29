import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*
ColorScheme lightScheme = ColorScheme(
  brightness: brightness, 
  primary: Color(0xFF32CD32), 
  onPrimary: Colors.black, //COLORE ICONE E SCRITTE NAVBAR E APPBAR
  secondary: secondary, 
  onSecondary: onSecondary, 
  error: Colors.red[400], 
  onError: onError, 
  background: Colors.grey[200], 
  onBackground: Colors.black, 
  surface: surface, 
  onSurface: onSurface
);

//colori da inserire 


ColorScheme darkScheme = ColorScheme(
  brightness: brightness, 
  primary: Color(0xFF028A0F), 
  onPrimary: onPrimary, 
  secondary: secondary, 
  onSecondary: onSecondary, 
  error: error, 
  onError: onError, 
  background: Colors.grey[900]!, 
  onBackground: onBackground, 
  surface: surface, 
  onSurface: onSurface
);
*/
Text customText(String label, double fontSize, Color color, FontWeight fontWeight){
  return Text(
    label,
    style: TextStyle(
      fontSize: fontSize,
      color:  color,
      fontWeight: fontWeight,
    ),
  );
}

class StorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    //final boolValue = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
      //boolValue.setBool(key,switchValue);
    } else {
      print("Invalid Type");
    }
  }

  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

class ThemeNotifier with ChangeNotifier{

  ColorScheme? getTheme() => _themeData;
  ColorScheme? _themeData;


  final lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary:  Color(0xFF4CE346),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF75FF68),
    onPrimaryContainer: Color(0xFF002201),
    secondary: Color(0xFF53634E),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD6E8CD),
    onSecondaryContainer: Color(0xFF111F0F),
    tertiary: Color(0xFF386569),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBCEBEF),
    onTertiaryContainer: Color(0xFF002022),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFDF6),
    onBackground: Color(0xFF1A1C19),
    surface: Color(0xFFFCFDF6),
    onSurface: Color(0xFF1A1C19),
    surfaceVariant: Color(0xFFDFE4D8),
    onSurfaceVariant: Color(0xFF42493F),
    outline: Color(0xFF73796E),
    onInverseSurface: Color(0xFFF1F1EB),
    inverseSurface: Colors.black, //Color(0xFF2F312D)
    inversePrimary: Color(0xFF4CE346),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006E0A),
    outlineVariant: Color(0xFFC2C8BC),
    scrim: Color(0xFF000000),
  );

  final darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary:Color(0xFF006E0A),
    onPrimary: Color(0xFF003A03),
    primaryContainer: Color(0xFF005306),
    onPrimaryContainer: Color(0xFF75FF68),
    secondary: Color(0xFFBBCCB2),
    onSecondary: Color(0xFF263422),
    secondaryContainer: Color(0xFF3C4B37),
    onSecondaryContainer: Color(0xFFD6E8CD),
    tertiary: Color(0xFFA0CFD3),
    onTertiary: Color(0xFF00363A),
    tertiaryContainer: Color(0xFF1E4D51),
    onTertiaryContainer: Color(0xFFBCEBEF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C19),
    onBackground: Color(0xFFE2E3DD),
    surface: Color(0xFF1A1C19),
    onSurface: Color(0xFFE2E3DD),
    surfaceVariant: Color(0xFF42493F),
    onSurfaceVariant: Color(0xFFC2C8BC),
    outline: Color(0xFF8C9387),
    onInverseSurface: Color(0xFF1A1C19),
    inverseSurface: Color(0xFFE2E3DD),
    inversePrimary: Color(0xFF006E0A),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4CE346),
    outlineVariant: Color(0xFF42493F),
    scrim: Color(0xFF000000),
  );

  ThemeNotifier() {
  StorageManager.readData('themeMode').then((value){
   // print('value read from storage: ' + value.toString());
    var themeMode = value ?? 'light';
    if (themeMode == 'light') {
      _themeData = lightColorScheme;
    } else {
      //print('setting dark theme');
      _themeData = darkColorScheme;
    }
    notifyListeners();
  });
}

  void setDarkMode() async {
    _themeData = darkColorScheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }


  void setLightMode() async {
    _themeData = lightColorScheme;
    //_isLight = true;
    StorageManager.saveData('themeMode', 'light');
    //StorageManager.saveSwitch('themeMode', _isLight!);
    notifyListeners();
  }
}