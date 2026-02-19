import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/database/models/food_model.dart';
import '../../../../core/database/daos/drift_food_dao.dart';
import '../../../../core/database/daos/drift_diet_entry_dao.dart';

//multiselect version of add food dialog - log multiple items in one go
class AddFoodsDialog extends StatefulWidget {
  //optional userId to show recent foods
  final int? userId;
  
  const AddFoodsDialog({super.key, this.userId});

  @override
  State<AddFoodsDialog> createState() => _AddFoodsDialogState();
}

class _AddFoodsDialogState extends State<AddFoodsDialog> {
  final _searchController = TextEditingController();
  final DriftFoodDao _foodDao = DriftFoodDao();
  final DriftDietEntryDao _dietEntryDao = DriftDietEntryDao();
  
  //debounce timer to avoid hammering db on every keystroke
  Timer? _debounceTimer;
  
  //track selected foods by their id
  final Set<int> _selectedFoodIds = {};
  final Map<int, FoodModel> _selectedFoods = {};
  
  List<FoodModel> _databaseFoods = [];
  List<FoodModel> _recentFoods = [];
  List<FoodModel> _searchResults = [];
  bool _isLoading = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadFoodsFromDatabase();
    _loadRecentFoods();
  }

  Future<void> _loadFoodsFromDatabase() async {
    try {
      final foods = await _foodDao.getAllFoods(limit: 100);
      if (mounted) {
        setState(() {
          _databaseFoods = foods;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('[ADD FOODS] ❌ Error loading foods: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  //load recent foods from diet entries for quick re-logging
  Future<void> _loadRecentFoods() async {
    if (widget.userId == null) return;
    
    try {
      //get last 7 days of diet entries
      final now = DateTime.now();
      final weekAgo = now.subtract(const Duration(days: 7));
      final entries = await _dietEntryDao.getDietEntriesByDateRange(
        widget.userId!,
        weekAgo.toIso8601String().split('T')[0],
        now.toIso8601String().split('T')[0],
      );
      
      //get unique food ids, most recent first
      final seenIds = <int>{};
      final recentFoodIds = <int>[];
      for (final entry in entries.reversed) {
        if (!seenIds.contains(entry.foodId)) {
          seenIds.add(entry.foodId);
          recentFoodIds.add(entry.foodId);
          if (recentFoodIds.length >= 10) break;
        }
      }
      
      //fetch the food models
      final recentFoods = <FoodModel>[];
      for (final foodId in recentFoodIds) {
        final food = await _foodDao.getFoodById(foodId);
        if (food != null) recentFoods.add(food);
      }
      
      if (mounted) {
        setState(() => _recentFoods = recentFoods);
      }
    } catch (e) {
      debugPrint('[ADD FOODS] ⚠️ Could not load recent foods: $e');
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    
    if (query.isEmpty) {
      _debounceTimer?.cancel();
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }
    
    setState(() => _isSearching = true);
    
    //debounce search to reduce db calls
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    try {
      final results = await _foodDao.searchFoods(query, limit: 50);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      debugPrint('[ADD FOODS] ❌ Search error: $e');
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  //toggle selection for a food item
  void _toggleSelection(FoodModel food) {
    final id = food.foodId ?? food.hashCode;
    setState(() {
      if (_selectedFoodIds.contains(id)) {
        _selectedFoodIds.remove(id);
        _selectedFoods.remove(id);
      } else {
        _selectedFoodIds.add(id);
        _selectedFoods[id] = food;
      }
    });
  }

  //check if food is selected
  bool _isSelected(FoodModel food) {
    final id = food.foodId ?? food.hashCode;
    return _selectedFoodIds.contains(id);
  }

  //clear all selections
  void _clearSelections() {
    setState(() {
      _selectedFoodIds.clear();
      _selectedFoods.clear();
    });
  }

  //submit all selected foods
  void _submitSelection() {
    if (_selectedFoods.isEmpty) return;
    Navigator.of(context).pop(_selectedFoods.values.toList());
  }

  List<FoodModel> get _displayFoods {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) return _searchResults;
    return _databaseFoods;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenSize.width * 0.9;
    final dialogHeight = screenSize.height * 0.85;
    final hasSelection = _selectedFoods.isNotEmpty;

    return Dialog(
      child: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Foods'),
            elevation: 0,
            actions: [
              if (hasSelection)
                TextButton.icon(
                  onPressed: _clearSelections,
                  icon: const Icon(Icons.clear_all, size: 20),
                  label: const Text('Clear'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
            ],
          ),
          body: Column(
            children: [
              //search bar
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search foods...',
                    border: const OutlineInputBorder(),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                ),
              ),
              
              //recent foods for quick re-logging
              if (_recentFoods.isNotEmpty && _searchController.text.isEmpty)
                _buildRecentFoodsSection(),
              
              //selection count banner
              if (hasSelection)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_selectedFoods.length} food${_selectedFoods.length == 1 ? '' : 's'} selected',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      //quick preview of total macros
                      _buildMacroPreview(),
                    ],
                  ),
                ),
              
              //food list with checkboxes
              Expanded(
                child: _isLoading || _isSearching
                    ? const Center(child: CircularProgressIndicator())
                    : _displayFoods.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            itemCount: _displayFoods.length,
                            //cache a few items for smoother scrolling
                            cacheExtent: 200,
                            itemBuilder: (context, index) {
                              final food = _displayFoods[index];
                              final isSelected = _isSelected(food);
                              return _buildFoodTile(food, isSelected);
                            },
                          ),
              ),
            ],
          ),
          //bottom action bar
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: hasSelection ? _submitSelection : null,
                      icon: const Icon(Icons.add),
                      label: Text(
                        hasSelection
                            ? 'Add ${_selectedFoods.length} Food${_selectedFoods.length == 1 ? '' : 's'}'
                            : 'Select Foods',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //recent foods horizontal scrollable section for quick re-logging
  Widget _buildRecentFoodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4, bottom: 8),
          child: Row(
            children: [
              Icon(
                Icons.history,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Recent',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _recentFoods.length,
            itemBuilder: (context, index) {
              final food = _recentFoods[index];
              final isSelected = _isSelected(food);
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildRecentFoodChip(food, isSelected),
              );
            },
          ),
        ),
        const Divider(height: 16),
      ],
    );
  }

  //chip for quick adding recent food
  Widget _buildRecentFoodChip(FoodModel food, bool isSelected) {
    return FilterChip(
      selected: isSelected,
      showCheckmark: true,
      label: Text(
        food.foodDescription.length > 20
            ? '${food.foodDescription.substring(0, 20)}...'
            : food.foodDescription,
        style: const TextStyle(fontSize: 12),
      ),
      avatar: isSelected ? null : const Icon(Icons.add, size: 16),
      onSelected: (_) => _toggleSelection(food),
      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
    );
  }

  //preview total macros for selected foods
  Widget _buildMacroPreview() {
    double totalCarbs = 0, totalProtein = 0, totalFat = 0;
    for (final food in _selectedFoods.values) {
      totalCarbs += food.totalCarbohydrateG;
      totalProtein += food.totalProteinG;
      totalFat += food.totalFatG;
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMiniChip('C', totalCarbs, Colors.orange),
        const SizedBox(width: 4),
        _buildMiniChip('P', totalProtein, Colors.blue),
        const SizedBox(width: 4),
        _buildMiniChip('F', totalFat, Colors.green),
      ],
    );
  }

  Widget _buildMiniChip(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: ${value.toStringAsFixed(0)}g',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            _searchController.text.isNotEmpty
                ? 'No foods match your search'
                : 'No foods in database',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildFoodTile(FoodModel food, bool isSelected) {
    return ListTile(
      //checkbox for multiselect
      leading: Checkbox(
        value: isSelected,
        onChanged: (_) => _toggleSelection(food),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        food.foodDescription,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          _buildMacroTag('C', food.totalCarbohydrateG, Colors.orange),
          const SizedBox(width: 6),
          _buildMacroTag('P', food.totalProteinG, Colors.blue),
          const SizedBox(width: 6),
          _buildMacroTag('F', food.totalFatG, Colors.green),
          const SizedBox(width: 6),
          Text(
            '${food.energyKcal.toStringAsFixed(0)} kcal',
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      onTap: () => _toggleSelection(food),
    );
  }

  Widget _buildMacroTag(String label, double value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: ${value.toStringAsFixed(0)}g',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
