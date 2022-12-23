import 'package:apk_api/controllers/log-cont.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController(text: "Muh. Irfan Ali");
  final TextEditingController _emailController = TextEditingController(text: "gentan77@gmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "password");
  final TextEditingController _confirmpasswordController =
      TextEditingController(text: "password");
  final _registerKey = GlobalKey<FormState>();

  LogController register = LogController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 230, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 53, 255),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Welcome to Register :D',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Container(
              decoration:  BoxDecoration(
                color : Colors.white,
                borderRadius: BorderRadius.circular(20)
                ),
            child: Form(
              key: _registerKey,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                      ),
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
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password confirmation is required';
                        } else if (value.length < 8) {
                          return 'Password confirmation must be at least 8 characters';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: _confirmpasswordController,
                      decoration: const InputDecoration(
                        hintText: 'Password Confirmation',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 40, 0, 15),
                      child: MaterialButton(
                        onPressed: () async {
                          if (_registerKey.currentState!.validate()) {
                            bool response = await register.postRegister(
                              _usernameController.text,
                              _emailController.text,
                              _passwordController.text,
                              _confirmpasswordController.text,
                            );
                            if (response) {
                              Navigator.of(context).popAndPushNamed('/login');
                            } else {}
                          }
                        },
                        color: const Color.fromARGB(255, 26, 53, 255),
                        minWidth: 200,
                        height: 60,
                        child: Text(
                          "Register Now",
                          style:
                              const TextStyle(color: const Color(0xFFF4EEFF), fontSize: 20),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?",
                        style: TextStyle(fontSize: 12),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 26, 53, 255),
                            ),
                          ),
                          child: const Text(
                            "Do Login!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 26, 53, 255),
                              fontSize: 12,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),   
          ),
       ),
      ),
   );
  }
}
