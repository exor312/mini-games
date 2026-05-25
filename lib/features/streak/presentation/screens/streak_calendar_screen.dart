import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/app_constants.dart';
import '../../../profile/presentation/providers/progress_notifier.dart';
import '../../../profile/domain/entities/player_progress.dart';

class StreakCalendarScreen extends ConsumerWidget {
  const StreakCalendarScreen({super.key});

  static const String routePath = '/streak';
  static const String routeName = 'streak';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(progressNotifierProvider);
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstWeekday = DateTime(now.year, now.month, 1).weekday;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Streak Calendar'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStreakHeader(context, progress, cs),
            const SizedBox(height: 16),
            _buildCalendar(context, now, daysInMonth, firstWeekday, progress, cs),
            const SizedBox(height: 24),
            _buildMilestones(context, progress, cs),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakHeader(BuildContext context, PlayerProgress progress, ColorScheme cs) {
    return Card(
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.local_fire_department, size: 48, color: Colors.orange),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${progress.streakDays}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Day${progress.streakDays == 1 ? '' : 's'} Streak',
                  style: TextStyle(color: cs.onPrimaryContainer),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar(
    BuildContext context,
    DateTime now,
    int daysInMonth,
    int firstWeekday,
    PlayerProgress progress,
    ColorScheme cs,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              DateFormat('MMMM yyyy').format(now),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildWeekdayHeaders(context, cs),
            const SizedBox(height: 8),
            _buildDaysGrid(context, now, daysInMonth, firstWeekday, progress, cs),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekdayHeaders(BuildContext context, ColorScheme cs) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((d) => SizedBox(
                width: 36,
                child: Text(
                  d,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDaysGrid(
    BuildContext context,
    DateTime now,
    int daysInMonth,
    int firstWeekday,
    PlayerProgress progress,
    ColorScheme cs,
  ) {
    final cells = <Widget>[];
    for (int i = 1; i < firstWeekday; i++) {
      cells.add(const SizedBox(width: 36, height: 36));
    }
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(now.year, now.month, day);
      final isToday = day == now.day;
      final isStreakDay = progress.lastPlayedDate != null &&
          date.isBefore(now.add(const Duration(days: 1))) &&
          day <= now.day &&
          progress.streakDays > 0 &&
          (now.day - day) < progress.streakDays;

      cells.add(
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isStreakDay ? cs.primary : (isToday ? cs.primaryContainer : null),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$day',
            style: TextStyle(
              color: isStreakDay
                  ? cs.onPrimary
                  : (isToday ? cs.onPrimaryContainer : cs.onSurface),
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    }

    final rows = <Widget>[];
    for (int i = 0; i < cells.length; i += 7) {
      final end = i + 7 > cells.length ? cells.length : i + 7;
      final rowCells = cells.sublist(i, end);
      while (rowCells.length < 7) {
        rowCells.add(const SizedBox(width: 36, height: 36));
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: rowCells,
        ),
      );
    }

    return Column(children: rows);
  }

  Widget _buildMilestones(BuildContext context, PlayerProgress progress, ColorScheme cs) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Milestones', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...AppConstants.streakMilestones.map((m) {
              final reached = progress.streakDays >= m;
              return ListTile(
                dense: true,
                leading: Icon(
                  reached ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: reached ? Colors.green : cs.onSurfaceVariant,
                ),
                title: Text('$m Day${m == 1 ? '' : 's'}'),
                trailing: reached
                    ? const Text('✓', style: TextStyle(color: Colors.green, fontSize: 20))
                    : const Text(''),
              );
            }),
          ],
        ),
      ),
    );
  }
}
