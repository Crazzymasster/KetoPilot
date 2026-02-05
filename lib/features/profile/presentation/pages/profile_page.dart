import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/providers/user_provider.dart';
import '../../../../core/database/models/user_model.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _targetCarbsController;
  late TextEditingController _targetProteinController;
  late TextEditingController _targetFatController;
  late TextEditingController _targetCaloriesController;
  
  String? _selectedGender;
  DateTime? _selectedDateOfBirth;
  DateTime? _ketoStartDate;
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider.notifier).currentUser;
    
    _fullNameController = TextEditingController(text: user?.fullName ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _heightController = TextEditingController(
      text: user?.heightCm?.toString() ?? '',
    );
    _weightController = TextEditingController(
      text: user?.initialWeightKg?.toString() ?? '',
    );
    _targetCarbsController = TextEditingController(
      text: user?.targetNetCarbs.toString() ?? '20',
    );
    _targetProteinController = TextEditingController(
      text: user?.targetProtein?.toString() ?? '',
    );
    _targetFatController = TextEditingController(
      text: user?.targetFat?.toString() ?? '',
    );
    _targetCaloriesController = TextEditingController(
      text: user?.targetCalories?.toString() ?? '',
    );
    
    _selectedGender = user?.gender;
    if (user?.dateOfBirth != null) {
      _selectedDateOfBirth = DateTime.tryParse(user!.dateOfBirth!);
    }
    if (user?.ketoStartDate != null) {
      _ketoStartDate = DateTime.tryParse(user!.ketoStartDate!);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _targetCarbsController.dispose();
    _targetProteinController.dispose();
    _targetFatController.dispose();
    _targetCaloriesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDateOfBirth) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDateOfBirth 
          ? (_selectedDateOfBirth ?? DateTime(1990))
          : (_ketoStartDate ?? DateTime.now()),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        if (isDateOfBirth) {
          _selectedDateOfBirth = picked;
        } else {
          _ketoStartDate = picked;
        }
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final userNotifier = ref.read(userProvider.notifier);
      final currentUser = userNotifier.currentUser;
      
      if (currentUser == null) return;

      final updatedUser = currentUser.copyWith(
        fullName: _fullNameController.text.trim().isEmpty 
            ? null 
            : _fullNameController.text.trim(),
        gender: _selectedGender,
        dateOfBirth: _selectedDateOfBirth?.toIso8601String().split('T')[0],
        heightCm: _heightController.text.isEmpty 
            ? null 
            : double.tryParse(_heightController.text),
        initialWeightKg: _weightController.text.isEmpty 
            ? null 
            : double.tryParse(_weightController.text),
        targetNetCarbs: double.tryParse(_targetCarbsController.text) ?? 20.0,
        targetProtein: _targetProteinController.text.isEmpty 
            ? null 
            : double.tryParse(_targetProteinController.text),
        targetFat: _targetFatController.text.isEmpty 
            ? null 
            : double.tryParse(_targetFatController.text),
        targetCalories: _targetCaloriesController.text.isEmpty 
            ? null 
            : double.tryParse(_targetCaloriesController.text),
        ketoStartDate: _ketoStartDate?.toIso8601String().split('T')[0],
        updatedAt: DateTime.now().toIso8601String(),
      );

      final success = await userNotifier.updateProfile(updatedUser);

      if (mounted) {
        if (success) {
          setState(() => _isEditing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update profile'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final user = userState.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No user logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => setState(() => _isEditing = false),
            ),
            IconButton(
              icon: _isSaving 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check),
              onPressed: _isSaving ? null : _saveProfile,
            ),
          ],
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Basic Information
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              enabled: _isEditing,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              enabled: false, // Email can't be changed
            ),
            const SizedBox(height: 16),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.wc),
              ),
              items: ['Male', 'Female', 'Other'].map((gender) {
                return DropdownMenuItem(value: gender, child: Text(gender));
              }).toList(),
              onChanged: _isEditing ? (value) {
                setState(() => _selectedGender = value);
              } : null,
            ),
            const SizedBox(height: 16),

            // Date of Birth
            InkWell(
              onTap: _isEditing ? () => _selectDate(context, true) : null,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                child: Text(
                  _selectedDateOfBirth != null
                      ? '${_selectedDateOfBirth!.year}-${_selectedDateOfBirth!.month.toString().padLeft(2, '0')}-${_selectedDateOfBirth!.day.toString().padLeft(2, '0')}'
                      : 'Not set',
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Physical Stats
            Text(
              'Physical Stats',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(
                      labelText: 'Height (cm)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.height),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: _isEditing,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monitor_weight),
                    ),
                    keyboardType: TextInputType.number,
                    enabled: _isEditing,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Keto Journey
            Text(
              'Keto Journey',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            InkWell(
              onTap: _isEditing ? () => _selectDate(context, false) : null,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Keto Start Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _ketoStartDate != null
                      ? '${_ketoStartDate!.year}-${_ketoStartDate!.month.toString().padLeft(2, '0')}-${_ketoStartDate!.day.toString().padLeft(2, '0')}'
                      : 'Not set',
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nutrition Targets
            Text(
              'Daily Nutrition Targets',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _targetCarbsController,
              decoration: const InputDecoration(
                labelText: 'Target Net Carbs (g)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grain),
              ),
              keyboardType: TextInputType.number,
              enabled: _isEditing,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _targetProteinController,
              decoration: const InputDecoration(
                labelText: 'Target Protein (g)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.egg),
              ),
              keyboardType: TextInputType.number,
              enabled: _isEditing,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _targetFatController,
              decoration: const InputDecoration(
                labelText: 'Target Fat (g)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.oil_barrel),
              ),
              keyboardType: TextInputType.number,
              enabled: _isEditing,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _targetCaloriesController,
              decoration: const InputDecoration(
                labelText: 'Target Calories',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_fire_department),
              ),
              keyboardType: TextInputType.number,
              enabled: _isEditing,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
