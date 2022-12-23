import 'package:apk_api/controllers/log-cont.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const MainApp(),
      },
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController(text: "superadmin@gmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "password");

  LogController loginC = LogController();
  final _loginKey = GlobalKey<FormState>();
  bool isLoginFalse = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 204, 230, 253),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 26, 53, 255),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Halaman Login',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Image(
                      width: 450,
                      image: AssetImage(
                        '../../img/image.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration:  BoxDecoration(
                       color : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    child: Form(
                      key: _loginKey,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          const SizedBox(
                              height: 20,
                          ),
                          const SizedBox(
                              height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                            controller: _emailController,
                            cursorColor: const Color.fromARGB(255, 26, 53, 255),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                              hintText: 'Email',
                            ),
                          ),
                          const SizedBox(
                              height: 20,
                            ),
                          TextFormField(
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            obscureText: true,
                            controller: _passwordController,
                            cursorColor: const Color.fromARGB(255, 26, 53, 255),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                              hintText: 'Password',
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 40, 0, 15),
                            child: MaterialButton(
                              color: const Color.fromARGB(255, 26, 53, 255),
                              onPressed: () async {
                                if (_loginKey.currentState!.validate()) {
                                  bool response = await loginC.postData(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  if (response) {
                                    Navigator.of(context).popAndPushNamed('/homepage');
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Failed Login'),
                                        backgroundColor: Color(0xFFDCD6F7),
                                        content:
                                            const Text('Incorrect email or password'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text(
                                              'OK',
                                              style:
                                                  TextStyle(color: Color.fromARGB(255, 26, 53, 255)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // child: const Text('Show Dialog'),
                                    );
                                    setState(() {
                                      isLoginFalse = true;
                                    });
                                  }
                                }
                              },
                              minWidth: 150,
                              height: 50,
                              child: const Text(
                                "Login",
                                style:
                                    TextStyle(color: Color(0xFFF4EEFF), fontSize: 20),
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?",
                              style: TextStyle(fontSize: 12),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 26, 53, 255),
                                  ),
                                ),
                                child: const Text(
                                  "Please Register Now!",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 26, 53, 255),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
