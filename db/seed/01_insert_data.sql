USE inchirieri_auto;
START TRANSACTION;

INSERT INTO CLIENT (id_client, nume, prenume, telefon, email) VALUES
    (1, 'Popescu', 'Andrei', '0700000001', 'client01@example.com'),
    (2, 'Ionescu', 'Maria', '0700000002', 'client02@example.com'),
    (3, 'Georgescu', 'Mihai', '0700000003', 'client03@example.com'),
    (4, 'Dumitrescu', 'Elena', '0700000004', 'client04@example.com'),
    (5, 'Stan', 'Radu', '0700000005', 'client05@example.com'),
    (6, 'Marin', 'Ioana', '0700000006', 'client06@example.com'),
    (7, 'Tudor', 'Alex', '0700000007', 'client07@example.com'),
    (8, 'Dobre', 'Ana', '0700000008', 'client08@example.com'),
    (9, 'Munteanu', 'Vlad', '0700000009', 'client09@example.com'),
    (10, 'Rusu', 'Irina', '0700000010', 'client10@example.com'),
    (11, 'Matei', 'Sorin', '0700000011', 'client11@example.com'),
    (12, 'Petrescu', 'Alina', '0700000012', 'client12@example.com'),
    (13, 'Preda', 'Cristina', '0700000013', 'client13@example.com'),
    (14, 'Luca', 'Robert', '0700000014', 'client14@example.com');

INSERT INTO CATEGORIE_AUTO (id_categorie, denumire, descriere, tarif_zi) VALUES
    (1, 'Economica', 'Masini accesibile, pentru oras', 110.00),
    (2, 'Compacta', 'Masini compacte, pentru deplasari zilnice', 145.00),
    (3, 'Sedan', 'Masini confortabile pentru drumuri lungi', 190.00),
    (4, 'SUV', 'Masini spatioase pentru familie', 280.00),
    (5, 'Premium', 'Masini din gama superioara', 430.00),
    (6, 'Electrica', 'Masini cu propulsie electrica', 300.00);

INSERT INTO MASINA (id_masina, id_categorie, numar_inmatriculare, marca, model, an_fabricatie, stare_operationala, kilometraj_actual) VALUES
    (1, 1, 'MM-01-DEM', 'Dacia', 'Logan', 2022, 'disponibila', 13300),
    (2, 1, 'MM-02-DEM', 'Renault', 'Clio', 2023, 'disponibila', 18100),
    (3, 1, 'MM-03-DEM', 'Hyundai', 'i20', 2021, 'disponibila', 22900),
    (4, 2, 'MM-04-DEM', 'Skoda', 'Fabia', 2023, 'disponibila', 27700),
    (5, 2, 'MM-05-DEM', 'Volkswagen', 'Polo', 2022, 'disponibila', 32500),
    (6, 2, 'MM-06-DEM', 'Toyota', 'Yaris', 2024, 'mentenanta', 37300),
    (7, 3, 'MM-07-DEM', 'Toyota', 'Corolla', 2022, 'disponibila', 42100),
    (8, 3, 'MM-08-DEM', 'Skoda', 'Octavia', 2023, 'disponibila', 46900),
    (9, 3, 'MM-09-DEM', 'Mazda', '6', 2021, 'disponibila', 51700),
    (10, 4, 'MM-10-DEM', 'Dacia', 'Duster', 2022, 'disponibila', 56500),
    (11, 4, 'MM-11-DEM', 'Hyundai', 'Tucson', 2023, 'disponibila', 61300),
    (12, 4, 'MM-12-DEM', 'Kia', 'Sportage', 2024, 'disponibila', 66100),
    (13, 5, 'MM-13-DEM', 'BMW', 'Seria 5', 2023, 'disponibila', 70900),
    (14, 5, 'MM-14-DEM', 'Mercedes-Benz', 'Clasa E', 2022, 'disponibila', 75700),
    (15, 5, 'MM-15-DEM', 'Audi', 'A6', 2024, 'indisponibila', 80500),
    (16, 6, 'MM-16-DEM', 'Tesla', 'Model 3', 2023, 'disponibila', 85300),
    (17, 6, 'MM-17-DEM', 'Hyundai', 'Ioniq 5', 2024, 'disponibila', 90100),
    (18, 6, 'MM-18-DEM', 'Renault', 'Megane E-Tech', 2023, 'disponibila', 94900);

