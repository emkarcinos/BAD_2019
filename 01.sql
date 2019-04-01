--01 - SELECT - podstawy, filtrowanie wieszy

--Z1
SELECT id,
       nazwa,
       stawka
FROM   Projekty;

--Z2
SELECT *
FROM   Pracownicy;

--Z3
SELECT nazwa AS 'nazwa stanowiska',
       placa_min AS 'płaca minimalna na stanowisku'
FROM   Stanowiska;

--Z4
SELECT nazwa,
       LEN(nazwa) AS 'liczba znaków'
FROM   Stanowiska;

--Z5
SELECT nazwisko,
       placa*12 AS 'roczny przychód z pensji'
FROM   Pracownicy;

--Z6
SELECT nazwisko,
       DATEDIFF(MONTH, zatrudniony, '2019-01-01') AS 'mies. zatrudniony'
FROM   Pracownicy;

--Z7
SELECT nazwisko,
       (placa+ISNULL(dod_funkc, 0))*12 AS 'roczne wynagrodzenie'
FROM   Pracownicy;

--Z8
SELECT nazwa,
       DATEDIFF(MONTH, dataRozp, ISNULL(dataZakonczFakt, GETDATE())) AS 'czas trwania'
FROM   Projekty;

--Z9
SELECT CAST(2.0/4 AS NUMERIC(30,2));

--Z10
SELECT DISTINCT kierownik
FROM   Projekty;

--Z11
SELECT nazwa,
       placa_min
FROM   Stanowiska
ORDER BY placa_min DESC,
         nazwa DESC;

--Z12
SELECT TOP 1 nazwa,
             dataRozp,
             kierownik
FROM   Projekty
ORDER BY dataRozp DESC;

--Z13
SELECT nazwisko,
       placa,
       stanowisko
FROM   Pracownicy
WHERE  stanowisko IN ('adiunkt', 'doktorant')
       AND placa > 1500;

--Z14
SELECT nazwa
FROM   Projekty
WHERE  nazwa LIKE '%web%';

--Z15
SELECT nazwisko
FROM   Pracownicy
WHERE  szef IS NULL;

--Z16
SELECT nazwisko,
       placa,
       dod_funkc,
       placa+ISNULL(dod_funkc, 0) AS 'pensja'
FROM   Pracownicy
WHERE  placa+ISNULL(dod_funkc, 0) > 2000;

--Z17
SELECT nazwa,
       CASE nazwa
            WHEN 'profesor'  THEN 'badawcze'
            WHEN 'adiunkt'   THEN 'badawcze'
            WHEN 'doktorant' THEN 'badawcze'
            ELSE 'administracyjne'
            END AS 'typ stanowiska'
FROM   Stanowiska


--ZADANIA DOMOWE

--ZD1i
SELECT model,
       szybkosc,
       dysk
FROM   PC
WHERE  cena < 1000;

--ZD1ii
SELECT model,
       szybkosc AS 'gigaherce',
       dysk AS 'gigabajty'
FROM   PC
WHERE  cena < 1000;

--ZD1iii
SELECT producent
FROM   Produkt
WHERE  typ LIKE 'drukarka';

--ZD1iv
SELECT model,
       ram,
       ekran
FROM   Laptop
WHERE  cena > 1500;

--ZD1v
SELECT *
FROM   Drukarka
WHERE  kolor=1;

--ZD1vi
SELECT model,
       dysk
FROM   PC
WHERE  szybkosc=3.2 AND cena < 2000;

--ZD1vii
SELECT TOP 3 szybkosc,
             model
FROM Laptop
ORDER BY szybkosc;

--ZD1viii
SELECT model,
       CAST(ram AS FLOAT)/1024 AS 'ram [GB]'
FROM   Laptop;

--ZD2i
SELECT klasa,
       kraj
FROM   Klasy
WHERE  liczbaDzial >= 10;

--ZD2ii
SELECT nazwa AS 'nazwaOkretu'
FROM   Okrety
WHERE  zwodowano < 1918;

--ZD2iii
SELECT okret,
       bitwa
FROM   Skutki
WHERE  efekt = 'zatopiony';

--ZD2iv
SELECT nazwa AS 'nazwaOkretu'
FROM   Okrety
WHERE  nazwa = klasa;

--ZD2v
SELECT nazwa AS 'nazwaOkretu'
FROM   Okrety
WHERE  nazwa LIKE 'R%';

SELECT okret AS 'nazwaOkretu'
FROM   Skutki
WHERE  okret LIKE 'R%';

--ZD2vi
SELECT nazwa AS 'nazwaOkretu'
FROM   Okrety
WHERE  nazwa LIKE '% % %';

SELECT okret AS 'nazwaOkretu'
FROM   Skutki
WHERE  okret LIKE '% % %';

--ZD2vii
SELECT DISTINCT nazwa AS 'nazwaOkretu'
FROM   Okrety
WHERE  zwodowano < 1921;

--ZD2viii
SELECT DISTINCT okret AS 'nazwaOkretu'
FROM   Skutki
WHERE  bitwa LIKE 'Denmark Strait' AND efekt = 'zatopiony';

--ZD2ix
SELECT TOP 1 zwodowano, nazwa AS 'nazwaOkretu'
FROM   Okrety
ORDER BY zwodowano DESC;

--ZD2x
SELECT SUBSTRING(nazwa, 0, 6) AS 'nazwa_5'
FROM   Bitwy;

--ZD2xi
SELECT nazwa,
       CAST(data AS DATETIME) AS 'data bitwy'
FROM   Bitwy;

--ZD2xii
SELECT nazwa,
       DATEDIFF(YEAR, CAST(data AS DATETIME), GETDATE()) AS 'ile lat minęło'
FROM   Bitwy;

--ZD2xiii
SELECT *
FROM   Okrety
ORDER BY zwodowano DESC,
         nazwa ASC;

--ZD2iv
SELECT klasa,
       CASE typ
            WHEN 'pn' THEN 'pancernik'
            WHEN 'kr' THEN 'krążownik'
            ELSE 'UNKNOWN'
            END AS 'typ'
FROM   Klasy;

--ZD3i
SELECT id,
       nazwa,
       dataZakonczFakt
FROM   Projekty
WHERE  dataZakonczFakt IS NULL;

--ZD3ii
SELECT id,
       nazwisko,
       ISNULL(dod_funkc, 100) AS 'premia świąteczna'
FROM   Pracownicy
WHERE  stanowisko <> 'profesor';

--ZD3iii
--To zapytanie nie zwróci wszystkich pracowników, gdyż niektórzy pracownicy nie posiadają dod_funkc, co nie zostanie uwzględnione w klauzuli WHERE.

--ZD3iv
SELECT id,
       nazwa,
       dataZakonczFakt,
       CASE WHEN dataZakonczFakt IS NULL THEN 0
       ELSE 1
       END AS 'test CASE'
FROM   Projekty;
