
class Income {

  final int id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final double amount;

  Income({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.amount,
  });

  // Factory constructor to create an instance of Income from JSON
  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: json['amount'] as double,
    );
  }

  // Method to convert an Income instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }

}