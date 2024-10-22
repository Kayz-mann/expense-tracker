import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class Expense {
  String expenseId;
  Category category;
  DateTime date;
  int amount;

  Expense(
      {required this.expenseId,
      required this.category,
      required this.date,
      required this.amount});

  static final empty = Expense(
      expenseId: '', category: Category.empty, date: DateTime.now(), amount: 0);

  Expense toEntity() {
    return Expense(
        expenseId: expenseId, category: category, date: date, amount: amount);
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
        expenseId: entity.expenseId,
        date: entity.date,
        category: entity.category,
        amount: entity.amount);
  }

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'category':
          category.toEntity().toDocument(), // Convert category to document
      'date': Timestamp.fromDate(date), // Convert DateTime to Timestamp
      'amount': amount,
    };
  }
}
