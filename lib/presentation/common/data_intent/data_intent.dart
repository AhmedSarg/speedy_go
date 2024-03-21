import '../../../domain/models/domain.dart';
import '../../../domain/models/enums.dart';

class DataIntent {
  DataIntent._();

  //------------------------------------
  //News Item
  // static NewsItemModel? _newsItemModel;
  //
  // static void pushNewsItem(NewsItemModel item) => _newsItemModel = item;
  //
  // static NewsItemModel? popNewsItem() {
  //   var r = _newsItemModel;
  //   _newsItemModel = null;
  //   return r;
  // }

//-----------------------------------

//------------------------------------
  //Selection
  static Selection _selection = Selection.none;

  static void setSelection(Selection item) => _selection = item;

  static Selection getSelection() {
    return _selection;
  }

//-----------------------------------
}