INSERT INTO REZERVARE (id_rezervare, id_client, id_masina, data_inceput, data_sfarsit, status, data_rezervare) VALUES
    (1, 1, 1, '2026-08-06 09:00:00', '2026-08-09 09:00:00', 'finalizata', '2026-07-19 09:00:00'),
    (2, 2, 2, '2026-08-11 09:00:00', '2026-08-15 09:00:00', 'finalizata', '2026-07-23 09:00:00'),
    (3, 3, 3, '2026-08-16 09:00:00', '2026-08-21 09:00:00', 'finalizata', '2026-07-27 09:00:00'),
    (4, 4, 4, '2026-08-21 09:00:00', '2026-08-27 09:00:00', 'finalizata', '2026-07-31 09:00:00'),
    (5, 5, 5, '2026-08-26 09:00:00', '2026-08-28 09:00:00', 'finalizata', '2026-08-04 09:00:00'),
    (6, 6, 6, '2026-08-31 09:00:00', '2026-09-03 09:00:00', 'finalizata', '2026-08-08 09:00:00'),
    (7, 7, 7, '2026-09-05 09:00:00', '2026-09-09 09:00:00', 'finalizata', '2026-08-19 09:00:00'),
    (8, 8, 8, '2026-09-10 09:00:00', '2026-09-15 09:00:00', 'finalizata', '2026-08-23 09:00:00'),
    (9, 9, 9, '2026-09-15 09:00:00', '2026-09-21 09:00:00', 'finalizata', '2026-08-27 09:00:00'),
    (10, 10, 10, '2026-09-20 09:00:00', '2026-09-22 09:00:00', 'finalizata', '2026-08-31 09:00:00'),
    (11, 11, 11, '2026-09-25 09:00:00', '2026-09-28 09:00:00', 'finalizata', '2026-09-04 09:00:00'),
    (12, 12, 12, '2026-09-30 09:00:00', '2026-10-04 09:00:00', 'finalizata', '2026-09-08 09:00:00'),
    (13, 1, 13, '2026-10-05 09:00:00', '2026-10-10 09:00:00', 'finalizata', '2026-09-12 09:00:00'),
    (14, 2, 14, '2026-10-10 09:00:00', '2026-10-16 09:00:00', 'finalizata', '2026-09-23 09:00:00'),
    (15, 3, 15, '2026-10-15 09:00:00', '2026-10-17 09:00:00', 'finalizata', '2026-09-27 09:00:00'),
    (16, 4, 16, '2026-10-20 09:00:00', '2026-10-23 09:00:00', 'finalizata', '2026-10-01 09:00:00'),
    (17, 5, 17, '2026-10-25 09:00:00', '2026-10-29 09:00:00', 'finalizata', '2026-10-05 09:00:00'),
    (18, 6, 18, '2026-10-30 09:00:00', '2026-11-04 09:00:00', 'finalizata', '2026-10-09 09:00:00'),
    (19, 6, 2, '2026-10-12 09:00:00', '2026-10-15 09:00:00', 'anulata', '2026-09-20 10:00:00'),
    (20, 9, 4, '2026-10-25 09:00:00', '2026-10-27 09:00:00', 'anulata', '2026-10-10 10:00:00'),
    (21, 5, 1, '2027-01-13 10:00:00', '2027-01-17 10:00:00', 'confirmata', '2026-11-12 10:00:00'),
    (22, 8, 4, '2027-01-18 10:00:00', '2027-01-22 10:00:00', 'confirmata', '2026-11-13 10:00:00'),
    (23, 4, 7, '2027-01-15 10:00:00', '2027-01-20 10:00:00', 'confirmata', '2026-11-14 10:00:00'),
    (24, 2, 10, '2027-01-09 10:00:00', '2027-01-12 10:00:00', 'confirmata', '2026-11-14 11:00:00'),
    (25, 11, 14, '2027-01-15 10:00:00', '2027-01-18 10:00:00', 'confirmata', '2026-11-16 10:00:00'),
    (26, 9, 5, '2027-02-04 10:00:00', '2027-02-09 10:00:00', 'noua', '2026-11-18 10:00:00'),
    (27, 7, 8, '2027-02-12 10:00:00', '2027-02-15 10:00:00', 'noua', '2026-11-19 10:00:00'),
    (28, 8, 3, '2026-11-23 09:00:00', '2026-11-28 09:00:00', 'in_desfasurare', '2026-11-05 10:00:00'),
    (29, 10, 12, '2026-11-24 09:00:00', '2026-12-01 09:00:00', 'in_desfasurare', '2026-11-06 10:00:00'),
    (30, 1, 17, '2027-03-20 10:00:00', '2027-03-26 10:00:00', 'confirmata', '2026-11-19 09:00:00');

