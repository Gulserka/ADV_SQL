CREATE TABLE film
(
id int ,
title VARCHAR(50),
type VARCHAR(50),
length int
);
INSERT INTO film VALUES (1, 'Kuzuların Sessizliği', 'Korku',130);
INSERT INTO film VALUES (2, 'Esaretin Bedeli', 'Macera', 125);
INSERT INTO film VALUES (3, 'Kısa Film', 'Macera',40);
INSERT INTO film VALUES (4, 'Shrek', 'Animasyon',85);
CREATE TABLE actor
(
id int ,
isim VARCHAR(50),
soyisim VARCHAR(50)
);
INSERT INTO actor VALUES (1, 'Christian', 'Bale');
INSERT INTO actor VALUES (2, 'Kevin', 'Spacey');
INSERT INTO actor VALUES (3, 'Edward', 'Norton');



do $$
declare
	counter integer :=1;
	first_name varchar(50) :='John';
	last_name varchar(50)  :='Doe';
	payment numeric(4,2)   :=20.5;
begin
	raise notice '% % % has been paid % USD',
				counter,
				first_name,
				last_name,
				payment;
end $$;
-- Task 1 : değişkenler oluşturarak ekrana " Ahmet ve Mehmet beyler 120 tl ye bilet aldılar.
--"" cümlesini ekrana basınız
do $$
declare

	first_person varchar(50) :='Ahmet';
	second_person varchar(50)  :='Mehmet';
	payment numeric(3)   :=120;
begin
	raise notice '% ve %  beyler % tl ye bilet aldilar',

				first_person,
				second_person,
				payment;
end $$;
--***********************Bekletme Komudu*************************
do $$
declare
	created_at time := now();
begin
	raise notice '%', created_at;
	perform pg_sleep (10); --10 saniye bekleniyor
	raise notice '%', created_at; --cıktıda ayni deger gorunecek
end $$;
--******************Tablodan Data Tipini Kopyalama**********************
/*
		-> variable_name  table_name.column_name%type;
		->( Tablodaki datanın aynı data türünde variable oluşturmaya yarıyor)
	*/

do $$
declare
	film_title film.title%type;  -- varchar;
begin
	-- 1 id li filmin ismini getirelim
	select title
	from film
	into film_title  -- film_title = 'Kuzuların Sessizliği'
	where id=1;

	raise notice 'Film title id 1 : %' , film_title;
end $$ ;
--******************İC İCE BLOK YAPILARI**********************
do $$
<<outher_block>>
declare
	counter integer :=0;
begin
	counter := counter +1;
	raise notice 'The current value of counter is %', counter;

	declare
		counter integer :=0;
	begin
		counter := counter +10;
		raise notice 'Counter in the subBlock is %', counter;
		raise notice 'Counter in the OutherBlock is %', outher_block.counter; --counter.counter dedigimizde ic blocktaki counter geliyor sanirim
		--ic blok olusmadan disardakinden icine ulasamayiz. o yuzden yazacaksak icerde olustuktan sonra onun altina yazicaz
	end;

	raise notice 'Counter in the outherBlock is %', counter;
end outher_block $$;

--******************Row Type**********************
do $$
declare
	selected_actor actor%rowtype;
begin
	select *
	from actor
	into selected_actor --id,isim,soyisim
	where id=2;

	raise notice 'The actor name is % %',
					selected_actor.isim,--sanki class mis gibi islem yapiyoruz. oradan cagiriyoruz
					Selected_actor.soyisim;
end $$;


--BURDA SUBQUERY YAPABILIRIZ EGER ALT ALTA BASKA IDLERI YAZDIRMAK ISTIYOSAK MESELA:
do $$
declare
	selected_actor actor%rowtype;
begin
 select *
 from actor
 into selected_actor --actor table indaki veriler buun icine gelir
 where id=1;
 raise notice 'The actor name is % %',
  				selected_actor.isim,
				selected_actor.soyisim;
begin
 select *
 from actor
 into selected_actor --actor table indaki veriler buun icine gelir
 where id=2;
 raise notice 'The actor name is % %',
  				selected_actor.isim,
				selected_actor.soyisim;
	end;
	begin
 select *
 from actor
 into selected_actor --actor table indaki veriler buun icine gelir
 where id=3;
 raise notice 'The actor name is % %',
  				selected_actor.isim,
				selected_actor.soyisim;
 end;
end $$ ;




