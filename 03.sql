--03 – SELECT – podzapytania w klauzuli WHERE

--Z1
SELECT nazwisko
FROM   Pracownicy
WHERE  placa > (SELECT placa
                FROM   Pracownicy
                WHERE  nazwisko LIKE 'Różycka')

--Z2
SELECT nazwisko
FROM   Pracownicy
WHERE  id NOT IN (SELECT kierownik
                  FROM   Projekty);

--Z3
SELECT nazwisko
FROM   Pracownicy
WHERE  id NOT IN (SELECT idPrac
                  FROM   Realizacje
                  WHERE  idProj = 10);

--Z4
SELECT nazwisko
FROM   Pracownicy
WHERE  id IN (SELECT idPrac
              FROM   Realizacje
              WHERE  idProj = (SELECT id
                               FROM   Projekty
                               WHERE  nazwa LIKE 'e-learning'));

--Z5
SELECT nazwisko,
       placa
FROM   Pracownicy
WHERE  placa >= ALL (SELECT placa
                     FROM   Pracownicy);

--Z6
SELECT P.id,
       P.nazwa,
       P.stawka,
       P.stawka*40 AS 'tygodniowka',
       P.kierownik
FROM   Projekty P
WHERE  P.stawka*40 > (SELECT P2.placa
                      FROM   Pracownicy P2
                      WHERE  P.kierownik=P2.id);

--Z7
INSERT INTO Pracownicy VALUES (100, 'Wróbel', 3, 2200,  100, 'adiunkt', '02-02-1997');

SELECT P.nazwisko,
       P.id
FROM   Pracownicy P
WHERE  P.nazwisko = (SELECT P2.nazwisko
                     FROM   Pracownicy P2
                     WHERE  P.nazwisko = P2.nazwisko
                            AND P.id <> P2.id);

DELETE FROM Pracownicy
WHERE  id = 100;

--Z8
SELECT DISTINCT P.nazwisko
FROM   Pracownicy P
       INNER JOIN Realizacje R
       ON P.id = R.idPrac
WHERE  R.idProj IN (SELECT R2.idProj
                    FROM   Realizacje R2
                    WHERE  R2.idPrac = P.szef);

--Z9
SELECT DISTINCT P.nazwisko
FROM   Pracownicy P
       INNER JOIN Realizacje R
       ON P.id = R.idPrac
            INNER JOIN Realizacje R2
            ON  R.idProj = R2.idProj
            AND R2.idPrac = P.szef;

--Z10
SELECT P.nazwisko
FROM   Pracownicy P
WHERE  NOT EXISTS(SELECT P2.id
                  FROM   Projekty P2
                  WHERE  P2.kierownik=P.id);

--Z11
DELETE FROM Projekty
WHERE  nazwa = 'analiza danych';

SELECT P.nazwisko
FROM   Pracownicy P
WHERE  NOT EXISTS (SELECT P1.*
                   FROM   Projekty P1
                   WHERE  NOT EXISTS (SELECT R.*
                                      FROM   Realizacje R
                                      WHERE  R.idPrac=P.id
                                             AND R.idProj = P1.id));

--ZADANIA DOMOWE

--ZD1i
SELECT DISTINCT producent
FROM   Produkt
WHERE  model IN (SELECT model
                 FROM   PC
                 WHERE  szybkosc > 3.0);

--ZD1ii
SELECT model
FROM   Drukarka
WHERE  cena >= ALL (SELECT cena
                    FROM   Drukarka);

--ZD1iii
SELECT model
FROM   PC
WHERE  szybkosc < ALL (SELECT szybkosc
                       FROM   Laptop
                       WHERE  szybkosc <= ALL (SELECT szybkosc
                                               FROM   Laptop));

--ZD1iv
SELECT DISTINCT P1.producent
FROM   Produkt P1
WHERE  NOT EXISTS(SELECT P2.*
                  FROM   Produkt P2
                  WHERE  NOT EXISTS(SELECT P3.*
                                    FROM   Produkt P3
                                    WHERE  P1.producent=P3.producent
                                           AND P3.typ=P2.typ));

--ZD2i
SELECT kraj
FROM   Klasy
WHERE  liczbaDzial >= ALL (SELECT liczbaDzial
                           FROM   Klasy);

--ZD2ii
SELECT klasa
FROM   Klasy K
WHERE  EXISTS(SELECT O.*
              FROM   Okrety O
              WHERE  O.klasa = K.klasa
                     AND O.nazwa IN (SELECT S.okret
                                     FROM   Skutki S
                                     WHERE  s.efekt LIKE 'zatopiony'));

--ZD2iii
SELECT O.nazwa
FROM   Okrety O
WHERE  O.klasa IN (SELECT K.klasa
                   FROM   Klasy K
                   WHERE  O.klasa=K.klasa
                          AND K.kaliber=16);

--ZD2iv
SELECT S.bitwa
FROM   Skutki S
WHERE  EXISTS(SELECT K.*
              FROM   Klasy K
              WHERE  K.klasa = 'Kongo'
                     AND S.okret IN (SELECT O.nazwa
                                     FROM   Okrety O
                                     WHERE  O.klasa = K.klasa));

--ZD2v
SELECT O.nazwa
FROM   Okrety O
WHERE  O.klasa IN (SELECT K.klasa
                   FROM   Klasy K
                   WHERE  K.liczbaDzial >= ALL (SELECT K2.liczbaDzial
                                                FROM   Klasy K2
                                                WHERE  K2.kaliber = K.kaliber));