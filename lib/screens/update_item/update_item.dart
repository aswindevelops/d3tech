import 'package:d3tech/providers/item_provider.dart';
import 'package:d3tech/routing/router.dart';
import 'package:d3tech/widgets/bottom_sticky_button.dart';
import 'package:d3tech/widgets/item_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateItemScreen extends StatelessWidget {
  const UpdateItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Item'),
      ),
      body: Stack(
        children: [
          const ItemForm(),
          Align(
              alignment: Alignment.bottomCenter,
              child: BottomStickyButton(
                label: 'Update Product',
                onPressed: () {

                  if (!Provider.of<ItemProvider>(context, listen: false)
                      .isFormsValid()) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: const Text('Please fill all mandatory fields!'),
                          actions: [
                            TextButton(
                                onPressed: () => CustomRouter.goBack(context),
                                child: const Text('Ok'))
                          ],
                        ));
                    return;
                  }

                  Provider.of<ItemProvider>(context, listen: false)
                      .updateItems()
                      .then((value) => CustomRouter.goBack(context));
                },
              ))
        ],
      ),
    );
  }
}
