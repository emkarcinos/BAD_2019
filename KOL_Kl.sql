--06 – Przykładowe kolokwium – Klinika

--Z1
SELECT   nazwisko,
         imie,
         specjalnosc,
         data_urodzenia
FROM     Lekarze
WHERE    DATEDIFF(YEAR,data_urodzenia,GETDATE()) > 50 AND
         (specjalnosc = 'pediatra'
         OR specjalnosc = 'internista')
ORDER BY DATEDIFF(YEAR,data_urodzenia,GETDATE());

--Z2
SELECT data_wizyty
FROM   Wizyty
WHERE  YEAR(data_wizyty) = 2006
       AND lekarz = (SELECT id_lekarza
                     FROM   Lekarze
                     WHERE  nazwisko = 'Maslowski');

--Z3
SELECT DISTINCT L.nazwisko,
       L.specjalnosc
FROM   Lekarze L
       INNER JOIN Wizyty W
       ON L.id_lekarza = W.lekarz
WHERE W.pacjent = (SELECT id_pacjenta
                   FROM   Pacjenci
                   WHERE  nazwisko = 'Witkowski');

--Z4
SELECT nazwisko,
       specjalnosc
FROM   Lekarze
WHERE  specjalnosc = (SELECT specjalnosc
                      FROM   Lekarze
                      WHERE  nazwisko = 'Stefanowicz')
       AND nazwisko <> 'Stefanowicz';

--Z5
--i
SELECT nazwisko
FROM   Pacjenci P
       LEFT OUTER JOIN Wizyty W
       ON P.id_pacjenta = W.pacjent
WHERE  W.pacjent IS NULL;

--ii
SELECT nazwisko
FROM   Pacjenci
WHERE  id_pacjenta NOT IN (SELECT pacjent
                           FROM   Wizyty);
--iii
SELECT P.nazwisko
FROM   Pacjenci P
WHERE  NOT EXISTS (SELECT *
                   FROM   Wizyty W
                   WHERE  P.id_pacjenta = W.pacjent);

--Z6
SELECT   specjalnosc,
         COUNT(*) AS 'ilu lekarzy'
FROM     Lekarze
GROUP BY specjalnosc;

--Z9
SELECT nazwisko,
       data_urodzenia
FROM   Lekarze
WHERE  data_urodzenia >=  ALL (SELECT data_urodzenia
                               FROM   Lekarze);
--Z8
SELECT L.nazwisko,
       L.specjalnosc,
       L.data_urodzenia
FROM   Lekarze L
WHERE  L.data_urodzenia >= ALL (SELECT L2.data_urodzenia
                                FROM   Lekarze L2
                                WHERE  L.specjalnosc = L2.specjalnosc)
ORDER BY data_urodzenia;

--Z9
SELECT   L.nazwisko,
         L.imie,
         COUNT(*) AS 'ile wizyt'
FROM     Lekarze L
         INNER JOIN Wizyty W
         ON L.id_lekarza = W.lekarz
GROUP BY L.nazwisko,
         L.imie
HAVING   COUNT(*) > 10;

--Z10
SELECT SUM(W.koszt) AS 'suma wydatków'
FROM   Wizyty W
       INNER JOIN Pacjenci P
       ON W.pacjent = P.id_pacjenta
WHERE  P.nazwisko = 'Gumowska' AND P.imie = 'Anna';

--Z11
SELECT   nazwisko,
         imie,
         COUNT(*) AS 'ile wizyt'
FROM     Lekarze
         INNER JOIN Wizyty W
         ON Lekarze.id_lekarza = W.lekarz
GROUP BY nazwisko, imie
HAVING   COUNT(*) >= ALL(SELECT   COUNT(*) AS 'ile wizyt'
                         FROM     Lekarze
                                  INNER JOIN Wizyty W
                                  ON Lekarze.id_lekarza = W.lekarz
                         GROUP BY nazwisko, imie);