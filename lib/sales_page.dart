// main.dart

import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  String orderType = 'Dine In';
  List<Map<String, dynamic>> products = [
    {'name': 'Baso Aci', 'price': 12000, 'img': '🍲'},
    {'name': 'Donuts', 'price': 10000, 'img': '🍩'},
    {'name': 'Coffee', 'price': 15000, 'img': '☕'},
    {'name': 'Sushi', 'price': 22000, 'img': '🍣'},
    {'name': 'BBQ Chicken', 'price': 25000, 'img': '🍗'},
    {'name': 'Juice', 'price': 8000, 'img': '🥤'},
  ];

  List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      final existing = cart.indexWhere(
        (item) => item['name'] == product['name'],
      );
      if (existing != -1) {
        cart[existing]['qty']++;
        cart[existing]['total'] =
            cart[existing]['qty'] * cart[existing]['price'];
      } else {
        cart.add({
          'name': product['name'],
          'price': product['price'],
          'img': product['img'],
          'qty': 1,
          'total': product['price'],
        });
      }
    });
  }

  void showAddCustomerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Pelanggan'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Nama Pelanggan'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  String generateReceiptString() {
    final buffer = StringBuffer();
    final now = DateTime.now();

    buffer.writeln('UMKM');
    buffer.writeln('Nama Toko');
    buffer.writeln('Telp. 081xxxxxxxx');
    buffer.writeln('================================');
    buffer.writeln('TRX          : TR001');
    buffer.writeln('Kasir        : admin');
    buffer.writeln(
      'Tanggal   : ${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}',
    );
    buffer.writeln('================================');
    buffer.writeln('Harga                   Qty                 Total');

    for (var item in cart) {
      buffer.writeln('${item['name']}');
      buffer.writeln(
        'Rp${item['price']}                 x${item['qty']}                 Rp${item['total']}',
      );
    }

    buffer.writeln('================================');
    int total = cart.fold(0, (sum, item) => sum + (item['total'] as int));
    buffer.writeln('Total Diskon      : Rp0,-');
    buffer.writeln('Total Bayar        : Rp$total,-');
    buffer.writeln('Dibayar             : Rp$total,-');
    // buffer.writeln('Kembali            : Rp0,-');
    buffer.writeln('================================');
    buffer.writeln('TERIMA KASIH');
    buffer.writeln('ATAS KUNJUNGAN ANDA');
    return buffer.toString();
  }

  void showReceiptModal() {
    final receiptText = generateReceiptString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Struk Pembayaran'),
          content: SingleChildScrollView(
            child: SelectableText(
              receiptText,
              style: TextStyle(fontFamily: 'Courier'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Print'),
            ),
          ],
        );
      },
    );
  }

  void showPaymentModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Metode Pembayaran'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Tunai')),
              ElevatedButton(onPressed: () {}, child: Text('QRIS')),
              ElevatedButton(onPressed: () {}, child: Text('Kartu')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final productCardWidth = 100.0;
    final cartPanelWidth = 320.0;
    final horizontalPadding = 16.0;
    final availableWidth = screenWidth - cartPanelWidth - horizontalPadding * 2;
    final productCrossAxisCount = availableWidth ~/ (productCardWidth + 16);

    return Scaffold(
      appBar: AppBar(title: Text('Transaksi')),
      body: Row(
        children: [
          // Produk Panel
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: productCrossAxisCount > 0
                            ? productCrossAxisCount
                            : 1,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () => addToCart(product),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product['img'],
                                    style: TextStyle(fontSize: 32),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Rp ${product['price']}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Keranjang Panel
          Container(
            width: cartPanelWidth,
            color: Colors.grey[100],
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: showAddCustomerDialog,
                      child: Text('+ Tambah Pelanggan'),
                    ),
                    DropdownButton<String>(
                      value: orderType,
                      onChanged: (value) {
                        setState(() {
                          orderType = value!;
                        });
                      },
                      items: ['Dine In', 'Take Away']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text(item['img'])),
                        title: Text(item['name']),
                        subtitle: Text('Qty: ${item['qty']}'),
                        trailing: Text('Rp ${item['total']}'),
                      );
                    },
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Simpan Bill'),
                    ),
                    ElevatedButton(
                      onPressed: showReceiptModal,
                      child: Text('Cetak Bill'),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: showPaymentModal,
                    child: Text(
                      'Bayar Rp ${cart.fold<int>(0, (int sum, item) => sum + (item['total'] as int))}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
