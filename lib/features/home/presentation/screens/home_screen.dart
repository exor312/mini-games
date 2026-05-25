import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../profile/presentation/providers/progress_notifier.dart';
import '../../../profile/domain/entities/player_progress.dart';
import '../widgets/game_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String routePath = '/';
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressNotifierProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, ref, progress, cs),
            _buildXPBar(context, ref, progress, cs),
            const SizedBox(height: 16),
            Expanded(child: _buildGameGrid(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    WidgetRef ref,
    PlayerProgress progress,
    ColorScheme cs,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text('Mini Games', style: TextStyles.heading.copyWith(color: cs.primary)),
          const Spacer(),
          GestureDetector(
            onTap: () => context.go('/profile'),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                ref.read(progressNotifierProvider.notifier)
                    .getCharacterIcon(progress.activeCharacterId),
                size: 28,
                color: cs.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPBar(
    BuildContext context,
    WidgetRef ref,
    PlayerProgress progress,
    ColorScheme cs,
  ) {
    final notifier = ref.read(progressNotifierProvider.notifier);
    final currentXP = progress.totalXP - notifier.xpForCurrentLevel;
    final neededXP = notifier.xpForNextLevel - notifier.xpForCurrentLevel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Level ${progress.level}', style: TextStyles.subheading.copyWith(color: cs.onSurface)),
              Text('$currentXP / $neededXP XP', style: TextStyles.caption.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: notifier.levelProgress.clamp(0.0, 1.0),
              minHeight: 12,
              backgroundColor: cs.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.0,
        children: [
          GameTile(
            title: 'Math',
            icon: Icons.calculate,
            color: Colors.orange,
            onTap: () => context.go('/game/math'),
          ),
          GameTile(
            title: 'Spelling',
            icon: Icons.abc,
            color: Colors.green,
            onTap: () => context.go('/game/spelling'),
          ),
        ],
      ),
    );
  }
}
