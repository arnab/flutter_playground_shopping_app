import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/product.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({Key? key}) : super(key: key);

  static const routeName = '/product-edit';

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _priceNodeFocus = FocusNode();
  final _descriptionNodeFocus = FocusNode();
  final _imageUrlNodeFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _editedProduct = Product(
    id: DateTime.now().toString(),
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlNodeFocus.addListener(_updateImageFromUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(label: Text('Title')),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceNodeFocus),
                  onSaved: (val) {
                    _editedProduct = _editedProduct.copyWith(title: val);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Price')),
                  textInputAction: TextInputAction.next,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  focusNode: _priceNodeFocus,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionNodeFocus),
                  onSaved: (val) {
                    if (val != null) {
                      _editedProduct =
                          _editedProduct.copyWith(price: double.parse(val));
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text('Description')),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionNodeFocus,
                  onSaved: (val) {
                    _editedProduct = _editedProduct.copyWith(description: val);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter a URL')
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageUrlController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration:
                            const InputDecoration(label: Text('Image URL')),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlNodeFocus,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (val) {
                          _editedProduct =
                              _editedProduct.copyWith(imageUrl: val);
                        },
                      ),
                    )
                  ],
                )
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

    _imageUrlNodeFocus.removeListener(_updateImageFromUrl);
    _imageUrlNodeFocus.dispose();
    _imageUrlController.dispose();

    super.dispose();
  }

  void _updateImageFromUrl() {
    setState(() {
      // Nothing to do, just need the widget to refresh
    });
  }

  void _saveForm() {
    _form.currentState?.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
    // TODO: Validate and save data
  }
}
