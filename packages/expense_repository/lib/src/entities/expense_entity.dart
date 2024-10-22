import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  int amount;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'category':
          category.toEntity().toDocument(), // Convert category to document
      'date': Timestamp.fromDate(date), // Convert DateTime to Timestamp
      'amount': amount,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'] as String,
      amount: doc['amount'] as int,
      category: Category.fromEntity(
          CategoryEntity.fromDocument(doc['category'] as Map<String, dynamic>)),
      date: (doc['date'] as Timestamp).toDate(),
    );
  }
}
