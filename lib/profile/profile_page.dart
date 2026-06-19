import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  late BuildContext profileContext;

  @override
  Widget build(BuildContext context) {

    profileContext = context;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Perfil'),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildProfileImage(),
          const SizedBox(height: 16),
          _buildUserName(),
          const SizedBox(height: 8),
          _buildUserEmail(),
          const SizedBox(height: 32),
          _buildProfileOptions(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return const CircleAvatar(
      radius: 60,
      backgroundImage: NetworkImage(
        'https://i.pravatar.cc/300',
      ),
    );
  }

  Widget _buildUserName() {
    return const Text(
      'João Silva',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildUserEmail() {
    return const Text(
      'joao.silva@email.com',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildProfileOptions() {
    return Column(
      children: [
        _buildOptionTile(
          icon: Icons.person,
          title: 'Editar Perfil',
          onTap: _onEditProfilePressed,
        ),
        _buildOptionTile(
          icon: Icons.lock,
          title: 'Alterar Senha',
          onTap: _onChangePasswordPressed,
        ),
        _buildOptionTile(
          icon: Icons.settings,
          title: 'Configurações',
          onTap: _onSettingsPressed,
        ),
        _buildOptionTile(
          icon: Icons.logout,
          title: 'Sair',
          onTap: _onLogoutPressed,
        ),
      ],
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: _onBottomNavigationItemPressed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
    );
  }

  void _onBottomNavigationItemPressed(int index) {
    debugPrint('Item selecionado: $index');
  }

  void _onEditProfilePressed() {
    debugPrint('Editar perfil');
  }

  void _onChangePasswordPressed() {
    debugPrint('Alterar senha');
  }

  void _onSettingsPressed() {
    debugPrint('Abrir configurações');
  }

  void _onLogoutPressed() {
    Navigator.pop(profileContext);
  }
}