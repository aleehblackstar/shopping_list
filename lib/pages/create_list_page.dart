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
      backgroundColor: Colors.blue, 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: TextField(
                controller: _controller,
                key: const Key("listNameInput"), 
                decoration: const InputDecoration(
                  hintText: "Nome da lista",
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    key: const Key("backToListsBtn"),
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Voltar", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 20),
                // Botão Criar
                Expanded(
                  child: ElevatedButton(
                    key: const Key("createListBtn"),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        Navigator.pop(context, _controller.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Criar", style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}