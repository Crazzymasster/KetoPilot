import 'package:flutter/material.dart';

class MacroSummaryCard extends StatelessWidget {
  final double carbsConsumed;
  final double proteinConsumed;
  final double fatConsumed;
  final double totalCaloriesConsumed;
  final double carbsLimit;
  final double proteinGoal;
  final double fatGoal;

  const MacroSummaryCard({
    super.key,
    required this.carbsConsumed,
    required this.proteinConsumed,
    required this.fatConsumed,
    required this.totalCaloriesConsumed,
    required this.carbsLimit,
    required this.proteinGoal,
    required this.fatGoal,
  });

  @override
  Widget build(BuildContext context) {
    final targetCalories = (proteinGoal * 4) + (carbsLimit * 4) + (fatGoal * 9);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Calories',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${totalCaloriesConsumed.toStringAsFixed(0)} / ${targetCalories.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (totalCaloriesConsumed / targetCalories).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroStat(
    BuildContext context,
    String label,
    double value,
    double goal,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              '${value.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              ' / ${goal.toStringAsFixed(0)}g',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13,
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.75),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
