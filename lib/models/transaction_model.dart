class TransactionModel {
  final int? id;
  final int? categoryId; // Non-required, auto-incremented in DB
  final double amount;
  final String description;
  final String type; // 'income' or 'expense'
  final String timestamp;

  TransactionModel({
    this.id,
    this.categoryId,
    required this.amount,
    required this.description,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'amount': amount,
      'description': description,
      'type': type,
      'timestamp': timestamp,
    };
  }
}