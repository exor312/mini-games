import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/unlockable_character.dart';

class CharacterModel {
  static const String _unlockedKey = 'unlocked_characters';
  static const String _activeKey = 'active_character';

  static const Map<String, IconData> _iconMap = {
    'bear': Icons.pets,
    'fox': Icons.pets,
    'dragon': Icons.whatshot,
    'bunny': Icons.cruelty_free,
    'cat': Icons.pets,
  };

  static IconData iconKeyToData(String key) {
    return _iconMap[key] ?? Icons.pets;
  }

  Future<void> saveUnlockedCharacters(List<String> characterIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_unlockedKey, characterIds);
  }

  Future<List<String>> loadUnlockedCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_unlockedKey) ?? ['bear'];
  }

  Future<void> saveActiveCharacter(String characterId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_activeKey, characterId);
  }

  Future<String> loadActiveCharacter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activeKey) ?? 'bear';
  }

  List<UnlockableCharacter> getUnlockedCharacters() {
    return allCharacters;
  }

  List<UnlockableCharacter> filterUnlocked(List<String> unlockedIds) {
    return allCharacters.where((c) => unlockedIds.contains(c.id)).toList();
  }
}