-- *********************** Record Type *********************
	/*
		-> Row Type gibi çalışır ama record un tamamı değilde belli başlıkları almak
		istersek kullanılabilir. Bu daha elverisli dedi hoca daha az yer kapliyo cunku direkt hepsini yazdirmadigimiz icin
	*/

	do $$
declare
	rec	record; -- record data türünde rec isminde değişken oluşturuldu
begin
	select id,title,type
	into rec
	from film
	where id = 1;

	raise notice '% % %' , rec.id, rec.title, rec.type;
end $$ ;


-- ********** Constant ****************
--final keyword, degistirilemez

do $$
declare
	vat	constant numeric := 0.1;
	net_price	numeric := 20.5;

begin
	raise notice 'Satış fiyatı : %' , net_price*(1+vat);
	-- vat := 0.05; -- constant bir ifadeyi ilk setleme işleminden sonra değer değiştirmeye çalışırsak hata alırız

end $$ ;

-- constant bir ifadeye RT da değer verebilir miyim ??? (run time da)
--cevap evet: asagidaki ornek:

do $$
declare
	start_at constant time := now();

begin
	raise notice 'bloğun çalışma zamanı : %', start_at;

end $$ ;






-- //////////////////// Control Structures ///////////////////////
-- ******************** If Statement ****************
-- syntax :
/*
	if condition  then
			statement;
	end if ;
*/

-- Task : 1 id li filmi bulalım eğer yoksa ekrana uyarı yazısı verelim

do $$
declare
	istenen_film film%rowtype;
	istenen_filmId film.id%type := 10;

begin
	select * from film
	into istenen_film
	where id = istenen_filmId;

	if not found then
		raise notice 'Girdiğiniz id li film bulunamadı : %', istenen_filmId;
	end if;

end $$;




-- Task : 1 idli film varsa title bilgisini yazınız yoksa uyarı yazısını ekrana basınız

do $$
declare

	selected_film film%rowtype;
	input_film_id film.id%type :=10;

begin
	select * from film
	into selected_film
	where id = input_film_id;

	if not found then
		raise notice 'Girmiş olduğunuz id li film bulunamadı : %', input_film_id;
	else
		raise notice 'Filmin ismi : %', selected_film.title; --selected_film artik o obje gibi davraniyo
	end if;

end $$;




-- ************* IF-THEN-ELSE-IF ************************
-- syntax :
/*
    IF condition_1 THEN
                statement_1;
        ELSEIF condition_2 THEN
                statement_2;
        ELSEIF condition_3 THEN
                statement_3;
        ELSE
                statement_final;
    END IF ;
*/
/*
    Task : 1 id li film varsa ;
            süresi 50 dakikanın altında ise Short,
            50<length<120 ise Medium,
            length>120 ise Long yazalım
*/


do $$
declare
    v_film film%rowtype;
    len_description varchar(50);
begin
    select * from film
    into v_film  --- v_film.id = 1  / v_film.title ='Kuzuların Sessizliği'
    where id = 30;

    if not found then
        raise notice 'Filim bulunamadı';
    else
        if v_film.length > 0 and v_film.length <=50 then
                len_description='Short';
            elseif v_film.length>50 and v_film.length<120 then
                len_description='Medium';
            elseif v_film.length>120 then
                len_description='Long';
            else
                len_description='Tanımlanamıyor';
         end if;
     raise notice ' % filminin süresi : %', v_film.title, len_description;
     end if;
end $$;



-- ******** Case Statement **************************
-- syntax :

 /*

    CASE search-expression
     WHEN expression_1 [, expression_2,..] THEN
        statement
     [..]
     [ELSE
        else-statement]
     END case;
 */


-- Task : Filmin türüne göre çocuklara uygun olup olmadığını ekrana yazalım
do $$
declare
    uyari varchar(50);
    tur film.type%type;
begin
    select type from film
    into tur
    where id = 4;

    if found then
        case tur
            when 'Korku' then uyari='Çocuklar için uygun değildir'; --or ile birlestirebiliriz ayni tur olanlari
            when 'Macera' then uyari='Çocuklar için uygun';
            when 'Animasyon' then uyari ='Çocuklar için tavsiye edilir';
            else
                uyari='Tanımlanamadı';
        end case;
        raise notice '%', uyari;
    end if;
end $$;





--Task 1 : Film tablosundaki film sayısı 10 dan az ise "Film sayısı az" yazdırın,
--			10 dan çok ise "Film sayısı yeterli" yazdıralım
​
do $$
declare
	sayi integer :=0;

begin
	SELECT count(*) FROM film  -- 4
	into sayi; -- sayi=4

	if (sayi<10) then
			raise notice 'Filim sayısı az';
		else
			raise notice 'Filim sayısı yeterli';
	end if;
