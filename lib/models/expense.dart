class Expense {
  int? id;
  int? categoryID;
  String? expenseDate;
  double? expenseValue;
  String? notes;

  Expense(
      {this.id,
      this.categoryID,
      this.expenseDate,
      this.expenseValue,
      this.notes});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        id: json['id'],
        categoryID: json['categoryID'],
        expenseDate: json['expenseDate'],
        expenseValue: json['expenseValue'],
        notes: json['notes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryID': categoryID,
      'expenseDate': expenseDate,
      'expenseValue': expenseValue,
      'notes': notes
    };
  }
}
