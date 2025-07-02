import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_nime/widget/app_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  static const routeName = '/profile';
  final String title;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Usuario';
  String _email = 'ejemplo@email.com';
  String? _imagePath;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? _name;
      _email = prefs.getString('email') ?? _email;
      _imagePath = prefs.getString('imagePath');
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name);
    await prefs.setString('email', _email);
    if (_imagePath != null) await prefs.setString('imagePath', _imagePath!);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final dir = await getApplicationDocumentsDirectory();
      final localPath = '${dir.path}/profile.jpg';
      final file = File(pickedFile.path);
      await file.copy(localPath);
      setState(() {
        _imagePath = localPath;
      });
      _saveProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _pickImage,
              child: ClipOval(
                child:
                    _imagePath != null
                        ? Image.file(
                          File(_imagePath!),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          'assets/perfil.jpg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              _email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar perfil'),
              onTap: () {
                _showEditDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                // lógica para cerrar sesión
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Eliminar perfil'),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                setState(() {
                  _name = 'Usuario';
                  _email = 'ejemplo@email.com';
                  _imagePath = null;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog() {
    final nameController = TextEditingController(text: _name);
    final emailController = TextEditingController(text: _email);

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Editar perfil'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Correo'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Guardar'),
                onPressed: () {
                  setState(() {
                    _name = nameController.text.trim();
                    _email = emailController.text.trim();
                  });
                  _saveProfile();
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
    );
  }
}
