class EntitiesUtil {
  static final EntitiesUtil _instance = EntitiesUtil._internal();
  // passes the instantiation to the _instance object
  factory EntitiesUtil() => _instance;

  EntitiesUtil._internal() {
    _isEditing = false;
  }

  bool _isEditing;

  //short getter and setter for the variables
  bool get isEditing => _isEditing;
  set isEditing(bool value) => _isEditing = value;

}
