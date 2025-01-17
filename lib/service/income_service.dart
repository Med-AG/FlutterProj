import 'dart:convert';
import 'package:expense_income_tracker/models/Income.dart';
import 'package:http/http.dart' as http;

class IncomeService {
  final String baseUrl = 'http://localhost:8080/api/income';

  Future<bool> postIncome(Income income) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(income.toJson()),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to create income: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error posting income: $e');
      return false;
    }
  }

  // Function to delete an income by id
  Future<bool> deleteIncome(int id) async {
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
        print('Failed to delete income: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting income: $e');
      return false;
    }
  }


}




