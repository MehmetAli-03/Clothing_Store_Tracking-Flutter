import 'package:ekonomi_app/ana_sayfa.dart';
import 'package:ekonomi_app/gelirBilgisi.dart';
import 'package:ekonomi_app/giderBilgisi.dart';
import 'package:ekonomi_app/personel_bilgisi.dart';
import 'package:ekonomi_app/usersDao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GiderEkle extends StatefulWidget {
  @override
  State<GiderEkle> createState() => _HomePageState();
}

class _HomePageState extends State<GiderEkle> {
  var tfGiderAdi = TextEditingController();
  var tfGiderFiyati = TextEditingController();
  var tfGiderTarihi = TextEditingController();

  Future<void> kayit() async {
    await usersDao().GiderEkle(
      tfGiderAdi.text,
      tfGiderFiyati.text,
      tfGiderTarihi.text,
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
        child: SingleChildScrollView(
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
                      Icon(Icons.add_card_rounded, size: 80, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Gider Kaydı Ekle",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  buildTextField(hintText: "Gider Adı", icon: Icons.abc, controller: tfGiderAdi),
                  buildTextField(hintText: "Gider Fiyatı", icon: Icons.attach_money, controller: tfGiderFiyati),
                  buildTextField(hintText: "Tarih", icon: Icons.date_range, controller: tfGiderTarihi),
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
                        kayit();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (builder) =>Giderbilgisi()),
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
