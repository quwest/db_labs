DROP DATABASE IF EXISTS Books;
CREATE DATABASE IF NOT EXISTS Books;

CREATE TABLE books_for_pc(
    N INT(9) NOT NULL PRIMARY KEY,
    Code INT(9) NOT NULL DEFAULT 0,
    Is_new BOOLEAN NOT NULL DEFAULT FALSE,
    Name VARCHAR(100) NOT NULL DEFAULT '',
    Price FLOAT(4,2) DEFAULT NULL,
    Publisher SMALLINT(3) NOT NULL,
    Pages_count INT(4) NOT NULL DEFAULT 0,
    Format SMALLINT(3) NOT NULL,
    Date_book DATE DEFAULT NULL,
    Tirage INT(7) NOT NULL DEFAULT 0,
    Theme SMALLINT(3) NOT NULL,
    Category SMALLINT(3) NOT NULL
);
CREATE INDEX indx_name ON books_for_pc(Name);

CREATE TABLE Publishers(
    publisher_id SMALLINT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    publisher_surname VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Formats(
    format_id SMALLINT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    format_name VARCHAR(12) UNIQUE NOT NULL DEFAULT ''
);

CREATE TABLE Topics(
    topic_id SMALLINT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    topic_name VARCHAR(26) UNIQUE NOT NULL DEFAULT ''
);

CREATE TABLE Categories(
    category_id SMALLINT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(25) UNIQUE NOT NULL DEFAULT ''
);

ALTER TABLE books_for_pc ADD FOREIGN KEY (Publisher) REFERENCES Publishers(publisher_id);
ALTER TABLE books_for_pc ADD FOREIGN KEY (Format) REFERENCES Formats(format_id);
ALTER TABLE books_for_pc ADD FOREIGN KEY (Theme) REFERENCES Topics(topic_id);
ALTER TABLE books_for_pc ADD FOREIGN KEY (Category) REFERENCES Categories(category_id);


INSERT INTO Formats(format_name) VALUES
('n/m'), /*не вказано*/
('70х100/16'),
('84х108/16'),
('60х88/16'),
('84x100/16'),
('60x90\16'),
('60x84/16');
INSERT INTO Publishers(publisher_surname) VALUES
  ('n/m'),/*не вказано*/
  ('Вильямс'),
  ('Питер'),
  ('МикроАрт'),
  ('DiaSoft'),
  ('ДМК'),
  ('Триумф'),
  ('Эком'),
  ('Видавнича група BHV'),
  ('Києво-Могилянська академія'),
  ('Університет `Україна`'),
  ('Вінниця: ВДТУ');
INSERT INTO Categories(category_name) VALUES
  ('n/m'), /*не вказано*/
  ('Підручники'),
  ('Апаратні засоби ПК'),
  ('Захист і безпека ПК'),
  ('Інші книги'),
  ('Windows 2000'),
  ('Linux'),
  ('Unix'),
  ('Інші операційні системи'),
  ('C&C++'),
  ('SQL');
INSERT INTO Topics(topic_name) VALUES
  ('Використання ПК в цілому'),
  ('Операційні системи'),
  ('Програмування');
  INSERT INTO books_for_pc (
   N,
   Code,
   Is_new,
   Name,
   Price,
   Publisher,
   Pages_count,
   Format,
   Date_book,
   Tirage,
   Theme,
   Category)
VALUES
(
    2,
    5110,
    True,
    'Апаратні засоби мультимедіа. Відеосистема РС',
    15.51,
    9,
    400,
    2,
    '2000-07-24',
     5000,
    1,
    2
),
(
    8,
    4985,
    False,
    'Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид.',
    18.90,
    2,
    288,
    2,
    '2000-07-07',
    5000,
    1,
    2
),
(
    9,
    5141,
    False,
    'Структури даних та алгоритми',
    37.80,
    2,
    384,
    2,
    '2000-09-29',
    5000,
    1,
    2
),
(
    20,
    5127,
    True,
    'Автоматизація інженерно-графічних робіт',
    11.58,
    3,
    256,
    2,
    '2000-06-15',
    5000,
    1,
    2
),
(
    31,
    5110,
    False,
    'Апаратні засоби мультимедіа. Відеосистема РС',
    15.51,
    9,
    400,
    2,
    '2000-07-24',
    5000,
    1,
    3
),
(
    46,
    5199,
    False,
    'Залізо IBM 2001',
    30.07,
    4,
    368,
    2,
    '2000-02-12',
    5000,
    1,
    3
),
(
    50,
    3851,
    True,
    'Захист інформації та безпека комп`ютерних систем',
    26.00,
    5,
    480,
    3,
    NULL,
    5000,
    1,
    4
),
(
    58,
    3932,
    False,
    'Як перетворити персональний комп`ютер на вимірювальний комплекс',
    7.65,
    6,
    144,
    4,
    '1999-09-06',
    5000,
    1,
    5
),
(
    59,
    4713,
    False,
    'Plug-ins. Додаткові програми для музичних програм',
    11.41,
    6,
    144,
    2,
    '2000-02-22',
    5000,
    1,
    5
),
(
    175,
    5217,
    False,
    'Windows МЕ. Найновіші версії програм',
    16.57,
    7,
    320,
    2,
    '2000-08-25',
    5000,
    2,
    6
),
(
    176,
    4829,
    False,
    'Windows 2000 Professional крок за кроком з CD',
    27.25,
    8,
    320,
    2,
    '2000-04-28',
    5000,
    2,
    6
),(
    188,
    5170,
    False,
    'Linux версії',
    24.43,
    6,
    346,
    2,
    '2000-09-29',
    5000,
    2,
    7
),(
    191,
    860,
    False,
    'Операційна система UNIX',
    3.50,
    9,
    395,
    5,
    '1997-05-05',
    5000,
    2,
    8
),
(
    203,
    44,
    False,
    'Відповіді на актуальні запитання щодо OS/2 Warp',
    5.00,
    5,
    352,
    4,
    '1996-03-20',
    5000,
    2,
    9
),
(
    206,
    5176,
    False,
    'Windows Ме. Супутник користувача',
    12.79,
    9,
    306,
    1,
    '2000-10-10',
    5000,
    2,
    9
),
(
    209,
    5462,
    False,
    'Мова програмування С++. Лекції та вправи',
    29.00,
    5,
    656,
    3,
    '2000-12-12',
    5000,
    3,
    10
),
(
    210,
    4982,
    False,
    'Мова програмування С. Лекції та вправи',
    29.00,
    5,
    432,
    3,
    '2000-12-07',
    5000,
    3,
    10
),
(
    220,
    4687,
    False,
    'Ефективне використання C++ .50 рекомендацій щодо покращення ваших програм та проектів',
    17.60,
    6,
    240,
    2,
    '2000-03-02',
    5000,
    3,
    10
),(
    222,
    235,
    False,
    'Інформаційні системи і структури даних',
    NULL,
    10,
    418,
    6,
    NULL,
    100,
    1,
    11
),
(
    225,
    8746,
    True,
    'Бази даних в інформаційних системах',
    NULL,
    11,
    418,
    7,
    '2018-07-25',
    500,
    3,
    5
),
(
    226,
    2154,
    True,
    'Сервер на основі операційної системи FreeBSD 6.1',
    NULL,
    11,
    216,
    7,
    '2015-11-03',
    500,
    3,
    11
),
(
    245,
    2662,
    False,
    'Організація баз даних та знань',
    NULL,
    12,
    208,
    6,
    '2001-10-10',
    1000,
    3,
    11
),
(
    247,
    5641,
    True,
    'Організація баз даних та знань',
    NULL,
    9,
    384,
    2,
    '2021-12-15',
    5000,
    3,
    11
);