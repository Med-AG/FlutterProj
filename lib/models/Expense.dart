
class Expense {

  final int? id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final double amount;

  Expense({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.amount,
  });

  
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: json['amount'] as double,
    );
  }


  /*
  // Method to convert an Expense instance to JSON, excluding the 'id' when it's null
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'category': category,
      'date': date.toIso8601String().split('T')[0], // 'yyyy-MM-dd' format
      'amount': amount,
    };

    if (id != null) {
      data['id'] = id; // Add 'id' only if it's not null
    }

    return data;
  }
*/

  
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'category': category,
      // Format the DateTime object to match your backend's LocalDate format
      'date': date.toIso8601String().split('T')[0], // "yyyy-MM-dd"
      'amount': amount,
    };
  }


}
