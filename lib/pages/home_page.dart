import 'package:flutter/material.dart';
import 'package:shopping_list/pages/create_list_page.dart';
import '../models/shopping_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShoppingListModel> shoppingLists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Minhas listas", 
          key: Key("appBarTitle"),
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.diamond, color: Colors.yellow),
          ),
        ],
      ),
      // Se a lista estiver vazia, mostra a tela de boas-vindas. 
      // Caso contrário, mostra as listas.
      body: SafeArea(
        child: shoppingLists.isEmpty ? _buildEmptyState() : _buildListView()),
      
      floatingActionButton: FloatingActionButton(
        key: const Key("addListBtn"),
        onPressed: () async {
          final String? listName = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CreateListPage()),
  );

  if (listName != null && listName.isNotEmpty) {
    setState(() {
      // Cria a nova lista usando o nosso Model
      shoppingLists.add(ShoppingListModel(name: listName, products: []));
    });
  }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Widget para o estado vazio
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Image.asset(
            "assets/images/lista-de-compras.png",
            key: const Key("emptylistimage"),
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            "Crie sua primeira lista\nToque no botao azul",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Widget para a listagem (vazio por enquanto)
  Widget _buildListView() {
    return const Center(child: Text("Suas listas aparecerão aqui!"));
  }
}