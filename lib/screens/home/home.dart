import 'package:d3tech/routing/router.dart';
import 'package:d3tech/screens/item_list/item_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
        onTap: () =>
            CustomRouter.navigateToScreen(context, const ItemListScreen()),
        child: Container(
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).primaryColor),
          child: const Center(
              child: Text(
            'Browse Items',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          )),
        ),
      )),
      appBar: AppBar(
        title: const Text('D3Tech'),
      ),
    );
  }
}
