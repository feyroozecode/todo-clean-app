import 'package:flutter/material.dart';

import 'home_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _emailError = 'Email invalide';
  final String _passwordError = 'Mot de passe invalide';

  final _formKey = GlobalKey<FormState>();

  // handle connexion
  Future<void> handleSignin() async {
    if (_formKey.currentState!.validate()) {
      if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
        // Email et mot de passe vides
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez remplir tous les champs'),
          ),
        );
        return;
      } else if (_emailController.text != "abc@gmail.com" &&
          _passwordController.text != "123456") {
        // Connexion échouée
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email ou mot de passe incorrect'),
          ),
        );
      } else {
        // Connexion réussie
        // Redirection vers la page d'accueil
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connexion'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _emailError;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _passwordError;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => handleSignin(),
                  child: const Text('Connexion'),
                ),
              ],
            ),
          )),
        ));
  }
}
