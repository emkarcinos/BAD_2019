--06 – Przykładowe kolokwium – Księgarnia

--Z1
SELECT   nazwisko,
         kraj
FROM     Autorzy
WHERE    kraj <> 'Polska'
ORDER BY nazwisko;

--Z2
SELECT tytul
FROM   Ksiazki
WHERE  tytul LIKE '%XML%';

--Z3
--ii
SELECT tytul
FROM   Ksiazki
WHERE  cena > (SELECT cena
               FROM   Ksiazki
               WHERE  tytul LIKE 'Fuzzy Logic');

--i
SELECT K1.tytul
FROM   Ksiazki K1
       INNER JOIN Ksiazki K2
       ON  K2.tytul = 'Fuzzy Logic'
       AND K1.cena > K2.cena;

--Z4
--i
SELECT DISTINCT A.nazwisko
FROM   Autorzy A
       INNER JOIN Ksiazki K
       ON A.id_autor = K.autor
WHERE  K.dzial LIKE 'informatyka';

--ii
SELECT nazwisko
FROM   Autorzy
WHERE  id_autor IN (SELECT autor
                    FROM   Ksiazki
                    WHERE  dzial = 'informatyka');

--Z5
SELECT nazwisko
FROM   Autorzy
WHERE  id_autor IN (SELECT autor
                    FROM   Ksiazki
                    WHERE  dzial =(SELECT dzial
                                   FROM   Ksiazki
                                   WHERE  autor = (SELECT id_autor
                                                   FROM   Autorzy
                                                   WHERE  nazwisko = 'Yen')))
       AND nazwisko <> 'Yen';

--Z6
SELECT   dzial,
         COUNT(*) AS 'ile'
FROM     Ksiazki
GROUP BY dzial;

--Z7
SELECT AVG(K.cena) AS 'srednia'
FROM   Ksiazki K
WHERE  K.autor = (SELECT id_autor
                  FROM   Autorzy
                  WHERE  nazwisko = 'Sapkowski');

--Z8
SELECT tytul
FROM   Ksiazki
WHERE  cena <= ALL (SELECT cena
                    FROM   Ksiazki
                    WHERE  dzial = 'informatyka')
       AND dzial = 'informatyka';

--Z9
SELECT K.dzial,
       K.tytul
FROM   Ksiazki K
WHERE  cena <= ALL (SELECT K2.cena
                    FROM   Ksiazki K2
                    WHERE  K.dzial = K2.dzial);

--Z10
SELECT   A.nazwisko,
         COUNT(*) AS 'ile'
FROM     Autorzy A
         INNER JOIN Ksiazki K
         ON A.id_autor = K.autor
WHERE    K.rok_wydania > 1996
GROUP BY A.nazwisko
HAVING   COUNT(*) >= 2;

--Z11
SELECT   dzial,
         COUNT(DISTINCT autor) AS 'licz_autorow'
FROM     Ksiazki
GROUP BY dzial
HAVING   COUNT(DISTINCT autor) > 1;

--Z12
SELECT   dzial
FROM     Ksiazki K
GROUP BY dzial
HAVING   COUNT(id_ksiazki) = (SELECT MAX(t)
                              FROM   (SELECT   COUNT(*) AS t
                                      FROM     Ksiazki
                                      GROUP BY dzial) AS T);

--Z13
SELECT A.nazwisko
FROM   Autorzy A
WHERE  NOT EXISTS(SELECT K1.id_ksiazki
                  FROM   Ksiazki K1
                  WHERE  NOT EXISTS(SELECT K2.dzial
                                    FROM   Ksiazki K2
                                    WHERE  A.id_autor = K2.autor
                                           AND K2.dzial = K1.dzial));

--Z14
--i
SELECT nazwisko
FROM   Autorzy
       LEFT OUTER JOIN Ksiazki K
       ON Autorzy.id_autor = K.autor
WHERE K.id_ksiazki IS NULL;

--ii
SELECT nazwisko
FROM   Autorzy
WHERE  id_autor NOT IN (SELECT autor
                        FROM   Ksiazki);

--iii
SELECT A.nazwisko
FROM   Autorzy A
WHERE  NOT EXISTS(SELECT K.autor
                  FROM   Ksiazki K
                  WHERE  A.id_autor=K.autor);

--Z15
SELECT K1.tytul
FROM   Ksiazki K1
WHERE  cena > ALL (SELECT   AVG(K2.cena)
                   FROM     Ksiazki K2
                   WHERE    K2.dzial=K1.dzial
                   GROUP BY K2.dzial);