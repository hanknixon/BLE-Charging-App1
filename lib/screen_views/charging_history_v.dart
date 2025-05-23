import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/colors.dart';
import '../navigation/navbars.dart';

class ChargingHistoryV extends StatefulWidget {
  @override
  _ChargingHistoryV createState() => _ChargingHistoryV();
}

class _ChargingHistoryV extends State<ChargingHistoryV> {
  String selectedTimeframe = '1W';
  bool showReports = true;

  final List<String> timeframes = ['1W', '1M', '3M', '6M'];
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  // Sample data for the bar chart
  final List<double> expenses = [25.0, 35.0, 20.0, 45.0, 30.0];
  final List<double> energyConsumed = [2.5, 3.0, 2.0, 4.0, 3.5];

  List<ChargingSession> chargingSessions = [
    ChargingSession(
      id: 1,
      energy: 5.2,
      cost: 75.0,
      date: DateTime(2023, 12, 1, 14, 30),
    ),
    ChargingSession(
      id: 2,
      energy: 5.2,
      cost: 75.0,
      date: DateTime(2023, 12, 2, 14, 30),
    ),
    ChargingSession(
      id: 3,
      energy: 5.2,
      cost: 75.0,
      date: DateTime(2023, 12, 3, 14, 30),
    ),
    ChargingSession(
      id: 4,
      energy: 5.2,
      cost: 75.0,
      date: DateTime(2023, 12, 4, 14, 30),
    ),
    ChargingSession(
      id: 5,
      energy: 5.2,
      cost: 75.0,
      date: DateTime(2023, 12, 5, 14, 30),
    ),
  ];

  Widget _buildTimeframeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: timeframes.map((timeframe) {
        bool isSelected = selectedTimeframe == timeframe;
        return Padding(
          padding: EdgeInsets.only(right: 8),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedTimeframe = timeframe;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? MCColors.green : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? MCColors.green : Colors.grey[300]!,
                ),
              ),
              child: Text(
                timeframe,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBarChart() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24), // spacing from time filter
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 50,
                  barTouchData: BarTouchData(enabled: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            weekdays[value.toInt()],
                            style: TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      axisNameSize: 36,
                      axisNameWidget: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'My Expenses (\$)',
                          style: TextStyle(
                            color: MCColors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 44,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: MCColors.green,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      axisNameSize: 36,
                      axisNameWidget: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'Energy Consumed (kWh)',
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 44,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            (value / 10).toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: List.generate(weekdays.length, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: expenses[index],
                          color: MCColors.green,
                          width: 12,
                        ),
                        BarChartRodData(
                          toY: energyConsumed[index] * 10,
                          color: Colors.amber,
                          width: 12,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Expenses', MCColors.green),
                  SizedBox(width: 20),
                  _buildLegendItem('Energy Consumed', Colors.amber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  Widget _buildStatisticsCard(String title, String value, String average) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: MCColors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            average,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: chargingSessions.length,
      itemBuilder: (context, index) {
        final session = chargingSessions[index];
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Charging Session ${session.id}',
                    style: TextStyle(
                      color: MCColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${session.energy} kWh • \$${session.cost}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    session.formattedDate,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TopNavBar(), // Your shared logo/header widget
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: MCColors.green),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  "Charging History",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MCColors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showReports = true;
                            });
                          },
                          child: Text(
                            'Reports',
                            style: TextStyle(
                              color: showReports ? MCColors.green : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 32),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showReports = false;
                            });
                          },
                          child: Text(
                            'History',
                            style: TextStyle(
                              color:
                                  !showReports ? MCColors.green : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showReports) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildTimeframeSelector(),
                    ),
                    _buildBarChart(),
                    _buildStatisticsCard(
                      'Electricity Charged',
                      '25.5 kWh',
                      'Daily Average: 3.6 kWh',
                    ),
                    _buildStatisticsCard(
                      'Expenses',
                      '\$350.00',
                      'Daily Average: \$50.00',
                    ),
                  ] else
                    _buildHistoryList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChargingSession {
  final int id;
  final double energy;
  final double cost;
  final DateTime date;

  ChargingSession({
    required this.id,
    required this.energy,
    required this.cost,
    required this.date,
  });

  String get formattedDate {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
