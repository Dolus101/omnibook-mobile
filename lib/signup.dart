import 'package:flutter/material.dart';
import 'package:omnibook/login.dart'; // Import your login page

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole; // Variable to store selected role
  String? _selectedDepartment; // Variable to store selected department

  // Text editing controllers to retrieve values from text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when not needed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _idController.dispose();
    super.dispose();
  }

void _signUp() {
  if (_formKey.currentState!.validate()) {
    // Show a custom loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 150,
              width: 250,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Signing up...',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Simulate a delay for the sign-up process (you can replace this with actual logic)
    Future.delayed(const Duration(seconds: 3), () {
      // Close the dialog
      Navigator.of(context).pop();

      // After sign up, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Login')),
      );
    });
  }
}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset('lib/images/logo.png', height: 80),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'OMNIBOOK',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Welcome! Please Sign up.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // First Name Field
                Center(
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Last Name Field
                Center(
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Username Field
                Center(
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Password Field
                Center(
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Dropdown Field for Department
                Center(
                  child: SizedBox(
                    width: 280,
                    child: DropdownButtonFormField<String>(
                      value: _selectedDepartment,
                      decoration: const InputDecoration(
                        labelText: 'Department',
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      items: ['CCS', 'CTE', 'CJE', 'COC', 'PSYCHOLOGY']
                          .map((label) => DropdownMenuItem(
                                value: label,
                                child: Text(label),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDepartment = value; // Store selected department
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a department.';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Student ID Field
                Center(
                  child: SizedBox(
                    width: 280,
                    child: TextFormField(
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: 'School ID number',
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Sign-up button
                Center(
                  child: SizedBox(
                    width: 280,
                    child: ElevatedButton.icon(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 71, 100, 248),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      label: const Text('Sign up'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Already have an account? Log in
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an account?',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the login page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Login')),
                          );
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 71, 100, 248),
                          ),
                        ),
                      ),
                    ],
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
