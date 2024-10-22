import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toDocument());
    } catch (e) {
      print('Error creating category: $e');
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      final snapshot = await categoryCollection.get();
      return snapshot.docs
          .map(
              (e) => Category.fromEntity(CategoryEntity.fromDocument(e.data())))
          .toList();
    } catch (e) {
      print('Error creating category: $e');
      return [];
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      // Create ExpenseEntity first
      Expense expenseEntity = expense.toEntity();
      // Then convert to document
      await expenseCollection
          .doc(expense.expenseId)
          .set(expenseEntity.toDocument());
    } catch (e) {
      print('Error creating expense: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      final snapshot = await expenseCollection.get();
      return snapshot.docs
          .map((e) => Expense.fromEntity(ExpenseEntity.fromDocument(e.data())))
          .toList();
    } catch (e) {
      print('Error creating category: $e');
      return [];
    }
  }
}
