import 'package:ekonomi_app/ana_sayfa.dart';
import 'package:ekonomi_app/personel_bilgisi.dart';
import 'package:ekonomi_app/stock_Bilgisi.dart';
import 'package:ekonomi_app/usersDao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StockKayit extends StatefulWidget {
  @override
  State<StockKayit> createState() => _StockKayitState();
}

class _StockKayitState extends State<StockKayit> {
  var tfStockAdi = TextEditingController();
  var tfStockAdeti = TextEditingController();
  var tfStockTanitim = TextEditingController();
  var tfStockXXL = TextEditingController();
  var tfStockXL = TextEditingController();
  var tfStockL = TextEditingController();
  var tfStockM = TextEditingController();
  var tfStockS = TextEditingController();

  Future<void> kayit() async {
    await usersDao().stockEkle(
      stockName: tfStockAdi.text,
      stockAdet: tfStockAdeti.text,
      stockTanitim: tfStockTanitim.text,
      stockXXL: tfStockXXL.text,
      stockXL: tfStockXL.text,
      stockL: tfStockL.text,
      stockM: tfStockM.text,
      stockS: tfStockS.text,
    );
  }

  Widget buildTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Center(
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(),
              icon: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(icon),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.shopping_bag, size: 80, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Yeni Ürün Kaydı",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildTextField(
                      hintText: "Ürün Adı", icon: Icons.shopping_basket, controller: tfStockAdi),
                  buildTextField(
                      hintText: "Toplam Adet", icon: Icons.numbers, controller: tfStockAdeti, inputType: TextInputType.number),
                  buildTextField(
                      hintText: "Ürün Açıklaması", icon: Icons.description, controller: tfStockTanitim),
                  buildTextField(
                      hintText: "XXL/44  Adet", icon: Icons.format_size, controller: tfStockXXL, inputType: TextInputType.number),
                  buildTextField(
                      hintText: "XL/43 Adet", icon: Icons.format_size, controller: tfStockXL, inputType: TextInputType.number),
                  buildTextField(
                      hintText: "L/42 Adet", icon: Icons.format_size, controller: tfStockL, inputType: TextInputType.number),
                  buildTextField(
                      hintText: "M/41 Adet", icon: Icons.format_size, controller: tfStockM, inputType: TextInputType.number),
                  buildTextField(
                      hintText: "S/40 Adet", icon: Icons.format_size, controller: tfStockS, inputType: TextInputType.number),
                  SizedBox(height: 25),

                  // Kayıt Butonu
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(.9),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (tfStockAdi.text.isEmpty || tfStockAdeti.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Lütfen ürün adı ve toplam adet alanını doldurun!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        kayit();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (builder) => stock_Bilgisi()),
                        );
                      },
                      child: Text(
                        "Kaydet",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
