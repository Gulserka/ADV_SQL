public class Day02 {
    /*
    CREATE TABLE ogrenciler1
            (
                    ogrenci_no char(7),
    isim varchar(20),
    soyisim varchar(25),
    not_ort real, --ondalikli sayilar icin kullanilir(Double gibi)
    kayit_tarihi date --en son biterken ; koymaya gerek yok.
--Burda normalde de koymaya gerek yok gerci de
);
--VAR OLAN BIR TABLODAN YENI BIR TABLO OLUSTURMA
    CREATE TABLE NOTLAR
            AS
    SELECT isim,not_ort FROM ogrenciler1;

    select*from notlar;--yaptigimiz tabloyu getirsin diye

--INSERT - TABLO ICINE VERI EKLEME
    INSERT INTO notlar VALUES ('Erol', 75.5); --icindeki erolu silip baska isim eklesek de
--onceki de tabloda gorunuyor.

    INSERT INTO notlar VALUES ('Gulser', 75.5);
    INSERT INTO notlar VALUES ('Hulya', 75.5);
    INSERT INTO notlar VALUES ('Rumeysa', 75.5);
    INSERT INTO notlar VALUES ('Orhan', 75.5);
    INSERT INTO notlar VALUES ('Ali', 75.5);
    INSERT INTO notlar VALUES ('Musa', 75.5);

    select * from notlar;

    Create table talebeler
            (
                    isim varchar (10),
    notlar real
);
--INSERT-TABLO ICINE VERI EKLEME
    INSERT INTO talebeler VALUES ('Gulser', 75.5);
    INSERT INTO talebeler VALUES ('Hulya', 75.5);
    INSERT INTO talebeler VALUES ('Rumeysa', 75.5);
    INSERT INTO talebeler VALUES ('Orhan', 75.5);
    INSERT INTO talebeler VALUES ('Ali', 75.5);
    INSERT INTO talebeler VALUES ('Musa', 75.5);
    select * from talebeler;


    select isim from notlar;  --bunda sadece isimler geliyor.

            --CONSTRAINT
--UNIQUE

    CREATE TABLE ogrenciler6
            (
                    ogrenci_no char(7) unique,
    isim varchar(20) not null, --bunu constraint olarak gostermiyor.
    soyisim varchar(25),
    not_ort real,
    kayit_tarihi date
);
    select * from ogrenciler6;
    INSERT INTO ogrenciler6 VALUES('1234567','Gulser','Kayacan',75.5,now());
    INSERT INTO ogrenciler6 VALUES('1234568','Rumeysa','Gungor',75.5,now());
    INSERT INTO ogrenciler6 (ogrenci_no,soyisim,not_ort) VALUES ('1234568','Kayacan',85.5); --NOT NULL kisitlamasi old icin bu veri eklenemez.

            --PRIMARY KEY ATAMASI
    CREATE TABLE ogrenciler7
            (
                    ogrenci_no char(7) PRIMARY KEY ,  --Primary key constrainttir. O yuzden burda tablolarin oldugu yerde constraints kismina bakarsak orda gorebiliriz.
            isim varchar(20), --bunu constraint olarak gostermiyor.
    soyisim varchar(25),
    not_ort real,
    kayit_tarihi date
);

--PRIMARY KEY ATAMASI 2.YOL
--Eger CONSTRAINT ismini kendimiz vermek istersek bu yolu kullanabiliriz.
--CONSTRAINT kisitlama demek. Tabloya veri eklerken bu kısıtlamayı temel alıyoruz.
    CREATE TABLE ogrenciler8
            (
                    ogrenci_no char(7),
    isim varchar(20),
    soyisim varchar(25),
    not_ort real,
    kayit_tarihi date, --date den sonra , koyulur ama burda
    CONSTRAINT ogr PRIMARY KEY(ogrenci_no,isim) --COMPOSITE PK. BOYLE 2.YOLLA yaptigimiz zaman hem isim verebiliyoruz hem de primary key olarak 2tane yazabiliyoruz.
            --Iki tane yazmamiz su demek aslinda ornegin turktelekom kendi adimin yaninda annemin kizlik soyadini da soruyo
    CONSTRAINT ogr11 unique(soyisim,not_ort)--unique de de boyle iki tane yapabiliyoruz
);

--PRIMARY KEY ATAMASI 3.YOL

    CREATE TABLE ogrenciler9
            (
                    ogrenci_no char(7),
    isim varchar(20),
    soyisim varchar(25),
    not_ort real,
    kayit_tarihi date,
    PRIMARY KEY(ogrenci_no)
);

    /*PRACTICE:
    "sehirler isimli bir table olusturun.
    Tabloda "alan_kodu", "isim","nufus" fieldlari olsun.
    Isim field i bos birakilmasin.
    1.Yontemi kullanarak "alan_kodu" fieldini "Primary Key" yapin.
    */

    /*
    CREATE TABLE sehirler
            (
                    alan_kodu char(5) PRIMARY KEY,
    isim varchar(20) NOT NULL,
    nufus real
);
*/


/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
/*
    CREATE TABLE tedarikciler3
            (
                    tedarikci_id char(10) PRIMARY KEY,
    tedarikci_ismi varchar(50),
    iletisim_isim varchar(50)
);

    CREATE TABLE urunler
            (
                    tedarikci_id char(10),
    product_id char(10),
    FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
            );

    select * from tedarikciler3
    select * from urunler


/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun.
“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun.
“adres_id” field‘i ile Foreign Key oluşturun.
*/
/*
    CREATE TABLE calisanlar
            (
                    id varchar(15) PRIMARY KEY,
    isim varchar (30) UNIQUE,
    maas int NOT NULL, --real da olur
    ise_baslama date
);

    CREATE TABLE adresler
            (
                    adres_id varchar (30),
    sokak varchar(30),
    cadde varchar(30),
    sehir varchar(30),
    FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
            );


    INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10010',' Mehmet Yılmaz', 5000, '2018-04-14'); --UNIQUE CONS. old icin kabul etmedi
    INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--NOT NULL CONS. Kabul etmez.
    INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE CONS. old icin kabul etmedi
    INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--int dedik srtring girmeye calisiyoruz kabul etmez
    INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');--PRIMARY KEY hicligi kabul etti.
    INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--2.hicligi kabul etmez ama cunku unique
    INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
    INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--NULL Kabul etmez.



    INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
    INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
    INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
    INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
    INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

    SELECT * FROM calisanlar;
    SELECT * FROM adresler;


 --CHECK CONSTRAINT
    CREATE TABLE calisanlar2
            (
                    id varchar(15) PRIMARY KEY,
    isim varchar (30) UNIQUE,
    maas int CHECK(maas>10000) NOT NULL,--HEM CHECK HEM NOT NULL KABUL EDIYOR.
--CHECK numericlerde kullaniliyor bu arada.
            ise_baslama date
);
    INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');
    SELECT * FROM calisanlar1;


--DQL --WHERE KULLANIMI

    SELECT * FROM calisanlar;
    SELECT isim FROM calisanlar;

--Calisanlar tablosundan maasi 5000den buyuk olan isimleri listeleyin.
    SELECT isim,maas FROM calisanlar WHERE maas>5000; --check olayi tablo olustururken. where tablonun ici

--Calisanlar tablosundan ismi Veli Han olan tum verileri listeleyin. (tum dedigi icin * kullandik. * yerine
--isim deseydik sadece ismini getircekti ama bu sekilde velihanin butun verilerini getirdi)

    SELECT * FROM calisanlar WHERE isim='Veli Han';

--Calisanlar tablosundan maasi 5000 olan tum verileri listeleyin.
    SELECT * FROM calisanlar WHERE maas=5000;



--DML --DELETE KOMUTU (DATA MANIPULATION)
    DELETE FROM calisanlar; --Eger parent tablo baska bir child tablo ile iliskili ise once child tablo silinmelidir.
    DELETE FROM adresler;--adreslerin icindeki verileri siliyor. Adres tablosunu silmiyo.
            SELECT * FROM adresler;

--Adresler tablosundan sehri Antep olan verileri silelim.
    DELETE FROM adresler WHERE sehir='Antep';



--SORU----------------------------
    CREATE TABLE ogrencilerpratik
            (
                    id int,
                    isim VARCHAR(50),
    veli_isim VARCHAR(50),
    yazili_notu int
);

    INSERT INTO ogrencilerpratik VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO ogrencilerpratik VALUES(124, 'Merve Gul', 'Ayse',85);
    INSERT INTO ogrencilerpratik VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrencilerpratik VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
    INSERT INTO ogrencilerpratik VALUES(127, 'Mustafa Bak', 'Can',99);
    INSERT INTO ogrencilerpratik VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
    DELETE FROM ogrencilerpratik WHERE isim='Nesibe Yilmaz' OR isim='Mustafa Bak';
    SELECT * FROM ogrencilerpratik;


 */

}
