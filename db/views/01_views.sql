
USE inchirieri_auto;
CREATE OR REPLACE VIEW vw_masini_categorii AS
SELECT
    m.id_masina, m.numar_inmatriculare, m.marca, m.model,
    m.an_fabricatie, m.stare_operationala, m.kilometraj_actual,
    c.id_categorie, c.denumire AS categorie, c.tarif_zi
FROM MASINA AS m
JOIN CATEGORIE_AUTO AS c ON c.id_categorie = m.id_categorie;

CREATE OR REPLACE VIEW vw_rezervari_detalii AS
SELECT
    r.id_rezervare, r.id_client,
    CONCAT(cl.prenume, ' ', cl.nume) AS nume_client,
    cl.email, r.id_masina,
    CONCAT(m.marca, ' ', m.model) AS masina,
    m.numar_inmatriculare,
    r.data_inceput, r.data_sfarsit, r.status, r.data_rezervare
FROM REZERVARE AS r
JOIN CLIENT AS cl ON cl.id_client = r.id_client
JOIN MASINA AS m ON m.id_masina = r.id_masina;

CREATE OR REPLACE VIEW vw_contracte_financiar AS
SELECT
    ct.id_contract, ct.id_rezervare, r.id_client,
    CONCAT(cl.prenume, ' ', cl.nume) AS nume_client,
    m.id_masina, CONCAT(m.marca, ' ', m.model) AS masina,
    ct.status AS status_contract,
    ct.cost_total,
    COALESCE(p.total_platit, 0.00) AS total_platit,
    CASE WHEN ct.cost_total IS NULL THEN NULL
         ELSE GREATEST(ct.cost_total - COALESCE(p.total_platit, 0.00), 0.00)
    END AS rest_de_plata
FROM CONTRACT AS ct
JOIN REZERVARE AS r ON r.id_rezervare = ct.id_rezervare
JOIN CLIENT AS cl ON cl.id_client = r.id_client
JOIN MASINA AS m ON m.id_masina = r.id_masina
LEFT JOIN (
    SELECT id_contract, SUM(suma) AS total_platit
    FROM PLATA
    WHERE status_plata = 'efectuata'
    GROUP BY id_contract
) AS p ON p.id_contract = ct.id_contract;

CREATE OR REPLACE VIEW vw_utilizare_masini AS
SELECT
    m.id_masina, m.numar_inmatriculare,
    CONCAT(m.marca, ' ', m.model) AS masina,
    COUNT(r.id_rezervare) AS numar_rezervari,
    SUM(CASE WHEN r.status = 'finalizata' THEN 1 ELSE 0 END) AS rezervari_finalizate
FROM MASINA AS m
LEFT JOIN REZERVARE AS r
    ON r.id_masina = m.id_masina AND r.status <> 'anulata'
GROUP BY m.id_masina, m.numar_inmatriculare, m.marca, m.model;

CREATE OR REPLACE VIEW vw_predictii_comparatie AS
SELECT
    p.id_predictie, p.id_contract, p.versiune_model, p.data_predictie,
    p.kilometri_estimati,
    CASE WHEN ct.kilometraj_initial IS NOT NULL AND ct.kilometraj_final IS NOT NULL
         THEN ct.kilometraj_final - ct.kilometraj_initial
         ELSE NULL
    END AS kilometri_reali,
    CASE WHEN ct.kilometraj_initial IS NOT NULL AND ct.kilometraj_final IS NOT NULL
         THEN ABS(p.kilometri_estimati - (ct.kilometraj_final - ct.kilometraj_initial))
         ELSE NULL
    END AS eroare_absoluta
FROM PREDICTIE AS p
JOIN CONTRACT AS ct ON ct.id_contract = p.id_contract;

CREATE OR REPLACE VIEW vw_incasari_lunare AS
SELECT
    DATE_FORMAT(data_plata, '%Y-%m') AS luna,
    COUNT(*) AS numar_plati,
    SUM(suma) AS total_incasari
FROM PLATA
WHERE status_plata = 'efectuata' AND data_plata IS NOT NULL
GROUP BY DATE_FORMAT(data_plata, '%Y-%m');

SHOW FULL TABLES WHERE Table_type = 'VIEW';
