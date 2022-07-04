class TransactionEntity {
  static final TransactionEntity _instance = TransactionEntity._internal();
  // passes the instantiation to the _instance object
  factory TransactionEntity() => _instance;

  TransactionEntity._internal() {
    _documentId = '';
    _createdAt = DateTime.now();
    _description = '';
    _reason = '';
    _type = '';
    _value = 0.0;
  }

  String _documentId;
  DateTime _createdAt;
  String _description;
  String _reason;
  String _type;
  double _value;

  //short getter and setter for the variables
  String get documentId => _documentId;
  set documentId(String value) => _documentId = value;

  DateTime get createdAt => _createdAt;
  set createdAt(DateTime value) => _createdAt = value;

  String get description => _description;
  set description(String value) => _description = value;

  String get reason => _reason;
  set reason(String value) => _reason = value;

  String get type => _type;
  set type(String value) => _type = value;

  double get value => _value;
  set value(double val) => _value = val;

  @override
  String toString() {
    return 'Product{id: $documentId, created_at: $createdAt, description: $description, reason: $reason, type: $type, value: $value}';
  }

  void cleanEntity() {
    _documentId = '';
    _createdAt = DateTime.now();
    _description = '';
    _reason = '';
    _type = '';
    _value = 0.0;
  }
}
