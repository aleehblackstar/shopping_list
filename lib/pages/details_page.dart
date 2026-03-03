import 'package:flutter/material.dart';
import '../models/shopping_list_model.dart';
import '../models/product_model.dart';

class DetailsPage extends StatefulWidget {
  final ShoppingListModel shoppingList;

  const DetailsPage({super.key, required this.shoppingList});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
 
  void _openAddItemModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (context) => _buildBottomSheet(),
    ).then((value) {
      if (value != null) setState(() {}); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            key: const Key("updateListBtn"), 
            onPressed: () => setState(() {}),
            child: const Text("Atualizar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.shoppingList.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _buildSummary(), 
              const SizedBox(height: 20),
              Expanded(child: _buildProductList()), 
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key("addNewItemBtn"), 
        onPressed: _openAddItemModal,
        label: const Text("Adicionar", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
    );
  }


  Widget _buildSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _summaryItem("Não marcados", widget.shoppingList.totalNotBought, Colors.blue),
        const SizedBox(width: 40),
        _summaryItem("Marcados", widget.shoppingList.totalBought, Colors.green),
      ],
    );
  }

  Widget _summaryItem(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Text(
          "R\$ ${value.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }


  Widget _buildProductList() {
    return ListView.builder(
      itemCount: widget.shoppingList.products.length,
      itemBuilder: (context, index) {
        final product = widget.shoppingList.products[index];
        return ListTile(
          leading: Transform.scale(
            scale: 1.5, 
            child: Checkbox(
              key: const Key("productCheckbox"), 
              value: product.isBought,
              shape: const CircleBorder(),
              onChanged: (val) => setState(() => product.isBought = val!),
            ),
          ),
          title: Text(product.name),
          trailing: Text("R\$ ${product.value.toStringAsFixed(2)}"),
        );
      },
    );
  }

  // O BottomSheet (Modal de cadastro)
  Widget _buildBottomSheet() {
    final nameController = TextEditingController();
    final valueController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Ajuste para o teclado
        left: 20, right: 20, top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Adicionar Item", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          TextField(
            key: const Key("inputItem"), 
            controller: nameController,
            decoration: const InputDecoration(hintText: "Nome do item"),
          ),
          TextField(
            key: const Key("inputValue"),
            controller: valueController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "R\$ 0,00"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            key: const Key("addItemBtn"), 
            onPressed: () {
              if (nameController.text.isNotEmpty && valueController.text.isNotEmpty) {
                widget.shoppingList.products.add(ProductModel(
                  name: nameController.text,
                  value: double.tryParse(valueController.text.replaceFirst(',', '.')) ?? 0.0,
                ));
                Navigator.pop(context, true);
              }
            },
            child: const Text("Adicionar"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}