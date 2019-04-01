--02 – SELECT – złączenia tabel

--Z1a
SELECT P.nazwisko,
       P.placa,
       S.nazwa,
       S.placa_min
FROM   Pracownicy P
       CROSS JOIN Stanowiska S
ORDER BY P.nazwisko;

--Z1b
SELECT P.nazwisko,
       P.placa,
       S.nazwa,
       S.placa_min
FROM   Pracownicy P
       CROSS JOIN Stanowiska S
WHERE  S.nazwa IN ('profesor', 'sekretarka')
ORDER BY P.nazwisko;

--Z2
SELECT P.nazwisko,
       P.placa,
       S.nazwa,
       S.placa_min,
       S.placa_max
FROM   Pracownicy P
       INNER JOIN Stanowiska S
               ON P.stanowisko = S.nazwa;

--Z3
SELECT P.nazwisko,
       P2.nazwa
FROM   Pracownicy P
       INNER JOIN Realizacje R
       ON P.id = R.idPrac
              INNER JOIN Projekty P2
              ON R.idProj = P2.id
ORDER BY P.nazwisko;

--Z4
SELECT P.nazwisko,
       P.placa,
       S.nazwa,
       S.placa_min,
       S.placa_max
FROM   Pracownicy P
       INNER JOIN Stanowiska S
               ON P.stanowisko = S.nazwa
WHERE  S.nazwa LIKE 'doktorant'
       AND P.placa NOT BETWEEN S.placa_min AND S.placa_max;

--Z5
SELECT P1.nazwisko,
       P2.nazwisko AS 'szef'
FROM   Pracownicy P1
       INNER JOIN Pracownicy P2
              ON  P1.szef = P2.id;

--Z6
INSERT INTO Pracownicy VALUES (100, 'Wróbel', 3, 2200,  100, 'adiunkt', '02-02-1997');

SELECT P1.id,
       P1.nazwisko,
       P2.id,
       P2.nazwisko
FROM   Pracownicy P1
       INNER JOIN Pracownicy P2
              ON  P1.nazwisko = P2.nazwisko
              AND P1.id > P2.id;

DELETE FROM Pracownicy
WHERE  id = 100;

--Z7
SELECT P1.nazwisko,
       P2.nazwisko AS 'szef'
FROM   Pracownicy P1
       LEFT OUTER JOIN Pracownicy P2
              ON  P1.szef = P2.id;

--Z8
SELECT P.nazwisko
FROM   Pracownicy P
       LEFT OUTER JOIN Projekty P2
       ON P.id = P2.kierownik
WHERE  P2.kierownik IS NULL;

--Z9
SELECT P.nazwisko
FROM   Pracownicy P
       LEFT OUTER JOIN  Realizacje R
       ON  P.id = R.idPrac
       AND R.idProj = 10
WHERE  R.idPrac IS NULL;

--Z10
INSERT INTO Projekty
VALUES ('analiza danych', '01-03-2018', '01-03-2020', NULL, 10, 100);

SELECT P.nazwisko,
       P2.kierownik AS 'kieruje projektem',
       R.idProj AS 'pracuje w projekcie'
FROM   Pracownicy P
       INNER JOIN Projekty P2
       ON P.id = P2.kierownik
              LEFT OUTER JOIN Realizacje R
              ON P2.id = R.idProj
WHERE  R.idPrac IS NULL;

--Z11
SELECT P.nazwisko,
       P.placa
FROM   Pracownicy P
       LEFT OUTER JOIN Pracownicy P2
       ON P.placa < P2.placa
WHERE  P2.id IS NULL;


--ZADANIA DOMOWE

--ZD1i
SELECT P1.producent,
       L.szybkosc
FROM   Produkt P1
       INNER JOIN Laptop L
       ON P1.model = L.model
WHERE  L.dysk > 30
ORDER BY P1.producent;

--ZD1ii
SELECT L.model,
       L.cena
FROM   Laptop L
       INNER JOIN Produkt P
       ON P.model = L.model
WHERE  P.producent LIKE 'B';

--ZD1iii
SELECT DISTINCT PC1.dysk
FROM   PC PC1
       INNER JOIN PC PC2
       ON PC1.model <> PC2.model
WHERE  PC1.dysk = PC2.dysk;

--ZD1iv
SELECT PC1.model,
       PC2.model
FROM   PC PC1
       INNER JOIN PC PC2
       ON  PC1.ram = PC2.ram
       AND PC1.szybkosc = PC2.szybkosc
WHERE  PC1.model < PC2.model;

--ZD1v
SELECT D1.model
FROM   Drukarka D1
       LEFT OUTER JOIN Drukarka D2
       ON D1.cena < D2.cena
WHERE  D2.cena IS NULL;

--ZD1vi
SELECT DISTINCT L1.szybkosc,
       L2.ram
FROM   Laptop L1
       CROSS JOIN Laptop L2
WHERE  L1.szybkosc >= 2.0;

--ZD2i
SELECT O.nazwa
FROM   Okrety O
       INNER JOIN Klasy K
       ON O.klasa = K.klasa
WHERE  K.wypornosc > 35000;

--ZD2ii
SELECT O.nazwa,
       K.wypornosc,
       K.liczbaDzial
FROM   Okrety O
       RIGHT OUTER JOIN Skutki S
       ON  O.nazwa = S.okret
       AND S.bitwa LIKE 'Guadalcanal'
              INNER JOIN Klasy K
              ON O.klasa = K.klasa;

--ZD2ii
SELECT DISTINCT K.kraj
FROM   Klasy K
       INNER JOIN Klasy K2
       ON  K.kraj = K2.kraj
       AND K.typ <> K2.typ;

--ZD2iv
SELECT K.*,
       O.*
FROM   Klasy K
       INNER JOIN Okrety O
       ON K.klasa = O.klasa
ORDER BY O.nazwa;

--ZD2v
SELECT S.okret,
       K.wypornosc,
       K.liczbaDzial
FROM   Skutki S
       LEFT OUTER JOIN Okrety O
       ON S.okret = O.nazwa
              LEFT OUTER JOIN Klasy K
              ON K.klasa = O.klasa
WHERE  S.bitwa LIKE 'Guadalcanal';

--ZD2vi
SELECT K.kraj
FROM   Klasy K
       LEFT OUTER JOIN Klasy K2
       ON K.liczbaDzial < K2.liczbaDzial
WHERE  K2.liczbaDzial IS NULL;

--ZD2vii
SELECT O.nazwa
FROM   Okrety O
       INNER JOIN Klasy K
       ON O.klasa = K.klasa
              LEFT OUTER JOIN Klasy K2
              ON  K.kaliber = K2.kaliber
              AND K.liczbaDzial < K2.liczbaDzial
WHERE  K2.kaliber IS NULL;

--ZD3
SELECT *
FROM   Kolory K
       INNER JOIN Cechy C
       ON 0=0;