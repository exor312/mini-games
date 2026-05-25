import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../profile/presentation/providers/progress_notifier.dart';
import '../../../profile/domain/entities/player_progress.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const String routePath = '/profile';
  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressNotifierProvider);
    final cs = Theme.of(context).colorScheme;
    final notifier = ref.read(progressNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildCharacterAvatar(notifier, progress, cs),
            const SizedBox(height: 16),
            Text(
              'Level ${progress.level}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            _buildStatsRow(context, progress, cs),
            const SizedBox(height: 24),
            _buildStreakCard(context, progress, cs),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterAvatar(
    ProgressNotifier notifier,
    PlayerProgress progress,
    ColorScheme cs,
  ) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Icon(
        notifier.getCharacterIcon(progress.activeCharacterId),
        size: 56,
        color: cs.onPrimaryContainer,
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, PlayerProgress progress, ColorScheme cs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard(context, 'Total XP', '${progress.totalXP}', Icons.star, Colors.amber, cs),
        _buildStatCard(context, 'Streak', '${progress.streakDays} days', Icons.local_fire_department, Colors.orange, cs),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color iconColor,
    ColorScheme cs,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: iconColor),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, PlayerProgress progress, ColorScheme cs) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_month, color: Colors.deepOrange),
        title: const Text('Daily Streak'),
        subtitle: Text('${progress.streakDays} day${progress.streakDays == 1 ? '' : 's'} in a row'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go('/streak'),
      ),
    );
  }
}
