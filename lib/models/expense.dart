class Expense {
  int? id;
  int? catID;
  String? expenseDate;
  double? expenseValue;
  String? notes;

  Expense(
      {this.id, this.catID, this.expenseDate, this.expenseValue, this.notes});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        id: json['id'],
        catID: json['catID'],
        expenseDate: json['expenseDate'],
        expenseValue: json['expenseValue'],
        notes: json['notes']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'catID': catID,
      'expenseDate': expenseDate,
      'expenseValue': expenseValue,
      'notes': notes
    };
  }
}