INSERT INTO CONTRACT (id_contract, id_rezervare, data_predare, data_returnare, kilometraj_initial, kilometraj_final, cost_total, status) VALUES
    (1, 1, '2026-08-06 09:00:00', '2026-08-09 09:00:00', 13177, 13300, 330.00, 'finalizat'),
    (2, 2, '2026-08-11 09:00:00', '2026-08-15 09:00:00', 17954, 18100, 440.00, 'finalizat'),
    (3, 3, '2026-08-16 09:00:00', '2026-08-21 09:00:00', 22731, 22900, 550.00, 'finalizat'),
    (4, 4, '2026-08-21 09:00:00', '2026-08-27 09:00:00', 27508, 27700, 870.00, 'finalizat'),
    (5, 5, '2026-08-26 09:00:00', '2026-08-28 09:00:00', 32285, 32500, 290.00, 'finalizat'),
    (6, 6, '2026-08-31 09:00:00', '2026-09-03 09:00:00', 37062, 37300, 435.00, 'finalizat'),
    (7, 7, '2026-09-05 09:00:00', '2026-09-09 09:00:00', 41839, 42100, 760.00, 'finalizat'),
    (8, 8, '2026-09-10 09:00:00', '2026-09-15 09:00:00', 46616, 46900, 950.00, 'finalizat'),
    (9, 9, '2026-09-15 09:00:00', '2026-09-21 09:00:00', 51393, 51700, 1140.00, 'finalizat'),
    (10, 10, '2026-09-20 09:00:00', '2026-09-22 09:00:00', 56170, 56500, 560.00, 'finalizat'),
    (11, 11, '2026-09-25 09:00:00', '2026-09-28 09:00:00', 60947, 61300, 840.00, 'finalizat'),
    (12, 12, '2026-09-30 09:00:00', '2026-10-04 09:00:00', 65724, 66100, 1120.00, 'finalizat'),
    (13, 13, '2026-10-05 09:00:00', '2026-10-10 09:00:00', 70501, 70900, 2150.00, 'finalizat'),
    (14, 14, '2026-10-10 09:00:00', '2026-10-16 09:00:00', 75278, 75700, 2580.00, 'finalizat'),
    (15, 15, '2026-10-15 09:00:00', '2026-10-17 09:00:00', 80055, 80500, 860.00, 'finalizat'),
    (16, 16, '2026-10-20 09:00:00', '2026-10-23 09:00:00', 84832, 85300, 900.00, 'finalizat'),
    (17, 17, '2026-10-25 09:00:00', '2026-10-29 09:00:00', 89609, 90100, 1200.00, 'finalizat'),
    (18, 18, '2026-10-30 09:00:00', '2026-11-04 09:00:00', 94386, 94900, 1500.00, 'finalizat'),
    (19, 28, '2026-11-23 09:00:00', NULL, 22900, NULL, NULL, 'activ'),
    (20, 29, '2026-11-24 09:00:00', NULL, 66100, NULL, NULL, 'activ');

