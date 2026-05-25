import 'package:equatable/equatable.dart';

class PlayerProgress extends Equatable {
  const PlayerProgress({
    this.totalXP = 0,
    this.level = 1,
    this.streakDays = 0,
    this.lastPlayedDate,
    this.activeCharacterId = 'bear',
  });

  final int totalXP;
  final int level;
  final int streakDays;
  final DateTime? lastPlayedDate;
  final String activeCharacterId;

  PlayerProgress copyWith({
    int? totalXP,
    int? level,
    int? streakDays,
    DateTime? lastPlayedDate,
    String? activeCharacterId,
    bool clearLastPlayed = false,
  }) {
    return PlayerProgress(
      totalXP: totalXP ?? this.totalXP,
      level: level ?? this.level,
      streakDays: streakDays ?? this.streakDays,
      lastPlayedDate: clearLastPlayed ? null : (lastPlayedDate ?? this.lastPlayedDate),
      activeCharacterId: activeCharacterId ?? this.activeCharacterId,
    );
  }

  @override
  List<Object?> get props => [totalXP, level, streakDays, lastPlayedDate, activeCharacterId];
}
