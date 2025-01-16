import 'expense.dart';
import 'income.dart';

class StatsDTO {
  final double totalIncome;
  final double totalExpense;
  final Income? lastIncome;
  final Expense? lastExpense;
  final double balance;
  final double minIncome;
  final double maxIncome;
  final double minExpense;
  final double maxExpense;

  StatsDTO({
    required this.totalIncome,
    required this.totalExpense,
    this.lastIncome,
    this.lastExpense,
    required this.balance,
    required this.minIncome,
    required this.maxIncome,
    required this.minExpense,
    required this.maxExpense,
  });

  factory StatsDTO.fromJson(Map<String, dynamic> json) {
    return StatsDTO(
      totalIncome: json['totalIncome'],
      totalExpense: json['totalExpense'],
      lastIncome: json['lastIncome'] != null
          ? Income.fromJson(json['lastIncome'])
          : null,
      lastExpense: json['lastExpense'] != null
          ? Expense.fromJson(json['lastExpense'])
          : null,
      balance: json['balance'],
      minIncome: json['minIncome'],
      maxIncome: json['maxIncome'],
      minExpense: json['minExpense'],
      maxExpense: json['maxExpense'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'lastIncome': lastIncome?.toJson(),
      'lastExpense': lastExpense?.toJson(),
      'balance': balance,
      'minIncome': minIncome,
      'maxIncome': maxIncome,
      'minExpense': minExpense,
      'maxExpense': maxExpense,
    };
  }
}
