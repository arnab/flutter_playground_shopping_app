import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_playground_shopping_app/models/product.dart';
import 'package:flutter_playground_shopping_app/models/providers/products_provider.dart';
import 'package:provider/provider.dart';

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
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    // Note: Just add a default URL to avoid cumbersome copy-paste for now
    'imageUrl': 'https://i.ebayimg.com/images/g/nqgAAOSwcJhfrYkp/s-l640.jpg',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlNodeFocus.addListener(_updateImageFromUrl);
    super.initState();
  }


  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute
          .of(context)
          ?.settings
          .arguments as String?;
      if (productId != null) {
        _editedProduct =
            Provider.of<ProductsProvider>(context, listen: false).findById(
                productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;

    super.didChangeDependencies();
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(),)
          : Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(label: Text('Title')),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceNodeFocus),
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _editedProduct = _editedProduct.copyWith(title: val);
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(label: Text('Price')),
                  textInputAction: TextInputAction.next,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  focusNode: _priceNodeFocus,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context)
                          .requestFocus(_descriptionNodeFocus),
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'Please enter the price';
                    }
                    if (double.tryParse(value!) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    if (val != null) {
                      _editedProduct =
                          _editedProduct.copyWith(price: double.parse(val));
                    }
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
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
                        validator: (value) {
                          if ((value ?? '').isEmpty) {
                            return 'Please enter an image URL';
                          }
                          // TODO: Regex validation
                          return null;
                        },
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

  Future<void> _saveForm() async {
    final bool? isValid = _form.currentState?.validate();
    if (!(isValid ?? false)) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_editedProduct.id.isEmpty) {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } else {
        await Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
      }
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
        title: const Text('An error occurred!'),
        content: Text('Details: $error'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
    }

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
