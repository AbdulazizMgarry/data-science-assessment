CREATE TABLE sectors (
    sector_id INTEGER PRIMARY KEY,
    sector_name TEXT
);

INSERT INTO sectors (sector_id, sector_name) VALUES
(10, 'Financial Services'),
(20, 'Real Estate'),
(30, 'Software'),
(40, 'Energy'),
(50, 'Technology Hardware & Equipment');

CREATE TABLE investor_transactions (
    investor_id INTEGER,
    sector_id INTEGER,
    no_of_shares INTEGER
);

INSERT INTO investor_transactions (investor_id, sector_id, no_of_shares) VALUES
(1, 10, 15),
(1, 20, 10),
(1, 30, 12),
(2, 40, 20),
(2, 50, 15);



SELECT
    t.investor_id,
    s.sector_name,
 
    ROUND(
        CAST(t.no_of_shares AS REAL) * 100.0 / 
        SUM(t.no_of_shares) OVER (PARTITION BY t.investor_id),
        2
    ) AS share_percentage
FROM
    investor_transactions AS t
JOIN
    sectors AS s
ON
    t.sector_id = s.sector_id
ORDER BY
    t.investor_id,
    share_percentage DESC;
