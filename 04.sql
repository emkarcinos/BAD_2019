--04 – SELECT – funkcje agregujące, operacje na zbiorach, podzapytania w klauzuli FROM i SELECT

--Z1
SELECT AVG(P.placa) AS 'srednia',
       COUNT(*)
FROM   Realizacje R
       INNER JOIN Pracownicy P
       ON R.idPrac = P.id
WHERE  R.idProj = (SELECT id
                   FROM   Projekty
                   WHERE  nazwa LIKE 'e-learning');

--Z2
SELECT nazwisko,
       placa
FROM   Pracownicy
WHERE  placa = (SELECT MAX(placa)
                FROM   Pracownicy);

--Z3
SELECT P.stanowisko,
       P.nazwisko,
       P.placa
FROM   Pracownicy P
WHERE  placa = (SELECT MAX(P2.placa)
                FROM   Pracownicy P2
                WHERE  P2.stanowisko = P.stanowisko);

--Z4
SELECT COUNT(DISTINCT idPrac) AS 'ilu różnych pracowników'
FROM   Realizacje;

--Z5
SELECT COUNT(DISTINCT szef) AS 'liczba szefów'
FROM   Pracownicy
WHERE  szef IS NOT NULL;

--Z6
SELECT   szef,
         MIN(placa) AS 'minimum',
         MAX(placa) AS 'maximum'
FROM     Pracownicy
WHERE    szef IS NOT NULL
GROUP BY szef;

--Z7
SELECT   P1.nazwisko,
         COUNT(P2.id)
FROM     Pracownicy P1
         LEFT OUTER JOIN Pracownicy P2
         ON P1.id=P2.szef
GROUP BY P1.nazwisko;

--Z8
SELECT   P1.nazwisko,
         COUNT(R.idProj)
FROM     Pracownicy P1
         INNER JOIN Realizacje R
         ON  P1.id = R.idPrac
         AND P1.stanowisko <> 'profesor'
GROUP BY P1.nazwisko
HAVING   COUNT(R.idProj) > 1;

--Z9
INSERT INTO Pracownicy VALUES (100, 'Wróbel', 3, 2200,  100, 'adiunkt', '02-02-1997');

SELECT   P1.nazwisko,
         COUNT(P1.id) AS 'liczba'
FROM     Pracownicy P1
GROUP BY P1.nazwisko
HAVING   COUNT(P1.nazwisko) > 1;

DELETE FROM Pracownicy
WHERE  id = 100;

--Z10
SELECT nazwa,
       dataZakonczPlan AS 'DataZakonczenia',
       'projekt trwa' AS 'Status'
FROM   Projekty
WHERE  dataZakonczFakt IS NULL

UNION

SELECT nazwa,
       dataZakonczPlan AS 'DataZakonczenia',
       'projekt zakonczony' AS 'Status'
FROM   Projekty
WHERE  dataZakonczFakt IS NOT NULL;

--Z11
SELECT nazwisko
FROM   Pracownicy

EXCEPT

SELECT P1.nazwisko
FROM   Pracownicy P1
       INNER JOIN Projekty P2
       ON P1.id = P2.kierownik;

--Z12
SELECT nazwisko,
       placa,
       dod_funkc,
       pensja
FROM   (SELECT *,
               placa+ISNULL(dod_funkc, 0) AS 'pensja'
        FROM Pracownicy) AS T
WHERE  pensja > 2000;

--Z13
SELECT nazwisko,
       (placa / (SELECT AVG(placa) FROM Pracownicy))*100 AS 'procent sredniej'
FROM   Pracownicy

--Z14
-----------

--Z15
-----------

--Z16
SELECT   TOP 1 P.nazwisko,
         COUNT(R.idProj)
FROM     Pracownicy P
         INNER JOIN Realizacje R
         ON R.idPrac = P.id
GROUP BY P.nazwisko
ORDER BY COUNT(R.idProj) DESC;

-----------

--ZADANIA DOMOWE

--ZD1i
SELECT AVG(szybkosc) AS 'średnia szybkość'
FROM   Laptop
WHERE  cena > 1000;

--ZD1ii
SELECT AVG(*)
FROM   Produkt P
       LEFT OUTER JOIN PC
       ON P.model = PC.model
              LEFT OUTER JOIN Laptop L
              ON P.model = L.model
GROUP BY P.model