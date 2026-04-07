import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniChartWidget extends StatelessWidget {
  final List<double> data;
  final Color color;

  const MiniChartWidget({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();

    // Convert our List<double> into FlSpot objects required by fl_chart
    List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i]));
    }

    return LineChart(
      LineChartData(
        // 1. Hide the grid lines
        gridData: const FlGridData(show: false),
        
        // 2. Hide the axis titles (the numbers on the left and bottom)
        titlesData: const FlTitlesData(show: false),
        
        // 3. Hide the chart border
        borderData: FlBorderData(show: false),
        
        // 4. Disable touch interactions (tooltips) since it's just a tiny UI element
        lineTouchData: const LineTouchData(enabled: false),
        
        // 5. Configure the actual line
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true, // Makes the line wavy/smooth instead of jagged
            color: color,   // The trend color (Green/Red)
            barWidth: 2,    // Line thickness
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false), // Hides the dots on each data point
            
            // 6. Add the beautiful fading gradient underneath the line
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.3), 
                  color.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}