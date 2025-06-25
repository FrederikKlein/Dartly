import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final optionsServiceProvider = ChangeNotifierProvider<OptionsModel>((ref) {
  return OptionsModel();
});

class OptionsModel extends ChangeNotifier {
  final List<String> _GameMode = ["x01", "cricket"] ;
  final List<String> _X01OutMode = ["Straight", "Double", "Triple" ];
  final List<String> _X01InMode =  ["Straight", "Double", "Triple"];
  final List<String> _X01StartValue = ["301","401","501","601","701","801","901","1001"];
  String _currentGameMode = "x01"; // Default mode
  String _currentX01OutMode = "Double"; // Default out mode
  String _currentX01InMode = "Straight"; // Default in mode
  String _currentX01StartValue = "301"; // Default start value

  OptionsModel();

  // write getters for the lists above
  List<String> get gameModes => _GameMode;
  List<String> get x01OutModes => _X01OutMode;
  List<String> get x01InModes => _X01InMode;
  List<String> get x01StartValues => _X01StartValue;
  String get currentGameMode => _currentGameMode;
  String get currentX01OutMode => _currentX01OutMode;
  String get currentX01InMode => _currentX01InMode;
  String get currentX01StartValue => _currentX01StartValue;

  void setOption(String optionType, String value) {
    switch (optionType) {
      case 'gameMode':
        if (_GameMode.contains(value)) {
          _currentGameMode = value;
          notifyListeners();
        }
        break;
      case 'x01OutMode':
        if (_X01OutMode.contains(value)) {
          _currentX01OutMode = value;
          notifyListeners();
        }
        break;
      case 'x01InMode':
        if (_X01InMode.contains(value)) {
          _currentX01InMode = value;
          notifyListeners();
        }
        break;
      case 'x01StartValue':
        if (_X01StartValue.contains(value)) {
          _currentX01StartValue = value;
          notifyListeners();
        }
        break;
      default:
        throw ArgumentError('Invalid option type: $optionType');
    }
  }

  List<String> getOptions(optionType) {
    switch (optionType) {
      case 'gameMode':
        return gameModes;
      case 'x01OutMode':
        return x01OutModes;
      case 'x01InMode':
        return x01InModes;
      case 'x01StartValue':
        return x01StartValues;
      default:
        throw ArgumentError('Invalid option type: $optionType');
    }
  }

  String getCurrentOption(optionType) {
    switch (optionType) {
      case 'gameMode':
        return currentGameMode;
      case 'x01OutMode':
        return currentX01OutMode;
      case 'x01InMode':
        return currentX01InMode;
      case 'x01StartValue':
        return currentX01StartValue;
      default:
        throw ArgumentError('Invalid option type: $optionType');
    }
  }
}