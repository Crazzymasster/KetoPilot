import 'package:flutter/material.dart';
import '../../../../core/database/models/food_model.dart';
import '../../../../core/database/daos/drift_food_dao.dart';

class AddFoodDialog extends StatefulWidget {
  const AddFoodDialog({super.key});

  @override
  State<AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends State<AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _proteinController = TextEditingController(text: '0');
  final _fatController = TextEditingController(text: '0');
  final _carbsController = TextEditingController(text: '0');
  final _searchController = TextEditingController();
  
  // Database DAO for food operations
  final DriftFoodDao _foodDao = DriftFoodDao();

  double _netCarbs = 0.0;
  double _calculatedCalories = 0.0;
  bool _showCustomForm = false;
  
  // Foods loaded from database
  List<FoodModel> _databaseFoods = [];
  List<FoodModel> _searchResults = [];
  bool _isLoading = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _carbsController.addListener(_updateMacros);
    _proteinController.addListener(_updateMacros);
    _fatController.addListener(_updateMacros);
    _searchController.addListener(_onSearchChanged);
    _updateMacros();
    
    // Load foods from database on init
    _loadFoodsFromDatabase();
  }
  
  /// Load initial foods from database
  Future<void> _loadFoodsFromDatabase() async {
    try {
      final foods = await _foodDao.getAllFoods(limit: 50);
      if (mounted) {
        setState(() {
          _databaseFoods = foods;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('[ADD FOOD] ❌ Error loading foods: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  
  /// Search foods in database when search text changes
  Future<void> _onSearchChanged() async {
    final query = _searchController.text.trim();
    
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }
    
    setState(() {
      _isSearching = true;
    });
    
    try {
      final results = await _foodDao.searchFoods(query, limit: 20);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      debugPrint('[ADD FOOD] ❌ Search error: $e');
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  void _updateMacros() {
    //recalculate net carbs and calories whenever macros change
    final carbs = double.tryParse(_carbsController.text) ?? 0.0;
    final protein = double.tryParse(_proteinController.text) ?? 0.0;
    final fat = double.tryParse(_fatController.text) ?? 0.0;

    final netCarbs = carbs < 0 ? 0.0 : carbs;
    final calories = (protein * 4.0) + (netCarbs * 4.0) + (fat * 9.0);
    final cal = calories < 0 ? 0.0 : calories;

    setState(() {
      _netCarbs = netCarbs;
      _calculatedCalories = cal;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _proteinController.removeListener(_updateMacros);
    _proteinController.dispose();
    _fatController.removeListener(_updateMacros);
    _fatController.dispose();
    _carbsController.removeListener(_updateMacros);
    _carbsController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _submitCustom() async {
    if (_formKey.currentState!.validate()) {
      final protein = double.tryParse(_proteinController.text) ?? 0.0;
      final fat = double.tryParse(_fatController.text) ?? 0.0;
      final carbs = double.tryParse(_carbsController.text) ?? 0.0;

      final food = FoodModel(
        foodDescription: _nameController.text.trim(),
        energyKcal: _calculatedCalories,
        totalProteinG: protein,
        totalFatG: fat,
        totalCarbohydrateG: carbs,
        dietaryFiberG: 0.0,
        source: 'user',
        isKetoFriendly: _netCarbs <= 20 ? 1 : 0,
      );

      // Save custom food to database for future use
      try {
        await _foodDao.insertFood(food);
        debugPrint('[ADD FOOD] ✅ Custom food saved to database');
      } catch (e) {
        debugPrint('[ADD FOOD] ⚠️ Could not save custom food: $e');
      }

      if (mounted) {
        Navigator.of(context).pop(food);
      }
    }
  }

  bool _isValidName(String? value) {
    if (value == null || value.trim().isEmpty) return false;
    //allow letters, numbers, spaces, commas, parentheses, hyphens and periods
    final validNameRegExp = RegExp(r'^[A-Za-z0-9\s,().\-]+$');
    return validNameRegExp.hasMatch(value.trim());
  }

  /// Get foods to display - either search results or all database foods
  List<FoodModel> get _displayFoods {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      return _searchResults;
    }
    return _databaseFoods;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenSize.width * 0.85;
    final dialogHeight = screenSize.height * 0.8;

    return Dialog(
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Food'),
            elevation: 0,
          ),
          body: SizedBox.expand(
            child: Column(
              children: [
                if (!_showCustomForm)
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search foods...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: _isLoading || _isSearching
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : _displayFoods.isEmpty
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.search_off,
                                                size: 48,
                                                color: Colors.grey.shade400,
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                _searchController.text.isNotEmpty
                                                    ? 'No foods match your search'
                                                    : 'No foods in database',
                                                style: Theme.of(context).textTheme.bodyMedium,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                'Add a custom food below',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListView.separated(
                                          itemCount: _displayFoods.length,
                                          separatorBuilder: (c, i) => const Divider(height: 1),
                                          itemBuilder: (c, i) {
                                            final f = _displayFoods[i];
                                        return ListTile(
                                          title: Text(f.foodDescription),
                                          subtitle: Row(
                                            children: [
                                              Chip(
                                                label: Text('C: ${f.totalCarbohydrateG.toStringAsFixed(1)}g'),
                                                backgroundColor: Colors.orange.shade50,
                                              ),
                                              const SizedBox(width: 8),
                                              Chip(
                                                label: Text('P: ${f.totalProteinG.toStringAsFixed(1)}g'),
                                                backgroundColor: Colors.blue.shade50,
                                              ),
                                              const SizedBox(width: 8),
                                              Chip(
                                                label: Text('F: ${f.totalFatG.toStringAsFixed(1)}g'),
                                                backgroundColor: Colors.green.shade50,
                                              ),
                                            ],
                                          ),
                                          onTap: () => Navigator.of(context).pop(f),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => setState(() => _showCustomForm = true),
                                child: const Text('Add Custom Food'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Food Name *',
                                  hintText: 'e.g., Grilled Chicken Breast',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a food name';
                                  }
                                  if (!_isValidName(value)) {
                                    return 'Invalid characters in name';
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.words,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Calories (auto)',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${_calculatedCalories.toStringAsFixed(0)} kcal',
                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _proteinController,
                                      decoration: const InputDecoration(
                                        labelText: 'Protein (g) *',
                                        hintText: '0',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) return 'Required';
                                        final n = double.tryParse(value);
                                        if (n == null) return 'Invalid';
                                        if (n < 0) return 'No negatives';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _fatController,
                                      decoration: const InputDecoration(
                                        labelText: 'Fat (g) *',
                                        hintText: '0',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) return 'Required';
                                        final n = double.tryParse(value);
                                        if (n == null) return 'Invalid';
                                        if (n < 0) return 'No negatives';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _carbsController,
                                decoration: const InputDecoration(
                                  labelText: 'Carbs (g) *',
                                  hintText: '0',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Required';
                                  final n = double.tryParse(value);
                                  if (n == null) return 'Invalid';
                                  if (n < 0) return 'No negatives';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: _netCarbs <= 20
                                      ? Colors.green.shade50
                                      : Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _netCarbs <= 20
                                        ? Colors.green.shade300
                                        : Colors.orange.shade300,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      _netCarbs <= 20 ? Icons.check_circle : Icons.info,
                                      color: _netCarbs <= 20 ? Colors.green : Colors.orange,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Net Carbs',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: _netCarbs <= 20 ? Colors.green.shade700 : Colors.orange.shade700,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${_netCarbs.toStringAsFixed(1)}g',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: _netCarbs <= 20 ? Colors.green.shade700 : Colors.orange.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => setState(() => _showCustomForm = false),
                                    child: const Text('Back'),
                                  ),
                                  const SizedBox(width: 12),
                                  ElevatedButton(
                                    onPressed: _submitCustom,
                                    child: const Text('Add Food'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
