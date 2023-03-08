public class Day04 {
    /*
    --									ALIASES
-- Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir.



CREATE TABLE calisanlar5  (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar5 VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO calisanlar5 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar5 VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM calisanlar5
SELECT calisan_id as id FROM calisanlar5

-- Eğer iki sutunun verilerini birleştirmek istersek concat sembolu || kullanırız
SELECT calisan_id AS id, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar2
--2. YOl
SELECT calisan_id AS id, concat (calisan_isim,calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar2





-- IS NULL CONDITION
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');
select * from insanlar
-- Name sutununda null olan değerleri listeleyelim
SELECT name FROM insanlar WHERE name IS NULL
-- Insanlar taplosunda sadece null olmayan değerleri listeleyiniz
SELECT name FROM insanlar WHERE name IS NOT NULL
-- Insanlar toplasunda null değer almış verileri no name olarak değiştiriniz
UPDATE insanlar
SET name='no name'
WHERE name is null;



/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar (ASC)
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız

--ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama yapmak icin kullanilir
--ORDER BY komutu sadece SELECT komutu Ile kullanilir
*/
/*
    CREATE TABLE insanlar2
            (
                    ssn char(9),
    isim varchar(50),
    soyisim varchar(50),
    adres varchar(50)
);
    INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
    INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara');
    INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara');
    INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
    INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara');
    INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

    SELECT * FROM insanlar2
--Insanlar tablosundaki datalari adres’e gore siralayin
    SELECT * FROM insanlar2 ORDER BY adres;
    SELECT * FROM insanlar2 ORDER BY soyisim;


--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
    SELECT * FROM insanlar2 WHERE isim='Mine' ORDER BY ssn;


-- 								ORDER BY CLAUSE
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir

NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
*/
/*
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
    select * from insanlar2 where soyisim='Bulut' ORDER BY 2;


--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
    SELECT * FROM insanlar ORDER BY ssn DESC; --DESC tersten siraladi.


--Insanlar tablosundaki tum kayitlari isimler Natural sirali, soyisimler ters sirali olarak listeleyin.
            SELECT * FROM insanlar2 ORDER BY isim ASC, soyisim DESC;



/*
Eger sutun uzunluguna gore siralamak istersek length komutu kullaniriz
Ve yine uzunlugu buyukten kucuge siralamak istersek sonuna DESC komutunu ekleriz.
 */
/*
-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız

    SELECT isim,soyisim FROM insanlar2 ORDER BY LENGTH (soyisim) DESC;


-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız.

    SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH(isim||soyisim)
    SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH (isim)+LENGTH (soyisim)
    SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar2 ORDER BY LENGTH (isim)+LENGTH (soyisim)
    SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar2 ORDER BY LENGTH (concat(isim,soyisim))


            -- 									GROUP BY CLAUSE
-- Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
-- komutuyla birlikte kullanılır.

    CREATE TABLE manav
            (
                    isim varchar(50),
    Urun_adi varchar(50),
    Urun_miktar int
);
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

    SELECT * FROM manav;
--Isme gore alinan toplam urunleri bulun.

    SELECT isim,sum(urun_miktar) AS aldigi_toplam_urun FROM manav
    GROUP BY isim;

-- Isme gore alinan toplam urunleri bulun ve urunleri buyukten kucuge listeleyiniz
    SELECT isim,sum(urun_miktar) AS aldigi_toplam_urun FROM manav
    GROUP BY isim
    ORDER BY aldigi_toplam_urun DESC; --az once order by da as kullanamadik ama burda sum old icin izin verdi



-- Urun ismine gore urunu alan toplam kisi sayisi(--Soru : Kim kac farkli cesit urun almis.)




     */
}
