import 'package:flutter/material.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({super.key});

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Nova Lista", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const Key("inputListName"),
              controller: _controller,
              decoration: const InputDecoration(hintText: "Nome da lista"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key("createListBtn"),
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: const Text("Criar"),
            ),
          ],
        ),
      ),
    );
  }
}