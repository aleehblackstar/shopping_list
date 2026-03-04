import 'package:flutter/material.dart';
import 'create_list_page.dart';
import 'details_page.dart';
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
      body: SafeArea(
        child: shoppingLists.isEmpty ? _buildEmptyState() : _buildListView(),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key("addListBtn"),
        onPressed: () async {
          final String? listName = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateListPage()),
          );

          if (listName != null && listName.isNotEmpty) {
            setState(() {
              shoppingLists.add(ShoppingListModel(name: listName, products: []));
            });
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

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

  Widget _buildListView() {
    return ListView.builder(
      itemCount: shoppingLists.length,
      itemBuilder: (context, index) {
        final list = shoppingLists[index];
        return GestureDetector(
          key: const Key("shoppingListCard"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(shoppingList: list),
              ),
            ).then((_) => setState(() {}));
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        list.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        list.progressText,
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: list.progressPercentage,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}