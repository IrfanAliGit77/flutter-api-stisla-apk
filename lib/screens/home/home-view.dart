import 'package:flutter/material.dart';
import 'package:apk_api/models/kategori.dart';
import 'package:apk_api/controllers/cat-cont.dart';
import 'package:apk_api/controllers/log-cont.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final logout = LogController();

  List<Kategori> listKat = [];
  final kat = KategoriController();

  getCategories() async {
    listKat = await kat.getCategories();
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 204, 230, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 53, 255),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Halaman Home',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        width: 5000,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: kat.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView(
                      children: (snapshot.data ?? [])
                          .map(
                            (e) => Card(
                              margin: EdgeInsets.all(4.0),
                              color: Colors.blueGrey[50],
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 330,
                                      child: Text(
                                        e.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        var data = await Navigator.of(context)
                                            .pushNamed('/kategori/edit',
                                                arguments: [e.id, e.name]);
                                        if (data != null) {
                                          await getCategories();
                                          setState(() {});
                                        }
                                      },
                                      color: const Color.fromARGB(255, 26, 53, 255),
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text('Delete Kategori'),
                                          backgroundColor:
                                              Color.fromARGB(255, 255, 255, 255),
                                          content: const Text(
                                              'Apakah anda akan yakin menghapus?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'Tidak'),
                                              child: const Text(
                                                'Tidak',
                                                style: TextStyle(
                                                    color: Color.fromARGB(255, 26, 53, 255)),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async => {
                                                await kat.delete(e),
                                                setState(() {}),
                                                Navigator.pop(context, 'Ya'),
                                              },
                                              child: const Text(
                                                'Ya',
                                                style: TextStyle(
                                                    color: Color.fromARGB(255, 26, 53, 255)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
              child: MaterialButton(
                minWidth: 500,
                height: 50,
                child:  Text(
                  "Create New Category",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: const Color.fromARGB(255, 26, 53, 255),
                onPressed: () {
                  Navigator.pushNamed(context, '/kategori/create');
                },
              ),
            ),
             MaterialButton(
              minWidth: 150,
              height: 50,
              child: Text(
                "Logout",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: const Color.fromARGB(255, 26, 53, 255),
              onPressed: () {
                logout.postDataOut().then(
                      (value) =>
                          Navigator.of(context).popAndPushNamed('/login'),
                    );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        ),
      );
  }
}