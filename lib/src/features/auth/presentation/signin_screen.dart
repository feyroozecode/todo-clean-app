import 'package:flutter/material.dart';

import '../../home/presentation/home_screen.dart';

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

  // Email validation pattern

  /// Pattern de validation pour l'email
  /// Vérifie que l'email respecte le format standard:
  /// - Partie locale: lettres, chiffres, points, tirets (avant le @)
  /// - @ obligatoire
  /// - Domaine: lettres, chiffres, tirets
  /// - Extension: 2 à 4 caractères (.com, .fr, etc.)
  ///
  /// Exemples valides:
  /// - utilisateur@gmail.com
  final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

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
      } else if (_emailController.text == "ibr@gmail.com" &&
          _passwordController.text == "123456") {
        
        showDialog(
            context: context,
            builder: (context) => Builder(
                builder: (c) => const AlertDialog(
                    contentPadding: EdgeInsets.only(top: 200, bottom: 200),
                    title: Text('Connexion'),
                    content: Center(
                        child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ))
                  )
                )
            );

        // wait 3 seonds and navigate with Future
        await Future.delayed(const Duration(seconds: 3), () {
          /// LOADING
          // Connexion réussie
          // Redirection vers la page d'accueil
          Navigator.pushReplacement(context.mounted ? context : context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      } else {
        // Connexion échouée
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email ou mot de passe incorrect'),
          ),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    if (!emailPattern.hasMatch(value)) {
                      return 'Veuillez entrer un email valide';
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
                  obscureText: true,
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
