import 'package:flutter/material.dart';

class DashboardPage2 extends StatelessWidget {
  const DashboardPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.point_of_sale, 'label': 'Transaksi'},
      {'icon': Icons.inventory_2, 'label': 'Stok Barang'},
      {'icon': Icons.shopping_cart, 'label': 'Pengadaan'},
      {'icon': Icons.precision_manufacturing, 'label': 'Produksi'},
      {'icon': Icons.pie_chart, 'label': 'Laporan'},
      {'icon': Icons.settings, 'label': 'Pengaturan'},
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('ERPivo Dashboard'),
      //   backgroundColor: Colors.blueAccent,
      // ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Dapatkan ukuran layar
          final screenWidth = constraints.maxWidth;

          // Tentukan jumlah kolom berdasarkan lebar layar
          int crossAxisCount = 2;
          if (screenWidth > 600) crossAxisCount = 3;
          if (screenWidth > 900) crossAxisCount = 4;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: menuItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1, // kotak proporsional
              ),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: screenWidth * 0.08,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['label'] as String,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
