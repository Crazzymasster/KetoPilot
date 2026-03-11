import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // CHANGED: detect web
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // CHANGED: use Riverpod

import '../../../../core/constants/app_constants.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/database/daos/symptoms_dao.dart'; // CHANGED: real DAO for mobile
import '../../../../core/database/models/symptoms_model.dart'; // CHANGED: symptoms model
import '../../../../core/providers/user_provider.dart'; // CHANGED: current user

@RoutePage()
class HealthLoggingPage extends ConsumerStatefulWidget {
  // CHANGED: StatefulWidget -> ConsumerStatefulWidget
  const HealthLoggingPage({super.key});

  @override
  ConsumerState<HealthLoggingPage> createState() => _HealthLoggingPageState();
// CHANGED: State -> ConsumerState
}

class _HealthLoggingPageState extends ConsumerState<HealthLoggingPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  final SymptomsDao? _symptomsDao = kIsWeb ? null : SymptomsDao();
  // CHANGED: do not create sqflite DAO on web

  bool _isSaving = false; // CHANGED

  DateTime _selectedDate = DateTime.now();
  int _energyLevel = 5;
  int _moodLevel = 5;
  int _sleepQuality = 5;
  int _mentalClarity = 5;
  final List<String> _symptoms = [];

  final List<String> _availableSymptoms = [
    'Headache',
    'Fatigue',
    'Dizziness',
    'Nausea',
    'Constipation',
    'Hunger',
    'Cravings',
    'Muscle cramps',
    'Bad breath',
    'Difficulty concentrating',
    'Irritability',
    'Insomnia',
    'Increased urination',
    'Dry mouth',
    'Metallic taste',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWebMode = kIsWeb; // CHANGED

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Logging'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Navigate to health history
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWebMode) ...[
                // CHANGED: warning banner for web
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.withOpacity(0.35)),
                  ),
                  child: const Text(
                    'Health log saving is not supported on web yet because this page still uses sqflite. Please use Android/iOS or add a Drift symptoms DAO for web support.',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
              _buildDateSelector(),
              const SizedBox(height: 24),
              _buildWellnessScales(),
              const SizedBox(height: 24),
              _buildSymptomsSection(),
              const SizedBox(height: 24),
              _buildNotesSection(),
              const SizedBox(height: 24),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: const Text('Date'),
        subtitle: Text(_formatDisplayDate(_selectedDate)), // CHANGED
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            setState(() {
              _selectedDate = date;
            });
          }
        },
      ),
    );
  }

  Widget _buildWellnessScales() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling today?',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildScaleSlider(
              'Energy Level',
              _energyLevel,
                  (value) => setState(() => _energyLevel = value),
              Colors.orange,
            ),
            _buildScaleSlider(
              'Mood',
              _moodLevel,
                  (value) => setState(() => _moodLevel = value),
              Colors.blue,
            ),
            _buildScaleSlider(
              'Sleep Quality',
              _sleepQuality,
                  (value) => setState(() => _sleepQuality = value),
              Colors.purple,
            ),
            _buildScaleSlider(
              'Mental Clarity',
              _mentalClarity,
                  (value) => setState(() => _mentalClarity = value),
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScaleSlider(
      String label,
      int value,
      Function(int) onChanged,
      Color color,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$value/10',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.3),
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
          ),
          child: Slider(
            value: value.toDouble(),
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (val) => onChanged(val.round()),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Poor',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            Text(
              'Excellent',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSymptomsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Symptoms',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Select any symptoms you\'re experiencing today',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableSymptoms.map((symptom) {
                final isSelected = _symptoms.contains(symptom);
                return FilterChip(
                  label: Text(symptom),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _symptoms.add(symptom);
                      } else {
                        _symptoms.remove(symptom);
                      }
                    });
                  },
                  selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                  checkmarkColor: AppTheme.primaryColor,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Notes',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Any additional observations about your health today',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText:
                'How are you feeling? Any observations about your diet, exercise, or general well-being?',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (_isSaving || kIsWeb) ? null : _saveHealthLog,
        // CHANGED: disable save on web
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: _isSaving
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : Text(kIsWeb ? 'Save Not Available on Web' : 'Save Health Log'),
      ),
    );
  }

  String _formatDisplayDate(DateTime date) {
    // CHANGED
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatDbDate(DateTime date) {
    // CHANGED
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _saveHealthLog() async {
    if (kIsWeb) {
      // CHANGED: extra safety guard
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Saving health logs on web is not supported yet. Please use Android/iOS or add a Drift symptoms DAO.',
          ),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final user = ref.read(userProvider).currentUser;

      if (user == null || user.userId == null) {
        throw Exception('No logged in user found.');
      }

      final dbDate = _formatDbDate(_selectedDate);
      final nowIso = DateTime.now().toIso8601String();

      final headacheSeverity = _symptoms.contains('Headache') ? 5 : 0;
      final fatigueSeverity = _symptoms.contains('Fatigue') ? 5 : 0;
      final nauseaSeverity = _symptoms.contains('Nausea') ? 5 : 0;
      final dizzinessSeverity = _symptoms.contains('Dizziness') ? 5 : 0;
      final brainFogSeverity =
      _symptoms.contains('Difficulty concentrating') ? 5 : 0;
      final irritabilitySeverity = _symptoms.contains('Irritability') ? 5 : 0;
      final muscleCrampsSeverity = _symptoms.contains('Muscle cramps') ? 5 : 0;
      final hungerLevel = _symptoms.contains('Hunger') ? 5 : 0;

      final mappedSymptoms = {
        'Headache',
        'Fatigue',
        'Dizziness',
        'Nausea',
        'Difficulty concentrating',
        'Irritability',
        'Muscle cramps',
        'Hunger',
      };

      final customSymptoms = _symptoms
          .where((symptom) => !mappedSymptoms.contains(symptom))
          .join(', ');

      final symptom = SymptomsModel(
        symptomId: null,
        userId: user.userId!,
        recordedAt: nowIso,
        date: dbDate,
        headacheSeverity: headacheSeverity,
        fatigueSeverity: fatigueSeverity,
        nauseaSeverity: nauseaSeverity,
        dizzinessSeverity: dizzinessSeverity,
        brainFogSeverity: brainFogSeverity,
        irritabilitySeverity: irritabilitySeverity,
        muscleCrampsSeverity: muscleCrampsSeverity,
        energyLevel: _energyLevel,
        mentalClarity: _mentalClarity,
        moodRating: _moodLevel,
        sleepQuality: _sleepQuality,
        hungerLevel: hungerLevel,
        satietyLevel: null,
        bloatingSeverity: null,
        digestionQuality: null,
        customSymptoms: customSymptoms.isEmpty ? null : customSymptoms,
        additionalNotes:
        _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        synced: 0,
        createdAt: nowIso,
      );

      final existingLogs = await _symptomsDao!.getSymptomsByDate(
        user.userId!,
        dbDate,
      );

      if (existingLogs.isNotEmpty) {
        final existing = existingLogs.first;

        final updatedSymptom = SymptomsModel(
          symptomId: existing.symptomId,
          userId: user.userId!,
          recordedAt: nowIso,
          date: dbDate,
          headacheSeverity: headacheSeverity,
          fatigueSeverity: fatigueSeverity,
          nauseaSeverity: nauseaSeverity,
          dizzinessSeverity: dizzinessSeverity,
          brainFogSeverity: brainFogSeverity,
          irritabilitySeverity: irritabilitySeverity,
          muscleCrampsSeverity: muscleCrampsSeverity,
          energyLevel: _energyLevel,
          mentalClarity: _mentalClarity,
          moodRating: _moodLevel,
          sleepQuality: _sleepQuality,
          hungerLevel: hungerLevel,
          satietyLevel: null,
          bloatingSeverity: null,
          digestionQuality: null,
          customSymptoms: customSymptoms.isEmpty ? null : customSymptoms,
          additionalNotes:
          _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          synced: existing.synced,
          createdAt: existing.createdAt,
        );

        await _symptomsDao!.updateSymptoms(updatedSymptom);
      } else {
        await _symptomsDao!.insertSymptoms(symptom);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Health log saved successfully!'),
          backgroundColor: AppTheme.successColor,
        ),
      );

      setState(() {
        _energyLevel = 5;
        _moodLevel = 5;
        _sleepQuality = 5;
        _mentalClarity = 5;
        _symptoms.clear();
        _notesController.clear();
      });

      context.router.pop(true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving health log: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}