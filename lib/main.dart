import 'package:flutter/material.dart';

void main() => runApp(JewelryCatalogApp());

class JewelryCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jewelry Catalog',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: LoginScreen(),
    );
  }
}

// Login Screen
class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Jewelry Catalog Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  TextField(controller: usernameController, decoration: InputDecoration(labelText: 'Username')),
                  TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: () => login(context), child: Text('Login')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Main Navigation
class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  List<Map<String, dynamic>> products = [
    {'title': 'Gold Ring', 'grams': 3.2, 'karat': 18, 'price': 15000, 'type': 'Ring'},
    {'title': 'Diamond Bangle', 'grams': 12.5, 'karat': 22, 'price': 72000, 'type': 'Bangle'},
    {'title': 'Gold Necklace', 'grams': 25.0, 'karat': 22, 'price': 140000, 'type': 'Necklace'},
    {'title': 'Gemstone Earring', 'grams': 5.0, 'karat': 14, 'price': 28000, 'type': 'Earring'},
    {'title': 'Plain Bracelet', 'grams': 6.5, 'karat': 18, 'price': 35000, 'type': 'Bracelet'},
  ];

  List<Map<String, dynamic>> favorites = [];

  void toggleFavorite(Map<String, dynamic> product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
      } else {
        favorites.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      FilterScreen(products: products, favorites: favorites, onToggleFavorite: toggleFavorite),
      FavoritesScreen(favorites: favorites, onToggleFavorite: toggleFavorite),
      EnquiryPage(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.pink,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.filter_alt), label: 'Filter'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.email), label: 'Enquiry'),
        ],
      ),
    );
  }
}

// Filter Screen
class FilterScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> favorites;
  final Function(Map<String, dynamic>) onToggleFavorite;

  FilterScreen({required this.products, required this.favorites, required this.onToggleFavorite});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String searchQuery = '';
  double minGrams = 0;
  double maxGrams = 100;
  int selectedKarat = 0;
  double maxPrice = 150000;
  String selectedCommodity = 'All';

  List<String> commodityOptions = ['All', 'Ring', 'Bangle', 'Necklace', 'Earring', 'Bracelet'];
  List<int> karatOptions = [0, 14, 18, 22];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = widget.products.where((product) {
      final matchSearch = product['title'].toLowerCase().contains(searchQuery.toLowerCase());
      final matchGrams = product['grams'] >= minGrams && product['grams'] <= maxGrams;
      final matchKarat = selectedKarat == 0 || product['karat'] == selectedKarat;
      final matchPrice = product['price'] <= maxPrice;
      final matchCommodity = selectedCommodity == 'All' || product['type'] == selectedCommodity;

      return matchSearch && matchGrams && matchKarat && matchPrice && matchCommodity;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Filter Catalog'), backgroundColor: Colors.pink),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(labelText: 'Search', border: OutlineInputBorder()),
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedCommodity,
                        items: commodityOptions.map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (val) => setState(() => selectedCommodity = val!),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<int>(
  isExpanded: true,
  value: selectedKarat,
  items: karatOptions.map((karat) {
    return DropdownMenuItem(
      value: karat,
      child: Text(karat == 0 ? 'All Karat' : '${karat}K'),
    );
  }).toList(),
  onChanged: (val) => setState(() => selectedKarat = val!),
)

                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Max Price: ₹${maxPrice.toInt()}'),
                    Expanded(
                      child: Slider(
                        value: maxPrice,
                        min: 10000,
                        max: 150000,
                        divisions: 14,
                        label: '₹${maxPrice.toInt()}',
                        onChanged: (val) => setState(() => maxPrice = val),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              children: filtered.map((product) {
                final isFav = widget.favorites.contains(product);
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {}, // Optional: Navigate to details
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Icon(Icons.image, size: 80, color: Colors.grey[300])),
                          Text(product['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('${product['grams']}g - ₹${product['price']}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${product['karat']}K'),
                              IconButton(
                                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.pink),
                                onPressed: () => widget.onToggleFavorite(product),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Favorites Screen
class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;
  final Function(Map<String, dynamic>) onToggleFavorite;

  FavoritesScreen({required this.favorites, required this.onToggleFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites'), backgroundColor: Colors.pink),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet.'))
          : ListView(
              children: favorites.map((product) {
                return ListTile(
                  title: Text(product['title']),
                  subtitle: Text('${product['grams']}g - ₹${product['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.pink),
                    onPressed: () => onToggleFavorite(product),
                  ),
                );
              }).toList(),
            ),
    );
  }
}

// Enquiry Page
class EnquiryPage extends StatelessWidget {
  final TextEditingController enquiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enquiry'), backgroundColor: Colors.pink),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: enquiryController,
              decoration: InputDecoration(labelText: 'Your enquiry', border: OutlineInputBorder()),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => enquiryController.clear(),
              child: Text('Submit Enquiry'),
            ),
          ],
        ),
      ),
    );
  }
}
