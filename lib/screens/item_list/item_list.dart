import 'package:d3tech/providers/item_provider.dart';
import 'package:d3tech/routing/router.dart';
import 'package:d3tech/screens/add_item/add_item_screen.dart';
import 'package:d3tech/screens/update_item/update_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item List'),
      ),
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) => FutureBuilder(
          future: itemProvider.getItems(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: Text(
                  'Fetching data, Please wait..',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }

            if (itemProvider.items.isEmpty) {
              return const Center(
                child: Text(
                  'No Items to show!',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (_, index) => ListTile(
                title: Text(
                  itemProvider.items[index].name ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('₹${itemProvider.items[index].price}'),
                leading: itemProvider.items[index].photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(itemProvider.items[index].photo,
                            width: 100, fit: BoxFit.cover),
                      )
                    : const SizedBox(width: 100),
                trailing: IconButton(
                  onPressed: () {
                    deleteWarning(context).then((deleteAllowed) {
                      if (deleteAllowed) {
                        itemProvider.removeItem(index);
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  itemProvider.selectItemForEdit(index);
                  CustomRouter.navigateToScreen(
                      context, const UpdateItemScreen());
                },
              ),
              itemCount: itemProvider.items.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Provider.of<ItemProvider>(context, listen: false).clearForms();
          CustomRouter.navigateToScreen(context, const AddItemScreen());
        },
      ),
    );
  }

  Future<bool> deleteWarning(BuildContext context) async {
    var result = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Delete item?'),
              content: const Text('Are you sure you want to delete this item?'),
              actions: [
                TextButton(
                    onPressed: () =>
                        CustomRouter.goBack(context, result: false),
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () => CustomRouter.goBack(context, result: true),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete')),
              ],
            ));
    return result ?? false;
  }
}
