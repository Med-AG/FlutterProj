import 'dart:convert';
import 'package:expense_income_tracker/models/Expense.dart';
import 'package:http/http.dart' as http;

class ExpenseService {
  final String baseUrl = 'http://localhost:8080/api/expense';

  
  Future<bool> postExpense(Expense expense) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(expense.toJson()),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to create expense: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error posting expense: $e');
      return false;
    }
  }

  
  Future<bool> deleteExpense(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to delete expense: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting expense: $e');
      return false;
    }
  }
}
