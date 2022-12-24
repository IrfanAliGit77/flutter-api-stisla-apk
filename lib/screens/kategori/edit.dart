import 'package:flutter/material.dart';
import 'package:apk_api/controllers/cat-cont.dart';

class UpdateKat extends StatefulWidget {
  const UpdateKat({super.key});

  @override
  State<UpdateKat> createState() => _UpdateKatState();
}

class _UpdateKatState extends State<UpdateKat> {
  final TextEditingController _katname = TextEditingController();

  final KategoriController kat = KategoriController();
  final _upkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    if (args[1] != null) {
      _katname.text = args[1];
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF4EEFF),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 53, 255),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit Category Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Update Category',
            style: TextStyle(
              color: const Color.fromARGB(255, 26, 53, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
            key: _upkey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category should not empty';
                      }
                    },
                    controller: _katname,
                    decoration: const InputDecoration(
                      labelText: 'Category name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: const Color.fromARGB(255, 26, 53, 255),
                        ),
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
                          const Color.fromARGB(255, 26, 53, 255)
                        ),
                      ),
                      onPressed: () async {
                        if (_upkey.currentState!.validate()) {
                          kat.edit(args[0], _katname.text).then(
                                (value) => Navigator.of(context).pop(true),
                              );
                        }
                      },
                      child: const Text('Submit', style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
