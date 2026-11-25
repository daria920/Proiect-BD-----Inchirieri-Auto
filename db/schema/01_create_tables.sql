CREATE DATABASE IF NOT EXISTS inchirieri_auto
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE inchirieri_auto;

CREATE TABLE IF NOT EXISTS CLIENT (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nume VARCHAR(80) NOT NULL,
    prenume VARCHAR(80) NOT NULL,
    telefon VARCHAR(20) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS CATEGORIE_AUTO (
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    denumire VARCHAR(50) NOT NULL UNIQUE,
    descriere VARCHAR(255),
    tarif_zi DECIMAL(10, 2) NOT NULL,
    CONSTRAINT chk_categorie_tarif CHECK (tarif_zi > 0)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS MASINA (
    id_masina INT AUTO_INCREMENT PRIMARY KEY,
    id_categorie INT NOT NULL,
    numar_inmatriculare VARCHAR(20) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    an_fabricatie INT NOT NULL,
    stare_operationala VARCHAR(30) NOT NULL DEFAULT 'disponibila',
    kilometraj_actual INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_masina_categorie
        FOREIGN KEY (id_categorie) REFERENCES CATEGORIE_AUTO(id_categorie)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_masina_an CHECK (an_fabricatie BETWEEN 1886 AND 2100),
    CONSTRAINT chk_masina_kilometraj CHECK (kilometraj_actual >= 0),
    CONSTRAINT chk_masina_stare CHECK (
        stare_operationala IN ('disponibila', 'indisponibila', 'mentenanta')
    )
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS REZERVARE (
    id_rezervare INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT NOT NULL,
    id_masina INT NOT NULL,
    data_inceput DATETIME NOT NULL,
    data_sfarsit DATETIME NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'noua',
    data_rezervare DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_rezervare_client
        FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_rezervare_masina
        FOREIGN KEY (id_masina) REFERENCES MASINA(id_masina)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_rezervare_interval CHECK (data_sfarsit > data_inceput),
    CONSTRAINT chk_rezervare_status CHECK (
        status IN ('noua', 'confirmata', 'in_desfasurare', 'anulata', 'finalizata')
    )
) ENGINE = InnoDB;

-- 5. Contractele rezultate din rezervari
CREATE TABLE IF NOT EXISTS CONTRACT (
    id_contract INT AUTO_INCREMENT PRIMARY KEY,
    id_rezervare INT NOT NULL UNIQUE,
    data_predare DATETIME,
    data_returnare DATETIME,
    kilometraj_initial INT,
    kilometraj_final INT,
    cost_total DECIMAL(10, 2),
    status VARCHAR(30) NOT NULL DEFAULT 'activ',
    CONSTRAINT fk_contract_rezervare
        FOREIGN KEY (id_rezervare) REFERENCES REZERVARE(id_rezervare)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_contract_date CHECK (
        data_returnare IS NULL
        OR (data_predare IS NOT NULL AND data_returnare >= data_predare)
    ),
    CONSTRAINT chk_contract_km_initial CHECK (
        kilometraj_initial IS NULL OR kilometraj_initial >= 0
    ),
    CONSTRAINT chk_contract_km_final CHECK (
        kilometraj_final IS NULL OR kilometraj_final >= 0
    ),
    CONSTRAINT chk_contract_km_ordine CHECK (
        kilometraj_final IS NULL OR kilometraj_initial IS NULL
        OR kilometraj_final >= kilometraj_initial
    ),
    CONSTRAINT chk_contract_cost CHECK (cost_total IS NULL OR cost_total >= 0),
    CONSTRAINT chk_contract_status CHECK (
        status IN ('activ', 'finalizat', 'anulat')
    )
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS PLATA (
    id_plata INT AUTO_INCREMENT PRIMARY KEY,
    id_contract INT NOT NULL,
    suma DECIMAL(10, 2) NOT NULL,
    data_plata DATETIME,
    metoda_plata VARCHAR(30),
    status_plata VARCHAR(30) NOT NULL DEFAULT 'in_asteptare',
    CONSTRAINT fk_plata_contract
        FOREIGN KEY (id_contract) REFERENCES CONTRACT(id_contract)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_plata_suma CHECK (suma > 0),
    CONSTRAINT chk_plata_status CHECK (
        status_plata IN ('in_asteptare', 'efectuata', 'esuat', 'rambursata')
    )
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS PREDICTIE (
    id_predictie INT AUTO_INCREMENT PRIMARY KEY,
    id_contract INT NOT NULL,
    kilometri_estimati DECIMAL(10, 2) NOT NULL,
    data_predictie DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    versiune_model VARCHAR(30) NOT NULL,
    CONSTRAINT fk_predictie_contract
        FOREIGN KEY (id_contract) REFERENCES CONTRACT(id_contract)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_predictie_kilometri CHECK (kilometri_estimati >= 0)
) ENGINE = InnoDB;

SHOW TABLES;
