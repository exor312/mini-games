import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/config/app_constants.dart';
import '../../data/models/character_model.dart';
import '../../data/models/player_progress_model.dart';
import '../../domain/entities/player_progress.dart';
import '../../domain/entities/unlockable_character.dart';

class ProgressNotifier extends StateNotifier<PlayerProgress> {
  ProgressNotifier({
    required this.progressModel,
    required this.characterModel,
  }) : super(const PlayerProgress());

  final PlayerProgressModel progressModel;
  final CharacterModel characterModel;

  Future<void> loadProgress() async {
    final progress = await progressModel.load();
    final activeId = await characterModel.loadActiveCharacter();
    state = progress.copyWith(activeCharacterId: activeId);
  }

  Future<void> addXP(int amount) async {
    final newXP = state.totalXP + amount;
    final newLevel = progressModel.calculateLevel(newXP);
    state = state.copyWith(totalXP: newXP, level: newLevel);
    await progressModel.save(state);
  }

  Future<void> incrementStreak() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastPlayed = state.lastPlayedDate;

    int newStreak;
    if (lastPlayed == null) {
      newStreak = 1;
    } else {
      final lastDay = DateTime(lastPlayed.year, lastPlayed.month, lastPlayed.day);
      final diff = today.difference(lastDay).inDays;
      if (diff == 0) {
        return;
      } else if (diff == 1) {
        newStreak = state.streakDays + 1;
      } else {
        newStreak = 1;
      }
    }

    state = state.copyWith(
      streakDays: newStreak,
      lastPlayedDate: now,
    );
    await progressModel.save(state);
  }

  Future<bool> selectCharacter(String characterId) async {
    final unlocked = await characterModel.loadUnlockedCharacters();
    if (!unlocked.contains(characterId)) return false;
    state = state.copyWith(activeCharacterId: characterId);
    await characterModel.saveActiveCharacter(characterId);
    await progressModel.save(state);
    return true;
  }

  Future<List<UnlockableCharacter>> getUnlockedCharacters() async {
    final unlocked = await characterModel.loadUnlockedCharacters();
    return characterModel.filterUnlocked(unlocked);
  }

  IconData getCharacterIcon(String iconKey) {
    return CharacterModel.iconKeyToData(iconKey);
  }

  int get xpForNextLevel {
    return AppConstants.xpThresholdsForLevel(state.level + 1);
  }

  int get xpForCurrentLevel {
    return AppConstants.xpThresholdsForLevel(state.level);
  }

  double get levelProgress {
    final current = xpForCurrentLevel;
    final next = xpForNextLevel;
    if (next == current) return 1.0;
    return (state.totalXP - current) / (next - current);
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in ProviderScope');
});

final progressNotifierProvider =
    StateNotifierProvider<ProgressNotifier, PlayerProgress>((ref) {
  final notifier = ProgressNotifier(
    progressModel: PlayerProgressModel(),
    characterModel: CharacterModel(),
  );
  notifier.loadProgress();
  return notifier;
});
