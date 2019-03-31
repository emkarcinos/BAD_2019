CREATE TABLE Uczestnicy
( PESEL    INT CONSTRAINT pk_uczestnicy_pesel PRIMARY KEY,
  nazwisko VARCHAR NOT NULL CONSTRAINT ck_uczestnicy_nazwisko CHECK ('nazwisko' LIKE '[A-Z]%'),
  miasto   VARCHAR DEFAULT 'Poznań',
)

CREATE TABLE Kursy
( Kod        INT IDENTITY (1, 1) CONSTRAINT pk_kursy_kod PRIMARY KEY,
  nazwa      VARCHAR CONSTRAINT uniq_kursy_nazwa UNIQUE,
  liczba_dni INT CONSTRAINT ck_kursy_days CHECK (liczba_dni IN (1, 5)),
  cena AS liczba_dni*1000,
)

CREATE TABLE Udzial
( uczestnik   INT CONSTRAINT fk_udzial_uczestnik REFERENCES Uczestnicy(PESEL),
  kurs        INT CONSTRAINT fk_udzial_kurs REFERENCES Kursy(Kod),
  data_od     DATETIME,
  data_do     DATETIME,
  status      VARCHAR CONSTRAINT  ck_udzial_status CHECK (status IN ('w trakcie', 'ukonczony', 'nie ukonczony')),
  CONSTRAINT ck_udzial_date CHECK (data_do > ISNULL(data_od,0)),
)


