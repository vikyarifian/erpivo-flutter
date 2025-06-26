import 'package:erpivo/dashboard.dart';
import 'package:erpivo/sales_page.dart';
import 'package:flutter/material.dart';

class DashbiardPage extends StatefulWidget {
  const DashbiardPage({super.key});

  @override
  State<DashbiardPage> createState() => _DashbiardPageState();
}

class _DashbiardPageState extends State<DashbiardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    Center(child: Text("Menu")),
    Center(child: DashboardPage2()),
    Center(child: SalesPage()),
    Center(child: Text("Library")),
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
    // {'icon': Icons.table_bar, 'label': 'Denah Meja'},
    {'icon': Icons.point_of_sale, 'label': 'Transaksi'},
    // {'icon': Icons.shopping_cart, 'label': 'Pesanan Online'},
    {'icon': Icons.timeline, 'label': 'Aktivitas'},
    {'icon': Icons.inventory, 'label': 'Stok Barang'},
    // {'icon': Icons.schedule, 'label': 'Shift'},
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
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SalesPage()),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: 16),
            // const Text(
            //   'ERPivo',
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 16),
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
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashbard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Library'),
        ],
      ),
    );
  }
}
