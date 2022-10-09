import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section08/providers/product.dart';
import 'package:section08/providers/products.dart';

//  https://imagemagick.org/image/wizard.png

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null, title: null, description: null, price: null, imageUrl: null);

  bool _isLoading = false;

  @override
  void initState() {
    _imageFocusNode.addListener(_imageUpdateUrl);
    super.initState();
  }

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != '') {
        _editedProduct = Provider.of<Products>(context).findById(id: productId);
        _initValues = {
          'title': _editedProduct.title!,
          'description': _editedProduct.description!,
          'price': _editedProduct.price.toString(),
          'imageUrl': _editedProduct.imageUrl!,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_imageUpdateUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _imageUpdateUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false).updateProduct(
        id: _editedProduct.id!,
        newProduct: _editedProduct,
      );
      // setState(() {
      //   _isLoading = false;
      // });
      // Navigator.of(context).pop();
    } else {
      try {
        Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('An error occurred'),
            content: Text(error.toString()),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
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

  @override
  Widget build(BuildContext context) {
    print(_initValues['imageUrl']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct.title = newValue!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct.price = double.parse(newValue!);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a value';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please enter a number greater than zero.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (newValue) {
                          _editedProduct.description = newValue;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.green),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? const Text(
                                    'Enter URL',
                                    textAlign: TextAlign.center,
                                  )
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              // FIXME: will not accept current image url as initial value
                              initialValue: _initValues['imageUrl']!,
                              decoration: const InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              // controller: _imageUrlController,
                              focusNode: _imageFocusNode,
                              onFieldSubmitted: (value) => _saveForm(),
                              onSaved: (newValue) {
                                _editedProduct.imageUrl = newValue!;
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
