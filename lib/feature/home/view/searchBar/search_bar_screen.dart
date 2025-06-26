
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                // Поле пошуку
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:   Color(0xFFFFA600),
                            width: 2), // Синя рамка при фокусі
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: 'Поиск...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon:
                                  const Icon(Icons.clear, color: Color(0xFFFFD700)),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                // Кнопка "Відмінити"
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Повертаємося назад
                  },
                  child: const Text(
                    'Отменить',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 195, 185, 185),
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: _searchText.isEmpty
          ? const Center(
              child: Text(
                'Найдите товар....',
                style: TextStyle(color: Colors.white70, fontSize: 20),
              ),
            )
          : _buildSearchResults(),
    );
  }

  /// Функція для побудови результатів пошуку
  Widget _buildSearchResults() {
    
    final List<String> results = ['iPhone 13', 'MacBook Pro', 'AirPods Pro'];

    // Фільтрація результатів
    final List<String> filteredResults = results
        .where((item) => item.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.device_hub, color: Colors.white),
          title: Text(
            filteredResults[index],
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            print('Вибрано: ${filteredResults[index]}');
            Navigator.pop(context); // Повертаємося назад після вибору
          },
        );
      },
    );
  }
}
