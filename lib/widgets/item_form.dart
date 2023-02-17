import 'package:d3tech/providers/item_provider.dart';
import 'package:d3tech/widgets/image_source_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ItemForm extends StatelessWidget {
  const ItemForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemProvider itemProvider = context.read<ItemProvider>();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
                controller: itemProvider.nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Product Name',
                    labelText: 'Product Name')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: TextFormField(
                controller: itemProvider.priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Price',
                    labelText: 'Price'),
              ),
            ),
            Consumer<ItemProvider>(
              builder: (_, itemProv, child) => Builder(builder: (_) {
                if (itemProv.image != null) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.memory(
                              itemProv.image!,
                              height: MediaQuery.of(context).size.width / 2,
                              width: MediaQuery.of(context).size.width / 2,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => itemProv.setImage(null),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15))),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton.icon(
                    onPressed: () async {
                      XFile? result = await showModalBottomSheet(
                          context: context,
                          builder: (_) => const ImageSourceSelector());
                      itemProvider.setImage(result);
                    },
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Image'))),
            const SizedBox(
              height: 64,
            )
          ],
        ),
      ),
    );
  }
}