end $$;





-- Task 2: user_age isminde integer data türünde bir değişken tanımlayıp default
--	olarak bir değer verelim, If yapısı ile girilen değer 18 den büyük ise
--	Access Granted, küçük ise Access Denied yazdıralım..

DO $$
DECLARE
	user_age integer :=25;

BEGIN

	IF user_age>18 THEN
		RAISE NOTICE 'Access Granted';
	END IF;

	IF user_age<18 THEN
		RAISE NOTICE 'Acess Denied';
	END IF;

END $$;

-- 2.YOL :

do $$
declare
	user_age integer := 20;
begin
	if(user_age>18) then
		raise notice 'Access Granted';
	else
		raise notice 'Access Denied';
	end if;
end $$




-- Task 4 : kullaniciYasi isimli bir değişken oluşturup default değerini verin,
--	girilen yaş 18 den büyükse "Oy kullanabilirsiniz", 18 den küçük ise
--	"Oy kullanamazsınız" yazısını yazalım.

DO $$
DECLARE
	kullaniciYasi integer :=13;

BEGIN

	IF kullaniciYasi>18 THEN
		RAISE NOTICE 'Oy kullanabilirsiniz';
		ELSE
			RAISE NOTICE 'Oy kullanamazsınız';
	END IF;

END $$ ;



--  ************** LOOP *************************************

-- syntax

LOOP
	statement;
END LOOP;

-- loop u sonlandırmak için loopun içine if yapısını kullanabilirz :

LOOP
	statements;
	IF condition THEN
		exit; -- loop dan çıkmamı sağlıyor
	END IF;
END LOOP;

-- nested loop

<<outher>>
LOOP
	statements;
	<<inner>>
	LOOP
		.....
		exit <<inner>>
		END LOOP;
END LOOP;




-- Task : Fibonacci serisinde, belli bir sıradaki sayıyı ekrana getirelim

-- Fibonacci Serisi : 1,1,2,3,5,8,13,...

DO $$
DECLARE
	n integer :=40;  --kacinci siradaki sayiyi istiyosak
	counter integer :=0;--sayac
	i integer :=0; --eleman
	j integer :=1; --eleman
	fib integer :=0; --n. siradaki fib. elemani

BEGIN
	if(n<1) then
		fib:=0;
	end if;
	loop
		exit when counter =n;
		counter := counter +1;
		select j, (i+j) into i,j;
	end loop;
	fib:=i;
	raise notice '%', fib;

END $$;






-- Task : 1 dan 4 e kadar counter değerlerini ekrana basalım

DO $$
DECLARE
	n integer :=4;
	counter integer :=0;

BEGIN
	WHILE counter<n LOOP
		counter:=counter+1;
		raise notice '%', counter;
	END LOOP;

END $$;

-- Cevap 2:

DO $$

DECLARE
	counter integer :=0;

BEGIN
	WHILE counter<5 LOOP
		counter := counter+1;
		raise notice '%', counter;
	END LOOP;

END $$ ;







-- Task : sayac isminde bir degisken olusturun ve dongu icinde sayaci birer artirin,
--	her dongude sayacin degerini ekrana basin ve sayac degeri 5 e esit olunca donguden cikin

do $$
DECLARE
	counter integer := 0;

BEGIN
	LOOP
		RAISE NOTICE '%', counter;
		counter := counter +1;
		EXIT WHEN counter =5;
	END LOOP;
END $$;





-- **************  FOR LOOP *********************
-- syntax
for loop_counter in [reverse] from..to [by step] loop
    statements;
end loop ;
-- in ( Ornek )
do $$
begin
    for counter in 1..6 loop
        raise notice 'counter: %', counter;
    end loop;
end $$;
-- reverse ( Ornek )
do $$
begin
    for counter in reverse 5..1 loop
        raise notice 'counter : %', counter;
    end loop;
end $$;
-- by ( Ornek )
do $$
begin
    for counter in 0..10 by 2 loop
        raise notice 'counter : %', counter;
    end loop;
end $$;
-- Task : 10 dan 20 ye kadar 2 ser 2 ser ekrana sayilari basalim :
do $$
begin
    for counter in 10..20 by 2 loop
        raise notice 'conter : %', counter ;
    end loop;
end $$;
-- Task : olusturulan array'in elemanlarini array seklinde gosterelim :
do $$
declare
    array_int int[] := array[11,22,33,44,55,66,77,88];
    var int[];
