import 'package:flutter/material.dart';
import 'package:apk_api/controllers/cat-cont.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({super.key});

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  @override
  final _addkategorikey = GlobalKey<FormState>();
  final TextEditingController _addkategori = TextEditingController();
  kategoriController kat = kategoriController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 230, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 53, 255),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Create Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        width: 1000,
        height: 400,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
               height: 20,
            ),
            const Text(
            'Create New Category',
            style: TextStyle(
              color: Color.fromARGB(255, 88, 107, 255),
              fontSize: 40,
              fontWeight: FontWeight.bold,
             ),
           ),
          Form(
            key: _addkategorikey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category should not empty';
                      }
                    },
                    controller: _addkategori,
                    decoration: const InputDecoration(
                      labelText: 'Category name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(255, 26, 53, 255)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: const Color.fromARGB(255, 26, 53, 255),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 26, 53, 255),
                        ),
                      ),
                      onPressed: () async {
                        if (_addkategorikey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          await kat
                              .addCategories(
                                _addkategori.text,
                              )
                              .then((value) => Navigator.of(context)
                                  .popAndPushNamed('/homepage'));
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
           ],
        ),
      ),
    );
  }
}