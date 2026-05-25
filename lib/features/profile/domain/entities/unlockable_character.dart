import 'package:equatable/equatable.dart';

class UnlockableCharacter extends Equatable {
  const UnlockableCharacter({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.unlockLevel,
  });

  final String id;
  final String name;
  final String iconKey;
  final int unlockLevel;

  UnlockableCharacter copyWith({
    String? id,
    String? name,
    String? iconKey,
    int? unlockLevel,
  }) {
    return UnlockableCharacter(
      id: id ?? this.id,
      name: name ?? this.name,
      iconKey: iconKey ?? this.iconKey,
      unlockLevel: unlockLevel ?? this.unlockLevel,
    );
  }

  @override
  List<Object?> get props => [id, name, iconKey, unlockLevel];
}

const List<UnlockableCharacter> allCharacters = [
  UnlockableCharacter(id: 'bear', name: 'Sunny Bear', iconKey: 'bear', unlockLevel: 1),
  UnlockableCharacter(id: 'fox', name: 'Sparkle Fox', iconKey: 'fox', unlockLevel: 3),
  UnlockableCharacter(id: 'dragon', name: 'Rainbow Dragon', iconKey: 'dragon', unlockLevel: 5),
  UnlockableCharacter(id: 'bunny', name: 'Star Bunny', iconKey: 'bunny', unlockLevel: 8),
  UnlockableCharacter(id: 'cat', name: 'Cosmic Cat', iconKey: 'cat', unlockLevel: 12),
];
