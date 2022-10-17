import 'package:flutter/material.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({Key? key}) : super(key: key);

  static const routeName = '/product-edit';

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _priceNodeFocus = FocusNode();
  final _descriptionNodeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(label: Text('Title')),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceNodeFocus),
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Price')),
                  textInputAction: TextInputAction.next,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  focusNode: _priceNodeFocus,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionNodeFocus),
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Description')),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionNodeFocus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceNodeFocus.dispose();
    _descriptionNodeFocus.dispose();
    super.dispose();
  }
}
