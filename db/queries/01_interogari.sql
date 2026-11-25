USE inchirieri_auto;

SELECT id_client, nume, prenume, telefon, email
FROM CLIENT
ORDER BY nume, prenume;

SELECT id_masina, marca, model, numar_inmatriculare, kilometraj_actual
FROM MASINA
WHERE stare_operationala = 'disponibila'
ORDER BY marca, model;

SELECT denumire, tarif_zi
FROM CATEGORIE_AUTO
WHERE tarif_zi <= 200
ORDER BY tarif_zi;

SELECT id_rezervare, id_client, id_masina, data_inceput, data_sfarsit, status
FROM REZERVARE
WHERE status IN ('noua', 'confirmata')
ORDER BY data_inceput;

SELECT r.id_rezervare, CONCAT(c.prenume,' ',c.nume) AS client,
       CONCAT(m.marca,' ',m.model) AS masina, r.data_inceput, r.data_sfarsit
FROM REZERVARE AS r
JOIN CLIENT AS c ON c.id_client = r.id_client
JOIN MASINA AS m ON m.id_masina = r.id_masina
WHERE c.id_client = 3
ORDER BY r.data_inceput DESC;

SELECT id_rezervare, nume_client, masina, status, data_inceput
FROM vw_rezervari_detalii
ORDER BY data_inceput DESC;

SELECT numar_inmatriculare, marca, model, categorie, tarif_zi
FROM vw_masini_categorii
ORDER BY tarif_zi DESC, marca;

SELECT c.denumire AS categorie, COUNT(m.id_masina) AS numar_masini
FROM CATEGORIE_AUTO AS c
LEFT JOIN MASINA AS m ON m.id_categorie = c.id_categorie
GROUP BY c.id_categorie, c.denumire
ORDER BY numar_masini DESC;

SELECT ca.denumire AS categorie,
       COUNT(*) AS numar_contracte,
       ROUND(AVG(ct.cost_total), 2) AS cost_mediu
FROM CONTRACT AS ct
JOIN REZERVARE AS r ON r.id_rezervare = ct.id_rezervare
JOIN MASINA AS m ON m.id_masina = r.id_masina
JOIN CATEGORIE_AUTO AS ca ON ca.id_categorie = m.id_categorie
WHERE ct.status = 'finalizat'
GROUP BY ca.id_categorie, ca.denumire
ORDER BY cost_mediu DESC;

SELECT c.id_client, CONCAT(c.prenume,' ',c.nume) AS client,
       COUNT(r.id_rezervare) AS numar_rezervari
FROM CLIENT AS c
JOIN REZERVARE AS r ON r.id_client = c.id_client
GROUP BY c.id_client, c.nume, c.prenume
HAVING COUNT(r.id_rezervare) >= 2
ORDER BY numar_rezervari DESC;

SELECT luna, numar_plati, total_incasari
FROM vw_incasari_lunare
ORDER BY luna;

SELECT id_contract, nume_client, cost_total, total_platit, rest_de_plata
FROM vw_contracte_financiar
WHERE rest_de_plata > 0
ORDER BY rest_de_plata DESC;

SELECT r.id_rezervare, r.status, r.data_inceput
FROM REZERVARE AS r
LEFT JOIN CONTRACT AS ct ON ct.id_rezervare = r.id_rezervare
WHERE ct.id_contract IS NULL
ORDER BY r.id_rezervare;

SELECT c.id_client, c.nume, c.prenume, c.email
FROM CLIENT AS c
LEFT JOIN REZERVARE AS r ON r.id_client = c.id_client
WHERE r.id_rezervare IS NULL;

SELECT id_masina, masina, numar_rezervari
FROM vw_utilizare_masini
ORDER BY numar_rezervari DESC, id_masina
LIMIT 5;

SELECT status, COUNT(*) AS numar_contracte
FROM CONTRACT
GROUP BY status
ORDER BY numar_contracte DESC;

SELECT m.id_masina, m.marca, m.model, m.numar_inmatriculare
FROM MASINA AS m
WHERE m.stare_operationala = 'disponibila'
  AND NOT EXISTS (
      SELECT 1
      FROM REZERVARE AS r
      WHERE r.id_masina = m.id_masina
        AND r.status IN ('noua', 'confirmata', 'in_desfasurare')
        AND r.data_inceput < '2027-01-18 10:00:00'
        AND r.data_sfarsit > '2027-01-15 10:00:00'
  )
