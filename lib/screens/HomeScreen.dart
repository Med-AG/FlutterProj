import 'package:expense_income_tracker/models/StatsDTO.dart';
import 'package:expense_income_tracker/models/GraphDTO.dart';
import 'package:expense_income_tracker/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StatsDTO? stats; // Store stats data
  GraphDTO? graphData; // Store chart data
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Call both API functions concurrently using Future.wait()
      final results = await Future.wait([
        ApiService().fetchStats(), // Fetch stats data
        ApiService().fetchChartData(), // Fetch chart data
      ]);

      setState(() {
        stats = results[0] as StatsDTO;
        graphData = results[1] as GraphDTO;
        isLoading = false; // Data has been fetched, update the state
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to fetch data. Please try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gestion de Budget",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // First Container with stats info
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildInfoCard("Incomes", "${stats?.totalIncome} \$", Colors.green),
                    _buildInfoCard("Balance", "${stats?.balance} \$", Colors.blue),
                    _buildInfoCard("Expenses", "${stats?.totalExpense} \$", Colors.red),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Second part: List of transactions (or a static example here)
              Expanded(
                child: ListView(
                  children: [
                    // Display expenses
                    Column(
                      children: graphData?.expenseList.map((expense) {
                        // Format the DateTime to string with desired format
                        String formattedDate = DateFormat('yyyy-MM-dd').format(expense.date);

                        return Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        expense.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.red, // Set a color for expenses
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '($formattedDate)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          color: Color(0xFF474646),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${expense.amount} \$',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.red, // Set a color for expenses
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                'Expense',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Divider( // Divider added here to separate ListTiles
                              color: Colors.grey,  // Color of the divider
                              thickness: 1,         // Thickness of the divider line
                            ),
                          ],
                        );
                      }).toList() ?? [],
                    ),
                    // Display incomes
                    Column(
                      children: graphData?.incomeList.map((income) {
                        // Format the DateTime to string with desired format
                        String formattedDate = DateFormat('yyyy-MM-dd').format(income.date);

                        return Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        income.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.green, // Set a color for incomes
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '($formattedDate)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          color: Color(0xFF474646),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${income.amount} \$',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.green, // Set a color for incomes
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                'Income',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Divider( // Divider added here to separate ListTiles
                              color: Colors.grey,  // Color of the divider
                              thickness: 1,         // Thickness of the divider line
                            ),
                          ],
                        );
                      }).toList() ?? [],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14, // Adjusted font size
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
