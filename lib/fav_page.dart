import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    Center(child: Text("Menu")),
    Center(child: Text("Favorit")),
    Center(child: Text("Library")),
    Center(child: Text("Custom")),
  ];

  void _onTapBottomNav(int index) {
    if (index == 0) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final drawerItems = const [
    {'icon': Icons.table_bar, 'label': 'Denah Meja'},
    {'icon': Icons.point_of_sale, 'label': 'Point of Sale'},
    {'icon': Icons.shopping_cart, 'label': 'Pesanan Online'},
    {'icon': Icons.timeline, 'label': 'Aktivitas'},
    {'icon': Icons.inventory, 'label': 'Inventori'},
    {'icon': Icons.schedule, 'label': 'Shift'},
    {'icon': Icons.settings, 'label': 'Pengaturan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: Colors.blue[800],
          child: ListView(
            padding: const EdgeInsets.only(top: 48.0),
            children: drawerItems.map((item) {
              return ListTile(
                leading: Icon(item['icon'] as IconData, color: Colors.white),
                title: Text(
                  item['label'] as String,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
              );
            }).toList(),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Text(
              'ERPivo Fav',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[800],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onTapBottomNav,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Custom'),
        ],
      ),
    );
  }
}
