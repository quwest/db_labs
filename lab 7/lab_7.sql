CREATE PROCEDURE func_1()
SELECT Name,Price,Publishers.publisher_surname,Formats.format_name FROM books_for_pc JOIN Publishers ON books_for_pc.Publisher=Publishers.publisher_id JOIN Formats ON books_for_pc.Format=Formats.format_id;
CALL func_1();

CREATE PROCEDURE func_2()
SELECT Topics.topic_name, Categories.category_name, Name, Publishers.publisher_name FROM books_for_pc JOIN Topics ON books_for_pc.Theme=Topics.topic_id JOIN Categories ON  books_for_pc.Category=Categories.category_id JOIN Publishers ON books_for_pc.Publisher=Publishers.publisher_id;
CALL func_2();

CREATE PROCEDURE func_3(in pub text(20), in my_year int)
SELECT books_for_pc.Name,Publishers.publisher_surname FROM books_for_pc JOIN Publishers ON books_for_pc.Publisher=Publishers.publisher_id
WHERE YEAR(books_for_pc.Date_book)>my_year AND Publishers.publisher_surname LIKE pub
ORDER BY books_for_pc.Code ASC;
CALL func_3('%BHV%',2000);

CREATE PROCEDURE func_4()
SELECT books_for_pc.Name,SUM(books_for_pc.Pages_count),Categories.category_name FROM books_for_pc JOIN Categories ON books_for_pc.Category=Categories.category_id GROUP BY Categories.category_name ORDER BY books_for_pc.Pages_count DESC;
CALL func_4();

CREATE PROCEDURE func_5(in theme int, in category int, OUT price int)
SET price=(SELECT AVG(books_for_pc.Price) FROM books_for_pc WHERE books_for_pc.Theme LIKE theme AND books_for_pc.Category LIKE category);
CALL func_5(1,7,@price);
SELECT @price;

CREATE PROCEDURE func_6()
SELECT books_for_pc.N,books_for_pc.Code,books_for_pc.Is_new,books_for_pc.Name,books_for_pc.Price,Publishers.publisher_surname,books_for_pc.Pages_count,Formats.format_name,books_for_pc.Date_book,books_for_pc.Tirage,Topics.topic_name,Categories.category_name FROM books_for_pc JOIN Publishers ON books_for_pc.Publisher=Publishers.publisher_id JOIN Topics ON books_for_pc.Theme=Topics.topic_id JOIN Categories ON books_for_pc.Category=Categories.category_id JOIN Formats ON books_for_pc.Format=Formats.format_id;
CALL func_6();

CREATE PROCEDURE func_7()
SELECT DISTINCT book1.Name ,book2.Name FROM books_for_pc book1 JOIN books_for_pc book2 ON book1.Pages_count=book2.Pages_count AND book1.N!=book2.N;
CALL func_7();

CREATE PROCEDURE func_8()
SELECT DISTINCT book1.Name,book2.Name,book3.Name FROM books_for_pc book1 JOIN books_for_pc book2 ON book1.Price=book2.Price AND book1.N!=book2.N JOIN books_for_pc book3 ON book2.Price=book3.Price AND book2.N!=book3.N;
CALL func_8();

CREATE PROCEDURE func_9(in category VARCHAR(100))
SELECT books_for_pc.Name ,books_for_pc.Price ,books_for_pc.Pages_count ,books_for_pc.Format ,books_for_pc.Date_book ,Publishers.publisher_surname,Topics.topic_name ,Categories.category_name FROM books_for_pc JOIN Publishers ON books_for_pc.Price=Publishers.publisher_id JOIN Topics ON books_for_pc.Theme=Topics.topic_id JOIN Categories ON books_for_pc.Category=Categories.category_id WHERE Categories.category_name=category;
CALL func_9("C&C++");

CREATE PROCEDURE func_10(in pagecount int)
SELECT Publishers.publisher_surname FROM books_for_pc,Publishers WHERE books_for_pc.Pages_count>=pagecount;
CALL func_10(400);

CREATE PROCEDURE func_11(in num int)
SELECT categories.category_name FROM Categories WHERE (SELECT COUNT(*) FROM books_for_pc WHERE books_for_pc.Category = Categories.category_id) > num;
CALL func_11(3);

CREATE PROCEDURE func_12(in publisher VARCHAR(50))
SELECT books_for_pc.Name FROM books_for_pc WHERE EXISTS (SELECT Publishers.publisher_id,Publishers.publisher_surname FROM Publishers WHERE Publishers.publisher_surname = publisher AND Publishers.publisher_id = books_for_pc.Publisher);
CALL func_12('Видавнича група BHV');

CREATE PROCEDURE func_13(in publisher VARCHAR(50))
SELECT books_for_pc.Name FROM books_for_pc WHERE NOT EXISTS (SELECT Publishers.publisher_id,Publishers.publisher_surname FROM Publishers WHERE Publishers.publisher_surname = publisher AND Publishers.publisher_id = books_for_pc.Publisher);
CALL func_13('Видавнича група BHV');

CREATE PROCEDURE func_14()
((SELECT Topics.topic_name FROM Topics) UNION (SELECT Categories.category_name FROM Categories)) ORDER BY topic_name ASC;
CALL func_14();

CREATE PROCEDURE func_15()
SELECT DISTINCT name FROM ((SELECT REGEXP_SUBSTR(TRIM(books_for_pc.Name),'^[^\\s]+') AS name FROM books_for_pc) UNION ALL(SELECT REGEXP_SUBSTR(TRIM(Categories.category_name),'^[^\\s]+') FROM Categories)) books_for_pc,Categories ORDER BY name DESC;
CALL func_15();