begin
    for var in select array_int loop
        raise notice '%', var;
    end loop;
end $$;
-- DB de loop kullanimi
--syntax :
for target in query loop
    statement
end loop;
-- Task : Filmleri süresine göre sıraladığımızda en uzun 2 filmi gösterelim
for target in query loop
    statement
end loop;
do $$
declare
    f record;
begin
    for f in select title, length from film order by length desc limit 2 loop
        raise notice '% ( % dakika )', f.title,f.length;
    end loop;
end $$;
CREATE TABLE employees (
  employee_id serial PRIMARY KEY,
  full_name VARCHAR NOT NULL,
  manager_id INT
);
INSERT INTO employees (
  employee_id,
  full_name,
  manager_id
)
VALUES
  (1, 'M.S Dhoni', NULL),
  (2, 'Sachin Tendulkar', 1),
  (3, 'R. Sharma', 1),
  (4, 'S. Raina', 1),
  (5, 'B. Kumar', 1),
  (6, 'Y. Singh', 2),
  (7, 'Virender Sehwag ', 2),
  (8, 'Ajinkya Rahane', 2),
  (9, 'Shikhar Dhawan', 2),
  (10, 'Mohammed Shami', 3),
  (11, 'Shreyas Iyer', 3),
  (12, 'Mayank Agarwal', 3),
  (13, 'K. L. Rahul', 3),
  (14, 'Hardik Pandya', 4),
  (15, 'Dinesh Karthik', 4),
  (16, 'Jasprit Bumrah', 7),
  (17, 'Kuldeep Yadav', 7),
  (18, 'Yuzvendra Chahal', 8),
  (19, 'Rishabh Pant', 8),
  (20, 'Sanju Samson', 8);
-- Task :  employee ID si en buyuk ilk 10 kisiyi ekrana yazalim
do $$
declare
    f record;
begin
    for f in select employee_id, full_name from employees order by employee_id desc limit 10 loop
        raise notice '% - %', f.employee_id, f.full_name;
    end loop;
end $$;
-- ******** EXIT *************
exit when counter > 10 ;
-- yukardakini if ile yazmak istersem
-- alttaki ve ustteki kod ayni isi yapiyor
if counter > 10 then
    exit;
end if;
-- Ornek
do $$
begin
    <<inner_block>>
    begin
        exit inner_block;
        raise notice 'inner block dan merhaba';
    end;

    raise notice 'outher blockdan merhaba';
end $$;

-- ************** CONTINUE ****************
-- mevcut iterasyonu atmalak icin kullanilir
-- syntax :
continue [loop_label] [when condition] -- [] bu kısımlar opsiyoneldir
-- Task : continue yapisi kullanarak 1 dahil 10 a kadar olan tek sayilari ekrana basalim
do $$
declare
    counter integer := 0;
begin
    loop
        counter := counter + 1; -- loop icinde counter degerim 1 artiriliyor
        exit when counter > 10; -- counter degerim 10 dan buyuk olursa loop dan cik
        continue when mod(counter,2)=0; -- counter cift ise bu iterasyonu terk et
        raise notice '%', counter; -- counter degerimi ekrana basiyorum
    end loop ;
end $$;

-- ********************************************************
--  ********************* FUNCTION ***********************
-- ********************************************************
-- syntax :
create [or replace] function function_name(param_list)
    returns return_type -- donen data turunu belirliyorum
    language plpgsql -- kullanilan prosedurel dili tanimliyor
    as

    $$
    declare
    begin

    end $$;

-- Film tablomuzdaki belirli sure arasindaki filmlerin sayisini getiren bir fonsiyon yazalim

create or replace function get_film_count(len_from int , len_to int )
returns int
language plpgsql
as
    $$
    declare
        film_count integer ;
    begin
        select count(*)
        into film_count
        from film
        where length between len_from and len_to;

        return film_count;
    end $$;
-- 1.yol:   ( positional notation)
select get_film_count(40,190);
-- 2. yol : ( named notation)
select get_film_count(

    len_from:= 40,
    len_to := 135
    );
-- HAZIR METOD
select MIN(length) from film;
select MAX(length) from film;
select AVG(length) from film;
-- Task : parametre olarak girilen iki sayının toplamını veren sayitoplama adında fonksiyon yazalım
create function sayitoplama(sayi1 int, sayi2 int)
returns integer
language plpgsql
as
$$
declare
    sonuc integer;
begin
    sonuc := sayi1 + sayi2 ;
    return sonuc ;
end $$;
select sayitoplama(5,8);
