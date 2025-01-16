import 'expense.dart';
import 'income.dart';

class GraphDTO {
  final List<Expense> expenseList;
  final List<Income> incomeList;

  GraphDTO({
    required this.expenseList,
    required this.incomeList,
  });

  factory GraphDTO.fromJson(Map<String, dynamic> json) {
    return GraphDTO(
      expenseList: (json['expenselList'] as List)
          .map((e) => Expense.fromJson(e))
          .toList(),
      incomeList: (json['incomeList'] as List)
          .map((e) => Income.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenselList': expenseList.map((e) => e.toJson()).toList(),
      'incomeList': incomeList.map((e) => e.toJson()).toList(),
    };
  }
}
