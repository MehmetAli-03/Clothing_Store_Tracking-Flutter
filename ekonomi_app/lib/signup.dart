import 'package:ekonomi_app/ana_sayfa.dart';
import 'package:ekonomi_app/logİn.dart';
import 'package:ekonomi_app/usersDao.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _HomePageState();
}

class _HomePageState extends State<Signup> {
  bool _obscureText = true; //visibilty için
  var tfKisiAdi = TextEditingController(); // textfield içinde bilgi alır
  var tfKisiSifre = TextEditingController();

  Future<void> kayit(String kisi_ad, String kisi_password) async {
    await usersDao().kisiEkle(kisi_ad, kisi_password);
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
                      Icon(Icons.person, size: 80, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Yeni Kullanıcı Kaydı",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  // Kullanıcı Adı TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          controller: tfKisiAdi,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText: "Kullanıcı Adı",
                            hintStyle: GoogleFonts.poppins(),
                            icon: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.person),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Parola TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          controller: tfKisiSifre,
                          obscureText: _obscureText,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText: "Parola",
                            hintStyle: GoogleFonts.poppins(),
                            icon: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          obscureText: _obscureText,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText: "Yeniden Parola",
                            hintStyle: GoogleFonts.poppins(),
                            icon: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),


                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        String kullaniciAdi = tfKisiAdi.text;
                        String sifre = tfKisiSifre.text;
                          // boş mu diye kontrol etti
                        if (kullaniciAdi.isEmpty || sifre.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Lütfen kullanıcı adı ve şifreyi girin!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        //hata yoksa kayıt yaptı ve giris ekranına attı
                        kayit(kullaniciAdi, sifre);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (builder) => login()),
                        );
                      },
                      child: Text(
                        "Kayıt Ol",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Giriş Yap Linki
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Zaten Hesabım Var ",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (builder) => login()),
                          );
                        },
                        child: Text(
                          "Giriş Yap",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
