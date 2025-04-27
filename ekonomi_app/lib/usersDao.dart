import 'package:ekonomi_app/gelir.dart';
import 'package:ekonomi_app/gider.dart';
import 'package:ekonomi_app/person.dart';
import 'package:ekonomi_app/stock.dart';
import 'package:ekonomi_app/users.dart';
import 'package:ekonomi_app/gelir.dart';
import 'package:sqflite/sqflite.dart';

import 'veritabaniyardimcisi.dart';

class usersDao {
  Future<List<Person>> tumPersonel() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT *FROM person");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      print("Toplam personel sayısııııııı: ${maps.length}");

      return Person(
        satir["person_id"],
        satir["person_name"],
        satir["person_surname"],
        satir["person_age"],
        satir["person_phone"],
        satir["person_job"],
        satir["person_sale"],
        satir["person_cinsiyet"],
      );
    });
  }

  Future<void> kisiEkle(String kisi_ad, String kisi_sifre) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String, dynamic>();
    bilgiler["user_name"] = kisi_ad;
    bilgiler["user_password"] = kisi_sifre;

    await db.insert("users", bilgiler);
  }

  Future<int?> girisKontrol(String kisi_ad, String kisi_sifre) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> sonuc = await db.rawQuery(
      "SELECT * FROM users WHERE user_name = ? AND user_password = ?",
      [kisi_ad, kisi_sifre],
    );

    if (sonuc.isNotEmpty) {
      return sonuc.first["userd_id"];
    } else {
      return null;
    }
  }

  Future<void> PersonelEkle(
    String kisi_ad,
    String kisi_soyad,
    String kisi_meslek,
    String kisi_yas,
    String kisi_maas,
    String kisi_cinsiyet,
    String kisi_tel,
  ) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = <String, dynamic>{
      "person_name": kisi_ad,
      "person_surname": kisi_soyad,
      "person_job": kisi_meslek,
      "person_age": kisi_yas,
      "person_sale": kisi_maas,
      "person_cinsiyet": kisi_cinsiyet,
      "person_phone": kisi_tel,
    };

    await db.insert("person", bilgiler);
  }

  Future<void> PersonelSil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("person", where: "person_id=?", whereArgs: [kisi_id]);
  }

  Future<List<Gelir>> tumGelirler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT *FROM gelir");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Gelir(satir["gelir_id"], satir["gelir_name"], satir["gelir_fiyat"],satir["gelir_tarih"]);
    });
  }
  Future<void> GelirEkle(String kisi_ad,String kisi_tel,String kisi_tarih) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();
    bilgiler["gelir_name"] = kisi_ad;
    bilgiler["gelir_fiyat"] = kisi_tel;
    bilgiler["gelir_tarih"] = kisi_tarih;

    await db.insert("gelir", bilgiler);
  }
  Future<void> GelirSil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("gelir",where: "gelir_id=?",whereArgs: [kisi_id]);
  }
  Future<List<Gider>> tumGiderler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT *FROM gider");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Gider(satir["gider_id"], satir["gider_name"], satir["gider_fiyat"],satir["gider_tarih"]);
    });
  }
  Future<void> GiderEkle(String kisi_ad,String kisi_tel,String kisi_tarih) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();
    bilgiler["gider_name"] = kisi_ad;
    bilgiler["gider_fiyat"] = kisi_tel;
    bilgiler["gider_tarih"] = kisi_tarih;

    await db.insert("gider", bilgiler);
  }
  Future<void> GiderSil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("gider",where: "gider_id=?",whereArgs: [kisi_id]);
  }
  Future<int> toplamGelir() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var sonuc = await db.rawQuery("SELECT SUM(gelir_fiyat) as toplamGelir FROM gelir");

    if (sonuc.isNotEmpty && sonuc.first["toplamGelir"] != null) {
      return int.parse(sonuc.first["toplamGelir"].toString());
    } else {
      return 0;
    }
  }
  Future<int> toplamGider() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var sonuc = await db.rawQuery("SELECT SUM(gider_fiyat) as toplamGider FROM gider");

    if (sonuc.isNotEmpty && sonuc.first["toplamGider"] != null) {
      return int.parse(sonuc.first["toplamGider"].toString());
    } else {
      return 0;
    }
  }
  Future<int> toplamPersonel() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var sonuc = await db.rawQuery("SELECT COUNT(*) as toplamPersonel FROM person");

    int toplam = Sqflite.firstIntValue(sonuc) ?? 0;

    return toplam;
  }
  Future<int> toplamPersonelGideri() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var sonuc = await db.rawQuery("SELECT SUM(person_sale) as toplamPersonelGider FROM person");

    int toplam = Sqflite.firstIntValue(sonuc) ?? 0;

    return toplam;
  }
  Future<void> stockEkle({
    required String stockName,
    String? stockTanitim,
    String? stockAdet,
    String? stockXXL,
    String? stockXL,
    String? stockL,
    String? stockM,
    String? stockS,
  }) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = <String, dynamic>{
      "stock_name": stockName,
      "stock_tanitim": stockTanitim ?? "Açıklama yok",
      "stock_adet": stockAdet ?? "0",
      "stock_XXl": stockXXL ?? "0",
      "stock_Xl": stockXL ?? "0",
      "stock_L": stockL ?? "0",
      "stock_M": stockM ?? "0",
      "stock_S": stockS ?? "0",
    };

    await db.insert("stock", bilgiler);
  }

  Future<List<Stock>> tumStock() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT *FROM stock");

    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Stock(
        stock_id: satir["stock_id"],
        stock_name: satir["stock_name"],
        stock_tanitim: satir["stock_tanitim"],
        stock_adet: satir["stock_adet"]?.toString() ?? "0",
        stock_XXl: satir["stock_XXL"]?.toString() ?? "0",
        stock_Xl: satir["stock_XL"]?.toString() ?? "0",
        stock_L: satir["stock_L"]?.toString() ?? "0",
        stock_M: satir["stock_M"]?.toString() ?? "0",
        stock_S: satir["stock_S"]?.toString() ?? "0",
      );
    });;

  }
  Future<int> toplamStock() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var sonuc = await db.rawQuery("SELECT SUM(stock_adet) as toplamStock FROM stock");

    if (sonuc.isNotEmpty && sonuc.first["toplamStock"] != null) {
      return int.parse(sonuc.first["toplamStock"].toString());
    } else {
      return 0;
    }
  }
  Future<void> StockSil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("stock",where: "stock_id=?",whereArgs: [kisi_id]);
  }
  Future<void> stockGuncelle({
    required int stock_id,
    required String stockAdet,
    required String stockXXL,
    required String stockXL,
    required String stockL,
    required String stockM,
    required String stockS,
  }) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var bilgiler = {
      "stock_adet": stockAdet,
      "stock_XXl": stockXXL,
      "stock_Xl": stockXL,
      "stock_L": stockL,
      "stock_M": stockM,
      "stock_S": stockS,
    };
    await db.update("stock", bilgiler, where: "stock_id = ?", whereArgs: [stock_id]);
  }


}
