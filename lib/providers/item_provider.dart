import 'dart:typed_data';

import 'package:d3tech/models/item.dart';
import 'package:d3tech/repository/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemProvider with ChangeNotifier {
  final LocalRepository _localRepository = LocalRepository();
  List<Item> items = [];
  int selectedIndex = -1;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Uint8List? image;

  Future getItems() async {
    // fetching items from local db
    final data = await _localRepository.getItems();

    // generate list of items from list of maps
    items = Item.generateListFromMap(data);
  }

  Future addItems() async {

    // generating item class
    var item = Item(
        null, nameController.text, double.parse(priceController.text), image);

    // adding item to local db
    var id = await _localRepository.insertItem(item);
    item.id = id;

    // adding item to cached items
    items.add(item);

    notifyListeners();

    clearForms();
  }

  Future updateItems() async {
    // generate item class
    var item = Item(items[selectedIndex].id, nameController.text,
        double.parse(priceController.text), image);

    // update local db
    await _localRepository.updateItem(item);

    // update cached data
    items.removeAt(selectedIndex);
    items.insert(selectedIndex, item);

    notifyListeners();
  }

  selectItemForEdit(int index) {
    var item = items[index];
    selectedIndex = index;

    nameController.text = item.name ?? '';
    priceController.text = item.price.toString();
    image = item.photo;
  }

  removeItem(int index) async {
    await _localRepository.deleteItem(items[index]);
    items.removeAt(index);
    notifyListeners();
  }

  setImage(XFile? img) async {
    if (img != null) {
      image = await img.readAsBytes();
    } else {
      image = null;
    }
    notifyListeners();
  }

  bool isFormsValid() {
    return nameController.text.isNotEmpty && priceController.text.isNotEmpty;
  }

  clearForms() {
    nameController.clear();
    priceController.clear();

    image = null;
  }
}