ORDER BY m.marca, m.model;

SELECT ca.denumire AS categorie, SUM(ct.cost_total) AS total_contractat
FROM CONTRACT AS ct
JOIN REZERVARE AS r ON r.id_rezervare = ct.id_rezervare
JOIN MASINA AS m ON m.id_masina = r.id_masina
JOIN CATEGORIE_AUTO AS ca ON ca.id_categorie = m.id_categorie
WHERE ct.status = 'finalizat'
GROUP BY ca.id_categorie, ca.denumire
ORDER BY total_contractat DESC;

SELECT ca.denumire AS categorie, SUM(ct.cost_total) AS total_contractat
FROM CONTRACT AS ct
JOIN REZERVARE AS r ON r.id_rezervare = ct.id_rezervare
JOIN MASINA AS m ON m.id_masina = r.id_masina
JOIN CATEGORIE_AUTO AS ca ON ca.id_categorie = m.id_categorie
WHERE ct.status = 'finalizat'
GROUP BY ca.id_categorie, ca.denumire
HAVING SUM(ct.cost_total) > 2000
ORDER BY total_contractat DESC;

SELECT id_categorie, denumire, tarif_zi
FROM CATEGORIE_AUTO
WHERE tarif_zi > (SELECT AVG(tarif_zi) FROM CATEGORIE_AUTO)
ORDER BY tarif_zi DESC;

SELECT id_contract, id_rezervare, cost_total
FROM CONTRACT
WHERE status = 'finalizat'
  AND cost_total > (
      SELECT AVG(cost_total)
      FROM CONTRACT
      WHERE status = 'finalizat'
  )
ORDER BY cost_total DESC;

SELECT id_contract, cost_total,
       CASE
           WHEN cost_total IS NULL THEN 'cost necalculat'
           WHEN cost_total < 500 THEN 'mic'
           WHEN cost_total <= 1200 THEN 'mediu'
           ELSE 'mare'
       END AS categorie_cost
FROM CONTRACT
ORDER BY id_contract;

SELECT id_predictie, id_contract, versiune_model,
       kilometri_estimati, kilometri_reali, eroare_absoluta
FROM vw_predictii_comparatie
ORDER BY id_predictie;

WITH evaluari AS (
    SELECT versiune_model, eroare_absoluta
    FROM vw_predictii_comparatie
    WHERE eroare_absoluta IS NOT NULL
)
SELECT versiune_model, COUNT(*) AS numar_predictii_evaluate,
       ROUND(AVG(eroare_absoluta), 2) AS eroare_medie_absoluta_mae
FROM evaluari
GROUP BY versiune_model
ORDER BY eroare_medie_absoluta_mae;

SELECT c.denumire AS categorie, u.masina, u.numar_rezervari,
       DENSE_RANK() OVER (
           PARTITION BY m.id_categorie
           ORDER BY u.numar_rezervari DESC
       ) AS pozitie_in_categorie
FROM vw_utilizare_masini AS u
JOIN MASINA AS m ON m.id_masina = u.id_masina
JOIN CATEGORIE_AUTO AS c ON c.id_categorie = m.id_categorie
ORDER BY categorie, pozitie_in_categorie, u.masina;

SELECT ct.id_contract, ct.status, ct.cost_total
FROM CONTRACT AS ct
WHERE NOT EXISTS (
    SELECT 1 FROM PLATA AS p
    WHERE p.id_contract = ct.id_contract
      AND p.status_plata = 'efectuata'
)
ORDER BY ct.id_contract;

START TRANSACTION;

INSERT INTO CLIENT (nume, prenume, telefon, email)
VALUES ('Demo', 'Temporar', '0700009999', 'demo_crud@example.com');
SET @id_client_demo = LAST_INSERT_ID();
SELECT * FROM CLIENT WHERE id_client = @id_client_demo;

UPDATE CLIENT
SET telefon = '0700008888'
WHERE id_client = @id_client_demo;
SELECT * FROM CLIENT WHERE id_client = @id_client_demo;

DELETE FROM CLIENT
WHERE id_client = @id_client_demo;
SELECT COUNT(*) AS clienti_demo_ramasi
FROM CLIENT WHERE id_client = @id_client_demo;

ROLLBACK;
