import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildProfileImage(),
            const SizedBox(height: 16),
            _buildUserName(),
            const SizedBox(height: 8),
            _buildUserEmail(),
            const SizedBox(height: 32),
            _buildProfileOptions(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B1FA2).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
      ),
    );
  }

  Widget _buildUserName() {
    return const Text(
      'Usuária',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildUserEmail() {
    return const Text(
      'usuario@email.com',
      style: TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Column(
      children: [
        _buildOptionTile(
          icon: Icons.person_outline,
          title: 'Editar Perfil',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.lock_outline,
          title: 'Alterar Senha',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.settings_outlined,
          title: 'Configurações',
          onTap: () {},
        ),
        _buildOptionTile(
          icon: Icons.logout,
          title: 'Sair',
          onTap: () => Navigator.pop(context),
          isDestructive: true,
        ),
      ],
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.red.shade400 : const Color(0xFF7B1FA2);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red.shade400 : null,
            fontWeight: isDestructive ? FontWeight.w500 : null,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
        onTap: onTap,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: const Color(0xFF7B1FA2),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Configurações'),
      ],
    );
  }
}
