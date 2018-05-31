import 'obj.dart';

enum ObjCellType {
  Default,
  Label,
  LabelImage,
  TextField,
  Button,
}

class ObjCell extends Obj {

  
  ObjCellType type = ObjCellType.Default;

  bool isTextProtected = false;
  bool isClickable = false;

  var relativeObj;

  static ObjCell findByIdentifier(List list, String identifier) {
    ObjCell cell;

    list.forEach((obj){
      if (obj.runtimeType == ObjCell) {
        ObjCell temp = obj;
        if (temp.identifier == identifier) {
          cell = temp;
        }
      }
    });

    return cell;
  }

  

}