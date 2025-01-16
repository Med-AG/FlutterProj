import 'package:flutter/material.dart';
import 'package:statefulclickcounter/screens/AddExpenseScreen.dart';
import 'package:statefulclickcounter/screens/AddIncomeScreen.dart';
import 'package:statefulclickcounter/screens/DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Track the selected navigation bar index

  // Method to handle navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    // Dynamically display content based on selected index
    if (_selectedIndex == 0) {
      bodyContent = _buildHomeContent();
    } else if (_selectedIndex == 1) {
      bodyContent = const AddIncomeScreen();
    } else {
      bodyContent = const AddExpenseScreen();
    }

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
      body: SafeArea(child: bodyContent),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Ajouter Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_circle_outline),
            label: 'Ajouter Expense',
          ),
        ],
      ),
    );
  }

  // Build the content of the home screen
  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
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
                _buildInfoCard("Incomes", "150 \$", Colors.green),
                _buildInfoCard("Expenses", "200 \$", Colors.red),
                _buildInfoCard("Balance", "700 \$", Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Salary',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '(4 janv.)',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Color(0xFF474646),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '1500 \$',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              subtitle: const Text(
                'Income',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      title: 'Salary',
                      description: 'Monthly salary',
                      category: 'Income',
                      amount: 1500.0,
                      date: DateTime(2025, 1, 4),
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

  // Helper method to create info cards
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
              fontSize: 14,
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
