import 'package:flutter/material.dart';

import '../common/app_routes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  late BuildContext pageContext;

  @override
  Widget build(BuildContext context) {

    pageContext = context;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Login'),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 32),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 24),
          _buildLoginButton(),
          const SizedBox(height: 24),
          _buildRegisterLink(pageContext),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Acesse sua conta',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailField() {
    return const TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget _buildPasswordField() {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Senha',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _onLoginPressed,
        child: const Text('Entrar'),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => _openRegistrationPage(context),
        child: const Text(
          'Criar nova conta',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  void _openRegistrationPage(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerPage);
  }

  void _onLoginPressed() {
    Navigator.pushNamed(pageContext, AppRoutes.quizPage);
  }
}