abstract class DataTable<T>{
  List<T> _data = [];
  bool validateUniqueness = true;

  clearData()=> _data = [];

  delete(T item) => _data.remove(item);

  bool exist(T item){
    try {
      T? exist = find(item);
      if(exist == null) return false;
      else return true;
    }  catch (e) {
      return false;
    }
  }

  bool equal(T item, T newItem) => item == newItem;

  T? find(T item) {
    for (T element in _data) {
      if (item == element) return element;
    }
    return null;
    //return _data.firstWhereOrNull((v) => equal(item, v),orElse: (){});
  }

  bool update(T item){
    int index = _data.indexOf(item);
    if(index==-1) return false;
    _data[index] = item;
    return true;
  }

  addItem(T item) async{
    if(!validateUniqueness) return _data.add(item);
    if(!exist(item)) _data.add(item);
  }

  refresh(List<T> items) {
    clearData();
    addItems(items);
  }

  addItems(List<T> items) async {
    items.forEach((item)=> addItem(item));
  }

}