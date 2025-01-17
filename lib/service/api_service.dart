import 'dart:convert';
import 'package:expense_income_tracker/models/GraphDTO.dart';
import 'package:expense_income_tracker/models/StatsDTO.dart';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8080";

  // --------------------------------- data for home screen ------------------------------------
  // Fetch chart data (GraphDTO)
  Future<GraphDTO> fetchChartData() async {
    final url = Uri.parse('$baseUrl/api/stats/chart');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return GraphDTO.fromJson(data);
    } else {
      throw Exception("Failed to load chart data: ${response.statusCode}");
    }
  }

  // Fetch stats data (StatsDTO)
  Future<StatsDTO> fetchStats() async {
    final url = Uri.parse('$baseUrl/api/stats');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return StatsDTO.fromJson(data);
    } else {
      throw Exception("Failed to load stats data: ${response.statusCode}");
    }
  }

  // Delete an expense
  Future<void> deleteExpense(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/expenses/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete expense');
    }
  }
}
