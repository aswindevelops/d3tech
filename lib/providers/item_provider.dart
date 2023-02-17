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
    final data = await _localRepository.getItems();
    items = Item.generateListFromMap(data);
  }

  Future addItems() async {
    var item = Item(
        null, nameController.text, double.parse(priceController.text), image);

    await _localRepository.insertItem(item);
    items.add(item);

    notifyListeners();

    clearForms();
  }

  Future updateItems() async {
    var item = Item(items[selectedIndex].id, nameController.text,
        double.parse(priceController.text), image);

    await _localRepository.updateItem(item);

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
