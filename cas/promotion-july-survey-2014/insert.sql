SELECT ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID FROM july_survey


insert into july_survey2 (ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID)
SELECT ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID FROM july_survey


insert into july_survey2 (ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID) 
SELECT ID, Q1, Product, Q2, Q3, Q4, Q5, FirstName, LastName, Email, Street, City, State, Zipcode, Country, FormID FROM july_survey where ID=135