
part of utilities;


class DataManager {

  static final DataManager _singleton = new DataManager._internal();

  factory DataManager() {
    return _singleton;
  }

  DataManager._internal();

  // Methods
  ObjUser user;

  static clear() {
    DataManager().user = null;
  }

}