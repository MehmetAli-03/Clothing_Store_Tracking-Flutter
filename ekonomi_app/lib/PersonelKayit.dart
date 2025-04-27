import 'package:ekonomi_app/ana_sayfa.dart';
import 'package:ekonomi_app/personel_bilgisi.dart';
import 'package:ekonomi_app/usersDao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Personelkayit extends StatefulWidget {
  @override
  State<Personelkayit> createState() => _HomePageState();
}

class _HomePageState extends State<Personelkayit> {
  var tfKisiAdi = TextEditingController();
  var tfKisiSoyadi = TextEditingController();
  var tfKisiMeslegi = TextEditingController();
  var tfKisiYasi = TextEditingController();
  var tfKisiNumarasi = TextEditingController();
  var tfKisiMaasi = TextEditingController();
  var tfKisiCinsiyeti = TextEditingController();

  Future<void> kayit() async {
    await usersDao().PersonelEkle(
      tfKisiAdi.text,
      tfKisiSoyadi.text,
      tfKisiMeslegi.text,
      tfKisiYasi.text,
      tfKisiMaasi.text,
      tfKisiCinsiyeti.text,
      tfKisiNumarasi.text,
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
                      Icon(Icons.person_add, size: 80, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Yeni Personel Kaydı",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildTextField(hintText: "Personel Adı", icon: Icons.person, controller: tfKisiAdi),
                  buildTextField(hintText: "Personel Soyadı", icon: Icons.person, controller: tfKisiSoyadi),
                  buildTextField(hintText: "Mesleği", icon: Icons.work, controller: tfKisiMeslegi),
                  buildTextField(
                      hintText: "Yaşı", icon: Icons.cake, controller: tfKisiYasi, inputType: TextInputType.number),
                  buildTextField(
                      hintText: "Maaşı", icon: Icons.attach_money, controller: tfKisiMaasi, inputType: TextInputType.number),
                  buildTextField(hintText: "Cinsiyeti", icon: Icons.wc, controller: tfKisiCinsiyeti),
                  buildTextField(
                      hintText: "Telefon Numarası", icon: Icons.phone, controller: tfKisiNumarasi, inputType: TextInputType.phone),
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
                        if (tfKisiAdi.text.isEmpty ||
                            tfKisiSoyadi.text.isEmpty ||
                            tfKisiMeslegi.text.isEmpty ||
                            tfKisiYasi.text.isEmpty ||
                            tfKisiMaasi.text.isEmpty ||
                            tfKisiCinsiyeti.text.isEmpty ||
                            tfKisiNumarasi.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Lütfen tüm alanları doldurun!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        kayit();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (builder) => PersonelBilgisi()),
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
