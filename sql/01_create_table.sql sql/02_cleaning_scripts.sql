-- 1. Standardize column names
ALTER TABLE superstore CHANGE `Customer ID` Customer_ID VARCHAR(50);
ALTER TABLE superstore CHANGE `Month` Order_Date_clean VARCHAR(20);

-- 2. Convert dates
UPDATE superstore
SET Order_Date = STR_TO_DATE(Order_Date, '%m/%d/%Y'),
    Ship_Date = STR_TO_DATE(Ship_Date, '%m/%d/%Y');

-- 3. Remove non-ASCII characters (product names)
UPDATE superstore
SET Product_Name = CONVERT(Product_Name USING ASCII);

-- 4. Trim spaces around text values
UPDATE superstore
SET
    Ship_Mode = TRIM(Ship_Mode),
    Customer_Name = TRIM(Customer_Name),
    Segment = TRIM(Segment),
    City = TRIM(City),
    State = TRIM(State),
    Category = TRIM(Category),
    Sub_Category = TRIM(Sub_Category);

-- 5. Handle missing postal codes
UPDATE superstore
SET Postal_Code = NULL
WHERE Postal_Code = ''
   OR Postal_Code = '0';

-- 6. Fix data types
ALTER TABLE superstore MODIFY Postal_Code VARCHAR(20);
ALTER TABLE superstore MODIFY Discount DECIMAL(5,2);

-- 7. Validate date conversion
SELECT Order_ID, Order_Date, Ship_Date
FROM superstore
WHERE Order_Date IS NULL OR Ship_Date IS NULL;
