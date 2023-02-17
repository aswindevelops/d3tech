class Item {
   int? id;
   String? name;
   double? price;
   dynamic photo;

  Item(this.id, this.name, this.price, this.photo);

  /// Generate [Map] from [Item]
  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'image': photo};
  }

  /// generate [Item] from [Map]
  Item.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    photo = json['image'];
  }

  /// Generate List of [Item] from [Map]
  static List<Item> generateListFromMap(List<Map<String, dynamic>> itemsJson) {
    List<Item> items = [];

    for (var element in itemsJson) {
      items.add(Item(element['id'], element['name'], element['price'], element['image']));
    }
    return items;
  }
}
