import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:metabolicapp/core/database/drift_database_service.dart';
import 'package:metabolicapp/core/database/daos/drift_food_dao.dart';
import 'package:metabolicapp/core/database/models/food_model.dart';

/// Test page to verify database operations work on all platforms
@RoutePage()
class DatabaseTestPage extends StatefulWidget {
  const DatabaseTestPage({super.key});

  @override
  State<DatabaseTestPage> createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  final DriftDatabaseService _dbService = DriftDatabaseService();
  final DriftFoodDao _foodDao = DriftFoodDao();
  
  String _status = 'Initializing...';
  final List<String> _logs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _testDatabase();
  }

  void _addLog(String message) {
    setState(() {
      _logs.add('${DateTime.now().toString().substring(11, 19)}: $message');
    });
  }

  Future<void> _testDatabase() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing database...';
      _logs.clear();
    });

    try {
      // Test 1: Initialize database
      _addLog('Test 1: Initializing database...');
      await _dbService.database;
      _addLog('✅ Database initialized successfully!');
      _addLog('Platform: ${_dbService.isWeb ? "Web (IndexedDB)" : "Native (SQLite)"}');

      // Test 2: Insert food
      _addLog('\nTest 2: Inserting test food...');
      final testFood = FoodModel(
        foodDescription: 'Test Avocado ${DateTime.now().millisecondsSinceEpoch}',
        energyKcal: 160.0,
        totalProteinG: 2.0,
        totalFatG: 15.0,
        totalCarbohydrateG: 9.0,
        dietaryFiberG: 7.0,
        netCarbsG: 2.0,
        source: 'test',
      );
      final foodId = await _foodDao.insertFood(testFood);
      _addLog('✅ Food inserted with ID: $foodId');

      // Test 3: Retrieve food
      _addLog('\nTest 3: Retrieving food by ID...');
      final retrieved = await _foodDao.getFoodById(foodId);
      if (retrieved != null) {
        _addLog('✅ Food retrieved successfully!');
        _addLog('   Description: ${retrieved.foodDescription}');
        _addLog('   Calories: ${retrieved.energyKcal}');
        _addLog('   Net Carbs: ${retrieved.netCarbsG}');
      } else {
        _addLog('❌ Failed to retrieve food');
      }

      // Test 4: Search foods
      _addLog('\nTest 4: Searching for foods...');
      final searchResults = await _foodDao.searchFoods('Test');
      _addLog('✅ Found ${searchResults.length} foods matching "Test"');

      // Test 5: Insert multiple foods
      _addLog('\nTest 5: Inserting multiple foods...');
      for (int i = 1; i <= 3; i++) {
        final food = FoodModel(
          foodDescription: 'Test Food $i',
          energyKcal: 100.0 * i,
          totalProteinG: 10.0 * i,
          totalFatG: 5.0 * i,
          totalCarbohydrateG: 5.0 * i,
          source: 'test',
        );
        await _foodDao.insertFood(food);
      }
      _addLog('✅ Inserted 3 foods successfully');

      // Test 6: Search again
      _addLog('\nTest 6: Searching again...');
      final allResults = await _foodDao.searchFoods('Test');
      _addLog('✅ Total foods found: ${allResults.length}');

      setState(() {
        _status = '✅ All tests passed!';
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      _addLog('\n❌ ERROR: $e');
      _addLog('Stack trace: ${stackTrace.toString().substring(0, 200)}...');
      setState(() {
        _status = '❌ Tests failed!';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _testDatabase,
            tooltip: 'Run tests again',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: _status.contains('✅') 
                ? Colors.green.shade50 
                : _status.contains('❌')
                    ? Colors.red.shade50
                    : Colors.blue.shade50,
            child: Row(
              children: [
                if (_isLoading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (_status.contains('✅'))
                  const Icon(Icons.check_circle, color: Colors.green)
                else if (_status.contains('❌'))
                  const Icon(Icons.error, color: Colors.red)
                else
                  const Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _status,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                final log = _logs[index];
                final isError = log.contains('❌');
                final isSuccess = log.contains('✅');
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    log,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: isError 
                          ? Colors.red.shade700
                          : isSuccess
                              ? Colors.green.shade700
                              : Colors.grey.shade700,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