INSERT INTO PLATA (id_plata, id_contract, suma, data_plata, metoda_plata, status_plata) VALUES
    (1, 1, 132.00, '2026-08-06 09:00:00', 'card', 'efectuata'),
    (2, 1, 198.00, '2026-08-09 09:00:00', 'card', 'efectuata'),
    (3, 2, 440.00, '2026-08-15 09:00:00', 'card', 'efectuata'),
    (4, 3, 550.00, '2026-08-21 09:00:00', 'numerar', 'efectuata'),
    (5, 4, 870.00, '2026-08-27 09:00:00', 'card', 'efectuata'),
    (6, 5, 116.00, '2026-08-26 09:00:00', 'card', 'efectuata'),
    (7, 5, 174.00, '2026-08-28 09:00:00', 'card', 'efectuata'),
    (8, 6, 435.00, '2026-09-03 09:00:00', 'numerar', 'efectuata'),
    (9, 7, 760.00, '2026-09-09 09:00:00', 'card', 'efectuata'),
    (10, 8, 950.00, '2026-09-15 09:00:00', 'card', 'efectuata'),
    (11, 9, 456.00, '2026-09-15 09:00:00', 'card', 'efectuata'),
    (12, 9, 684.00, '2026-09-21 09:00:00', 'card', 'efectuata'),
    (13, 10, 560.00, '2026-09-22 09:00:00', 'card', 'efectuata'),
    (14, 11, 840.00, '2026-09-28 09:00:00', 'card', 'efectuata'),
    (15, 12, 1120.00, '2026-10-04 09:00:00', 'numerar', 'efectuata'),
    (16, 13, 860.00, '2026-10-05 09:00:00', 'card', 'efectuata'),
    (17, 13, 1290.00, '2026-10-10 09:00:00', 'card', 'efectuata'),
    (18, 14, 2580.00, '2026-10-16 09:00:00', 'card', 'efectuata'),
    (19, 15, 860.00, '2026-10-17 09:00:00', 'numerar', 'efectuata'),
    (20, 16, 900.00, '2026-10-23 09:00:00', 'card', 'efectuata'),
    (21, 17, 1200.00, '2026-10-31 09:00:00', 'card', 'rambursata'),
    (22, 18, 1500.00, '2026-11-04 09:00:00', 'numerar', 'efectuata'),
    (23, 8, 100.00, '2026-09-10 09:00:00', 'card', 'esuat'),
    (24, 19, 250.00, NULL, NULL, 'in_asteptare'),
    (25, 20, 300.00, '2026-11-24 10:00:00', 'card', 'efectuata'),
    (26, 20, 350.00, NULL, NULL, 'in_asteptare');

INSERT INTO PREDICTIE (id_predictie, id_contract, kilometri_estimati, data_predictie, versiune_model) VALUES
    (1, 1, 111.00, '2026-08-10 09:00:00', 'v1.0'),
    (2, 2, 164.00, '2026-08-16 09:00:00', 'v1.0'),
    (3, 3, 157.00, '2026-08-22 09:00:00', 'v1.0'),
    (4, 4, 210.00, '2026-08-28 09:00:00', 'v1.0'),
    (5, 5, 203.00, '2026-08-29 09:00:00', 'v1.0'),
    (6, 6, 256.00, '2026-09-04 09:00:00', 'v1.0'),
    (7, 7, 249.00, '2026-09-10 09:00:00', 'v1.0'),
    (8, 8, 302.00, '2026-09-16 09:00:00', 'v1.0'),
    (9, 9, 295.00, '2026-09-22 09:00:00', 'v1.0'),
    (10, 10, 348.00, '2026-09-23 09:00:00', 'v1.0'),
    (11, 11, 341.00, '2026-09-29 09:00:00', 'v1.0'),
    (12, 12, 394.00, '2026-10-05 09:00:00', 'v1.0'),
    (13, 19, 540.00, '2026-11-24 17:00:00', 'v1.0'),
    (14, 20, 780.00, '2026-11-25 16:00:00', 'v1.1');

COMMIT;

SELECT 'CLIENT' AS tabel, COUNT(*) AS numar_inregistrari FROM CLIENT;
SELECT 'CATEGORIE_AUTO' AS tabel, COUNT(*) AS numar_inregistrari FROM CATEGORIE_AUTO;
SELECT 'MASINA' AS tabel, COUNT(*) AS numar_inregistrari FROM MASINA;
SELECT 'REZERVARE' AS tabel, COUNT(*) AS numar_inregistrari FROM REZERVARE;
SELECT 'CONTRACT' AS tabel, COUNT(*) AS numar_inregistrari FROM CONTRACT;
SELECT 'PLATA' AS tabel, COUNT(*) AS numar_inregistrari FROM PLATA;
SELECT 'PREDICTIE' AS tabel, COUNT(*) AS numar_inregistrari FROM PREDICTIE;
