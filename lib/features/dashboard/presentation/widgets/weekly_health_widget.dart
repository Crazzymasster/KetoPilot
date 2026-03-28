import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/daos/drift_symptoms_dao.dart';
import '../../../../core/providers/user_provider.dart';

class WeeklyHealthWidget extends ConsumerStatefulWidget {
  const WeeklyHealthWidget({super.key});

  @override
  ConsumerState<WeeklyHealthWidget> createState() => _WeeklyHealthWidgetState();
}

class _WeeklyHealthWidgetState extends ConsumerState<WeeklyHealthWidget> {
  final DriftSymptomsDao _symptomsDao = DriftSymptomsDao();

  bool _isLoading = true;
  List<Map<String, dynamic>> _weekData = const [];

  @override
  void initState() {
    super.initState();
    _loadWeeklyHealthData();
  }

  Future<void> _loadWeeklyHealthData() async {
    final user = ref.read(userProvider).currentUser;
    if (user?.userId == null) {
      setState(() {
        _weekData = _emptyWeekData();
        _isLoading = false;
      });
      return;
    }

    final now = DateTime.now();
    final weekDates = List.generate(7, (index) {
      final day = now.subtract(Duration(days: now.weekday - 1 - index));
      return DateTime(day.year, day.month, day.day);
    });

    final startDate = _formatDate(weekDates.first);
    final endDate = _formatDate(weekDates.last);

    try {
      final logs = await _symptomsDao.getSymptomsByDateRange(
        user!.userId!,
        startDate,
        endDate,
      );

      final Map<String, dynamic> logMap = {
        for (final log in logs) log.date: log,
      };

      final data = weekDates.map((date) {
        final dateKey = _formatDate(date);
        final log = logMap[dateKey];

        return {
          'day': _dayLabel(date),
          'energy': (log?.energyLevel ?? 0).toDouble(),
          'mood': (log?.moodRating ?? 0).toDouble(),
          'sleep': (log?.sleepQuality ?? 0).toDouble(),
          'clarity': (log?.mentalClarity ?? 0).toDouble(),
        };
      }).toList();

      setState(() {
        _weekData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _weekData = _emptyWeekData();
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _emptyWeekData() {
    return const [
      {'day': 'Mon', 'energy': 0.0, 'mood': 0.0, 'sleep': 0.0, 'clarity': 0.0},
      {'day': 'Tue', 'energy': 0.0, 'mood': 0.0, 'sleep': 0.0, 'clarity': 0.0},
      {'day': 'Wed', 'energy': 0.0, 'mood': 0.0, 'sleep': 0.0, 'clarity': 0.0},
      {'day': 'Thu', 'energy': 0.0, 'mood': 0.0, 'sleep': 0.0, 'clarity': 0.0},
      {'day': 'Fri', 'energy': 0.0, 'mood': 0.0, 'sleep': 0.0, 'clarity': 0.0},
      {'day': 'Sat', 'energy': 0.0, 'mood': 0.0, 'sleep': 0.0, 'clarity': 0.0},
      {'day': 'Sun', 'energy': 0.0, 'mood': 0.0, 'sleep': 0.0, 'clarity': 0.0},
    ];
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  String _dayLabel(DateTime date) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return labels[date.weekday - 1];
  }

  double _average(String key) {
    if (_weekData.isEmpty) return 0.0;
    return _weekData
        .map((d) => d[key] as double)
        .reduce((a, b) => a + b) /
        7;
  }

  static const Color energyColor = Color(0xFFF4B400);
  static const Color moodColor = Color(0xFF42A5F5);
  static const Color sleepColor = Color(0xFFAB47BC);
  static const Color clarityColor = Color(0xFF66BB6A);

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLegend(context),
          const SizedBox(height: 12),
          _buildChart(context),
          const SizedBox(height: 12),
          _buildSummary(context),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem(context, 'Energy', energyColor),
        _buildLegendItem(context, 'Mood', moodColor),
        _buildLegendItem(context, 'Sleep', sleepColor),
        _buildLegendItem(context, 'Clarity', clarityColor),
      ],
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        children: [
          Expanded(
            child: CustomPaint(
              painter: _WeeklyHealthChartPainter(
                weekData: _weekData,
                energyColor: energyColor,
                moodColor: moodColor,
                sleepColor: sleepColor,
                clarityColor: clarityColor,
                gridColor: Theme.of(context).dividerColor.withOpacity(0.25),
                textColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: _weekData.map((dayData) {
              return Expanded(
                child: Text(
                  dayData['day'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    final avgEnergy = _average('energy');
    final avgMood = _average('mood');
    final avgSleep = _average('sleep');
    final avgClarity = _average('clarity');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryMetric(
              context,
              avgEnergy.toStringAsFixed(1),
              'Energy',
              energyColor,
            ),
          ),
          Expanded(
            child: _buildSummaryMetric(
              context,
              avgMood.toStringAsFixed(1),
              'Mood',
              moodColor,
            ),
          ),
          Expanded(
            child: _buildSummaryMetric(
              context,
              avgSleep.toStringAsFixed(1),
              'Sleep',
              sleepColor,
            ),
          ),
          Expanded(
            child: _buildSummaryMetric(
              context,
              avgClarity.toStringAsFixed(1),
              'Clarity',
              clarityColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMetric(
      BuildContext context,
      String value,
      String label,
      Color color,
      ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class _WeeklyHealthChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> weekData;
  final Color energyColor;
  final Color moodColor;
  final Color sleepColor;
  final Color clarityColor;
  final Color gridColor;
  final Color textColor;

  _WeeklyHealthChartPainter({
    required this.weekData,
    required this.energyColor,
    required this.moodColor,
    required this.sleepColor,
    required this.clarityColor,
    required this.gridColor,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double minValue = 0;
    const double maxValue = 10;
    const double leftPadding = 24;
    const double topPadding = 8;
    const double bottomPadding = 8;

    final chartWidth = size.width - leftPadding;
    final chartHeight = size.height - topPadding - bottomPadding;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    final axisTextStyle = TextStyle(color: textColor, fontSize: 10);

    for (int i = 0; i <= 5; i++) {
      final value = i * 2;
      final y = topPadding + chartHeight - (value / maxValue) * chartHeight;

      _drawDashedLine(
        canvas,
        Offset(leftPadding, y),
        Offset(size.width, y),
        gridPaint,
      );

      final textPainter = TextPainter(
        text: TextSpan(text: value.toString(), style: axisTextStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    // CHANGED: draw each series with a small x-offset so dots do not overlap
    _drawSeries(
      canvas,
      chartWidth,
      chartHeight,
      leftPadding,
      topPadding,
      minValue,
      maxValue,
      'energy',
      energyColor,
      -0.18, // CHANGED
    );
    _drawSeries(
      canvas,
      chartWidth,
      chartHeight,
      leftPadding,
      topPadding,
      minValue,
      maxValue,
      'mood',
      moodColor,
      -0.06, // CHANGED
    );
    _drawSeries(
      canvas,
      chartWidth,
      chartHeight,
      leftPadding,
      topPadding,
      minValue,
      maxValue,
      'sleep',
      sleepColor,
      0.06, // CHANGED
    );
    _drawSeries(
      canvas,
      chartWidth,
      chartHeight,
      leftPadding,
      topPadding,
      minValue,
      maxValue,
      'clarity',
      clarityColor,
      0.18, // CHANGED
    );
  }

  void _drawSeries(
      Canvas canvas,
      double chartWidth,
      double chartHeight,
      double leftPadding,
      double topPadding,
      double minValue,
      double maxValue,
      String keyName,
      Color color,
      double xOffsetFactor, // CHANGED: added series horizontal offset
      ) {
    final linePaint = Paint()
      ..color = color.withOpacity(0.7) // CHANGED: slightly softer line
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final dotBorderPaint = Paint() // CHANGED: white border helps separate close dots
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final points = <Offset>[];

    final stepX = weekData.length > 1 ? (chartWidth / (weekData.length - 1)) : 0.0; // CHANGED
    final pixelOffset = stepX * xOffsetFactor; // CHANGED

    for (int i = 0; i < weekData.length; i++) {
      final value = (weekData[i][keyName] as double?) ?? 0.0;
      final baseX = leftPadding + stepX * i; // CHANGED
      final x = baseX + pixelOffset; // CHANGED
      final y = topPadding +
          chartHeight -
          ((value - minValue) / (maxValue - minValue)) * chartHeight;
      points.add(Offset(x, y));
    }

    for (int i = 0; i < points.length - 1; i++) {
      _drawDashedLine(canvas, points[i], points[i + 1], linePaint);
    }

    for (final point in points) {
      canvas.drawCircle(point, 4.0, dotPaint); // CHANGED: slightly bigger dot
      canvas.drawCircle(point, 4.0, dotBorderPaint); // CHANGED: border for visibility
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashWidth = 6;
    const double dashSpace = 4;

    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = math.sqrt(dx * dx + dy * dy);

    if (distance == 0) return;

    final unitX = dx / distance;
    final unitY = dy / distance;

    double drawn = 0;
    while (drawn < distance) {
      final x1 = start.dx + unitX * drawn;
      final y1 = start.dy + unitY * drawn;

      final next = (drawn + dashWidth).clamp(0, distance);
      final x2 = start.dx + unitX * next;
      final y2 = start.dy + unitY * next;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
      drawn += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}