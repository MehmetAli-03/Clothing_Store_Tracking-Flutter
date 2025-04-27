import 'package:ekonomi_app/ana_sayfa.dart';
import 'package:ekonomi_app/personel_bilgisi.dart';
import 'package:ekonomi_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'usersDao.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _HomePageState();
}

class _HomePageState extends State<login> {
  bool _obscureText = true;
  var tfKisiAdi = TextEditingController();
  var tfKisiSifre = TextEditingController();

  Future<int?> giris(String kisi_ad, String kisi_password) async {
    return await usersDao().girisKontrol(kisi_ad, kisi_password);
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
                  Image.asset("assets/logo2.png", height: 250),
                  SizedBox(height: 30),

                  // Kullanıcı Adı TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
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

                  // Giriş Butonu
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
                      onPressed: () async {
                        String kullaniciAdi = tfKisiAdi.text;
                        String sifre = tfKisiSifre.text;

                        if (kullaniciAdi.isEmpty || sifre.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Lütfen kullanıcı adı ve şifreyi girin!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        int? kullaniciId = await giris(kullaniciAdi, sifre);

                        if (kullaniciId != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Giriş başarılı!'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          await Future.delayed(Duration(milliseconds: 500));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      home_page()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Kullanıcı adı veya şifre hatalı!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Giriş Yap",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Kayıt Ol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Henüz Kayıtlı Değil misin? ",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (builder) => Signup()),
                          );
                        },
                        child: Text(
                          "Kayıt Ol",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
