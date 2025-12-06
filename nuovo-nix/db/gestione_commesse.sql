-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Dic 03, 2025 alle 11:17
-- Versione del server: 10.4.32-MariaDB
-- Versione PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gestione_commesse`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `anagrafica_clienti_fornitori`
--

CREATE TABLE `anagrafica_clienti_fornitori` (
  `data_inserimento` varchar(16) DEFAULT NULL,
  `tipo_soggetto` varchar(13) NOT NULL,
  `codice_fiscale` varchar(16) NOT NULL,
  `rag_sociale` varchar(60) DEFAULT NULL,
  `partita_iva` varchar(11) DEFAULT NULL,
  `recapito_telefonico_azienda` varchar(27) DEFAULT NULL,
  `indirizzo_email_azienda` varchar(23) DEFAULT NULL,
  `recapito_pec` varchar(12) DEFAULT NULL,
  `iscritti_albo` varchar(2) DEFAULT NULL,
  `idtiporapporto` int(11) DEFAULT NULL,
  `idtipopagatore` int(11) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `SDI` varchar(7) DEFAULT NULL,
  `split_payment` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `anagrafica_clienti_fornitori`
--

INSERT INTO `anagrafica_clienti_fornitori` (`data_inserimento`, `tipo_soggetto`, `codice_fiscale`, `rag_sociale`, `partita_iva`, `recapito_telefonico_azienda`, `indirizzo_email_azienda`, `recapito_pec`, `iscritti_albo`, `idtiporapporto`, `idtipopagatore`, `note`, `SDI`, `split_payment`) VALUES
('01/01/2025', 'Cliente', '00317740371', 'Cineca Consorzio Interuniversitario', '', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '00513990010', 'NTT DATA ITALIA SPA', '07988320011', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '00884761206', 'ALLNET.ITALIA SPA', '00884761206', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '00886171008', 'ERICSSON TELECOMUNICAZIONI S.P.A.', '00886171008', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '00886171008', 'ERICSSON TELECOMUNICAZIONI S.P.A.', '00886171008', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '00929440592', 'INFORDATA SPA', '00929440592', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '00967720285', 'ENGINEERING INGEGNERIA INFORMATICA SPA', '05724831002', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '01225340585', 'Autorita di sistema portuale del Mar Tirreno centro-settentr', '', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '01320740580', 'ENEA AGENZIA NAZ. PER LE NUOVE TEC. ENER. E SVIL. ECONOMICO', '00985801000', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '01571110244', 'OTB S.P.A.', '01571110244', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '01615230123', 'ERICSSON IT SOLUTIONS & SERVICES SPA', '09156560154', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '02022660357', 'ENERGEE 3 SRL', '02022660357', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '02355801206', 'HSPI S.P.A.', '02355801206', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '02361210590', 'GDS S.r.l.', '02361210590', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '02500250168', 'COMPUTER GROSS SPA', '04801490485', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '02517580920', 'WIND TRE SpA', '13378520152', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '02700960582', 'COMUNE DI CIVITAVECCHIA', '02700960582', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '02824320176', 'LUTECH S.P.A.', '02824320176', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '03008301214', 'NETGROUP SRL', '03008301214', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '03188950103', 'Deda Group Public Services Srl', '01727860221', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '03189950961', 'Oracle Italia S.R.L.', '03189950961', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '03318271214', 'DGS SPA', '03318271214', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '03339380366', 'NOVI DATA S.R.L.', '03339380366', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '03458800103', 'ITNET SRL', '05895251006', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '03662710361', 'Computer\'s Store srl', '03662710361', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '03682610245', 'SOLUZIONI MC SRL', '03682610245', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '03771621004', 'ASTER DATA CENTER SRL', '03771621004', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '04289511000', 'Cassa di Compensazione e Garanzia SpA', '10977060960', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '04423980483', 'Consorzio INSTM', '04423980483', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '04935230963', 'APPLE RETAIL ITALIA SRL', '04935230963', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '05091320159', 'ESPRINET SPA', '02999990969', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '05410741002', 'WIND TELECOMUNICAZIONI SPA', '05410741002', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '05779661007', 'TERNA SPA', '05779661007', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '06149921212', 'H2biz S.r.l.', '06149921212', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '06656421002', 'INDRA ITALIA SPA', '06656421002', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '06803880589', 'SOFTLAB SPA', '06803880589', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '07492991000', 'A.T.S. ASSISTANCE TECHNICAL SRL', '07492991000', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '07719191004', 'Topnetwork S.p.A.', '07719191004', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '08106710158', 'Microsoft Srl', '08106710158', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '08364111008', 'IT-Connect SRL', '08364111008', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '08610760582', 'GE.SI. GESTIONE SISTEMI S.R.L.', '02100511001', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '09255551005', 'GOLDBET SPA', '15432831004', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '09257071002', 'Lottomatica Scommesse S.p.A.', '09257071002', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '09338630016', 'Ringmaster S.r.l.', '09338630016', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '09668930010', 'SPINDOX S.P.A.', '09668930010', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '09709470018', 'SGS SRL', '09709470018', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '10967321000', 'GS GROUP IDEA SRL', '10967321000', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '11038340011', 'SIDIN SRL', '11038340011', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '11790971003', 'EGOMNIA SPA', '11790971003', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '11790971003', 'EGOMNIA SPA', '11790971003', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '11799181000', 'TERNA RETE ITALIA S.P.A.', '11799181000', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '12339020153', 'AUBAY ITALIA SPA', '12339020153', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '12614121007', 'NOMACHINE ITALY S.R.L.', '12614121007', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '13432971003', 'SILICONDEV SPA', '13432971003', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '14115741002', 'GREEN PEOPLE S.R.L.', '14115741002', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '14788511005', 'DATAMANAGEMENT ITALIA SPA', '14788511005', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '14788511005', 'DATAMANAGEMENT ITALIA SPA', '14788511005', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '16543811000', 'PASQUALONI SRLS', '16543811000', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '17502511003', 'OPNET S.r.l.', '17502511003', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', '17690791003', 'INNOVHEAD SRL', '17690791003', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '80199230584', 'CDP CASSA DEPOSITI E PRESTITI SPA', '07756511007', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', '97103880585', 'POSTE ITALIANE S.P.A.', '01114601006', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', 'CRPDNC78B10A028V', 'CRUPI DOMENICO', '16058061009', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', 'CSTMRZ73H13H501R', 'CUSTODI MAURIZIO', '13129441005', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', 'DMEGLL41M10F839X', 'DE MAIO GUGLIELMO', '14173401002', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', 'NNZFNC60T16L049J', 'NUNZELLA FRANCESCO', '09733540588', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Fornitore', 'PNZGFL67A02H501N', 'PINZARI GIAN FILIPPO', '14298431009', '', '', '', '', 0, 0, '', NULL, NULL),
('01/01/2025', 'Cliente', 'VRGCDT91S27H501N', 'VARGIU CLAUDIO ATTILIO', '17676151008', '', '', '', '', 0, 0, '', NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `anagrafica_dipendenti`
--

CREATE TABLE `anagrafica_dipendenti` (
  `codice_fiscale` varchar(16) NOT NULL,
  `data_inserimento` varchar(16) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `data_nascita` varchar(12) DEFAULT NULL,
  `comune_nascita` varchar(50) DEFAULT NULL,
  `provincia_nascita` varchar(2) DEFAULT NULL,
  `nazionalita` varchar(30) DEFAULT NULL,
  `comune_residenza` varchar(50) DEFAULT NULL,
  `prov_residenza` varchar(2) DEFAULT NULL,
  `cap_residenza` varchar(5) DEFAULT NULL,
  `indirizzo_residenza` varchar(50) DEFAULT NULL,
  `numero_civico_residenza` varchar(10) DEFAULT NULL,
  `comune_domicilio` varchar(50) DEFAULT NULL,
  `prov_domicilio` varchar(2) DEFAULT NULL,
  `cap_domicilio` varchar(5) DEFAULT NULL,
  `indirizzo_domicilio` varchar(50) DEFAULT NULL,
  `civico_domicilio` varchar(5) DEFAULT NULL,
  `numero_cellulare_aziendale` varchar(15) DEFAULT NULL,
  `numero_cellulare_personale` varchar(15) DEFAULT NULL,
  `disponibilita_cellulare` varchar(1) DEFAULT NULL,
  `datore_lavoro` int(11) DEFAULT NULL,
  `tipo_ccnl` int(11) DEFAULT NULL,
  `tipo_contratto_assunzione` int(11) DEFAULT NULL,
  `data_assunzione` varchar(15) DEFAULT NULL,
  `scadenza_se_determinato` varchar(15) DEFAULT NULL,
  `numero_eventuali_rinnovi` varchar(24) DEFAULT NULL,
  `durata_periodo_prova` int(11) DEFAULT NULL,
  `livello_inquadramento` varchar(45) DEFAULT NULL,
  `numero_matricola` varchar(10) DEFAULT NULL,
  `data_fine_rapporto` varchar(18) DEFAULT NULL,
  `tipo_fine_rapporto` int(11) DEFAULT NULL,
  `preavviso` decimal(5,2) DEFAULT NULL,
  `ruolo_commerciale` varchar(2) DEFAULT NULL,
  `ruolo_tecnico` varchar(2) DEFAULT NULL,
  `ruolo_manager` varchar(2) DEFAULT NULL,
  `ruolo_capo_progetto` varchar(2) DEFAULT NULL,
  `ruolo_account` varchar(2) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `anagrafica_dipendenti`
--

INSERT INTO `anagrafica_dipendenti` (`codice_fiscale`, `data_inserimento`, `cognome`, `nome`, `data_nascita`, `comune_nascita`, `provincia_nascita`, `nazionalita`, `comune_residenza`, `prov_residenza`, `cap_residenza`, `indirizzo_residenza`, `numero_civico_residenza`, `comune_domicilio`, `prov_domicilio`, `cap_domicilio`, `indirizzo_domicilio`, `civico_domicilio`, `numero_cellulare_aziendale`, `numero_cellulare_personale`, `disponibilita_cellulare`, `datore_lavoro`, `tipo_ccnl`, `tipo_contratto_assunzione`, `data_assunzione`, `scadenza_se_determinato`, `numero_eventuali_rinnovi`, `durata_periodo_prova`, `livello_inquadramento`, `numero_matricola`, `data_fine_rapporto`, `tipo_fine_rapporto`, `preavviso`, `ruolo_commerciale`, `ruolo_tecnico`, `ruolo_manager`, `ruolo_capo_progetto`, `ruolo_account`, `note`) VALUES
('BLLGLR73T57H501O', '01/01/2025', 'Bellone', 'Gloria', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, 'SI', NULL, NULL, NULL, NULL),
('BRSFRC72L19H501F', '01/01/2025', 'Brescia', 'Federico', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, 'SI', NULL, NULL, NULL, NULL),
('CCCSRN75B61H501V', '01/01/2025', 'Cucciniello', 'Sabrina', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, 'SI', NULL, NULL, NULL, NULL),
('CPPFBA77P23F839I', '01/01/2025', 'Coppolecchia', 'Fabio', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, 'SI', 'SI', NULL, 'SI', 'SI', NULL),
('CQFMCR74R57G942Z', '01/01/2025', 'Acquafredda', 'Maria Cristina', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('CSSDGI96H04H501E', '01/01/2025', 'Cossio La Rosa', 'Diego', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('DDNBDT78C46H501W', '01/01/2025', 'Di Donato', 'Benedetta', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('DGRNDR70S28F839A', '01/01/2025', 'Di Girolamo', 'Andrea', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('DLLRCR98A25H501W', '01/01/2025', 'Della Vecchia', 'Riccardo', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('DMSVCN82D22A783H', '01/01/2025', 'De Masi', 'Vincenzo', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('DRYSHC71D59Z114P', '01/01/2025', 'Dryell', 'Sarah Caroline', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('DSNMST78D45L049S', '01/01/2025', 'De Santis', 'Maristella', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('FLSMTT97M10D662C', '01/01/2025', 'Filosa', 'Mattia', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('FRTMNL99T30C773M', '01/01/2025', 'Fraticelli', 'Emanuele', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('GLDNRW77B01Z114F', '01/01/2025', 'Gold', 'Andrew Michael Sullivan', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('GNNFBA84L10Z600T', '01/01/2025', 'Giannotti', 'Fabio', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('HMDSNM82H12Z225T', '01/01/2025', 'Ahmed', 'Saman Mohammedjamal Ahmed', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('LMBLRT87R02H501J', '01/01/2025', 'Lombardo', 'Alberto', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('LTANDR88T08C351F', '01/01/2025', 'Alioto', 'Andrea', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('MGNMTN81C50H501E', '01/01/2025', 'Mugione', 'Martina', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, 'SI', NULL, NULL, NULL, NULL, NULL),
('MGRMRZ97B60H50', '01/01/2025', 'Magro', 'Marzia', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('MLNCLD78C44H501R', '01/01/2025', 'Milani', 'Claudia', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, 'SI', 'SI', 'SI', 'SI', 'SI', NULL),
('MNNDNC75A05F112T', '01/01/2025', 'Minnici', 'Domenico', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('MNTNNA58E67F83VM', '01/01/2025', 'Monti', 'Anna', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('MRCLSN95P17H501N', '01/01/2025', 'Marchionne', 'Alessandro', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('MRNGPP75P04I452K', '01/01/2025', 'Marongiu', 'Giuseppe', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, 'SI', NULL, 'SI', NULL, NULL),
('MROLRD78E16L182M', '01/01/2025', 'Moauro', 'Alfredo', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('MRRMRC75S04L049P', '01/01/2025', 'Morrone', 'Marco', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('MRTGLC73M13G273C', '01/01/2025', 'Martino', 'Gianluca', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('PCLMCR73M43G039T', '01/01/2025', 'Pacelli', 'Maria Cristina', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('PLMVLR84P02H501V', '01/01/2025', 'Palmieri', 'Valerio', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, 'NO', 'SI', 'SI', 'SI', 'NO', NULL),
('PZZLSN70C61H501F', '01/01/2025', 'Piazza', 'Alessandra', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SI', NULL, NULL, NULL, NULL, NULL),
('RMGSRA82S66D972V', '01/01/2025', 'Romagnoli', 'Sara', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('RNDDRN76P25C773W', '01/01/2025', 'Rando', 'Adriano', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'SI', NULL, NULL, NULL, NULL, NULL),
('RNDTZN78A62I548I', '01/01/2025', 'Renda', 'Tiziana', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('RNZMLR66H51H501K', '01/01/2025', 'Ronzoni', 'Maria Laura', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('RSCSRG61M08I754Z', '01/01/2025', 'Ruscica', 'Sergio', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('SVTFNC81D12H501X', '01/01/2025', 'Svetoni', 'Francesco', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('TCCVCN76A13F839K', '01/01/2025', 'Tuccillo', 'Vincenzo', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('TMPVCN80H22L049S', '01/01/2025', 'Tomai Pitinca', 'Vincenzo', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('TNIGRL80C05H501Y', '01/01/2025', 'Tino', 'Gabriele', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('TRCRFL76D16H926M', '01/01/2025', 'Toriaco', 'Raffaele', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('TSNFNC87R19H501Z', '01/01/2025', 'Tesone', 'Francesco', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('VLPNDR86T05H501D', '01/01/2025', 'Volpe', 'Andrea', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('VLRMRC99T07H501C', '01/01/2025', 'Valerio', 'Marco', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('VRNNGL78P19H501A', '01/01/2025', 'Iavarone', 'Angelo', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
('ZNLBTL87A10I452S', '01/01/2025', 'Zinellu', 'Bartolomeo', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 0, 0, 0, '', '', '', 0, '', '', '', 0, 0.00, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `asset_dipendente`
--

CREATE TABLE `asset_dipendente` (
  `codice_fiscale` varchar(16) NOT NULL,
  `tipo_asset` int(11) DEFAULT NULL,
  `data_inserimento` datetime(6) DEFAULT NULL,
  `data_assegnazione` datetime(6) DEFAULT NULL,
  `data_cessazione` datetime(6) DEFAULT NULL,
  `descrizione` varchar(100) DEFAULT NULL,
  `serial` varchar(100) DEFAULT NULL,
  `link_comodato_uso` varchar(45) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `attivita`
--

CREATE TABLE `attivita` (
  `codice_commessa` varchar(4) NOT NULL,
  `codice_macroattivita` varchar(2) NOT NULL,
  `codice_attivita` int(3) NOT NULL,
  `descrizione` varchar(1024) DEFAULT NULL,
  `numero_gg_u_lavorati_alla_data` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `attivita`
--

INSERT INTO `attivita` (`codice_commessa`, `codice_macroattivita`, `codice_attivita`, `descrizione`, `numero_gg_u_lavorati_alla_data`) VALUES
('1001', 'A', 10, 'affff', 55.00),
('1001', 'H', 15, NULL, NULL),
('1002', 'I', 20, NULL, NULL),
('1003', 'M', 30, NULL, NULL),
('1003', 'P', 40, NULL, NULL),
('1003', 'T', 50, NULL, NULL),
('1004', 'Z', 60, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `attivita_assegnate`
--

CREATE TABLE `attivita_assegnate` (
  `codice_commessa` varchar(4) NOT NULL,
  `codice_macroattivita` varchar(2) NOT NULL,
  `codice_attivita` int(3) NOT NULL,
  `codice_fiscale` varchar(16) NOT NULL,
  `data_inserimento_attivita` datetime(6) DEFAULT NULL,
  `data_fine_attivita` datetime(6) DEFAULT NULL,
  `descrizione` varchar(1024) DEFAULT NULL,
  `risorsa` varchar(45) DEFAULT NULL,
  `idruoli` bigint(20) DEFAULT NULL,
  `numero_gg_u_previsti_risorsa` decimal(5,2) DEFAULT NULL,
  `numero_gg_u_compensazione` decimal(5,2) DEFAULT NULL,
  `totale_gg_u_impegnati_risorsa` decimal(5,2) DEFAULT NULL,
  `costo_quotidiano_risorsa` decimal(10,2) DEFAULT NULL,
  `costo_totale_previsto_risorsa` decimal(10,2) DEFAULT NULL,
  `tariffa_giornaliera_richiesta_in_offerta` decimal(10,2) DEFAULT NULL,
  `totale_ricavo_prodotto_alla_data` decimal(10,2) DEFAULT NULL,
  `margine_prodotto_euro_alla_data` decimal(10,2) DEFAULT NULL,
  `margine_prodotto_percent_alla_data` decimal(10,2) DEFAULT NULL,
  `percent_avanzamento_alla_data` decimal(10,2) DEFAULT NULL,
  `gg_quantita_effettivi` decimal(10,2) DEFAULT NULL,
  `percentuale_realizzazione` decimal(10,2) DEFAULT NULL,
  `costo_alla_data` decimal(10,2) DEFAULT NULL,
  `ricavo_alla_data` decimal(10,2) DEFAULT NULL,
  `margine_alla_data` decimal(10,2) DEFAULT NULL,
  `percentuale_margine_alla_data` decimal(10,2) DEFAULT NULL,
  `data_ultimo_aggiornamento` datetime(6) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `attivita_assegnate`
--

INSERT INTO `attivita_assegnate` (`codice_commessa`, `codice_macroattivita`, `codice_attivita`, `codice_fiscale`, `data_inserimento_attivita`, `data_fine_attivita`, `descrizione`, `risorsa`, `idruoli`, `numero_gg_u_previsti_risorsa`, `numero_gg_u_compensazione`, `totale_gg_u_impegnati_risorsa`, `costo_quotidiano_risorsa`, `costo_totale_previsto_risorsa`, `tariffa_giornaliera_richiesta_in_offerta`, `totale_ricavo_prodotto_alla_data`, `margine_prodotto_euro_alla_data`, `margine_prodotto_percent_alla_data`, `percent_avanzamento_alla_data`, `gg_quantita_effettivi`, `percentuale_realizzazione`, `costo_alla_data`, `ricavo_alla_data`, `margine_alla_data`, `percentuale_margine_alla_data`, `data_ultimo_aggiornamento`, `note`) VALUES
('1001', '0', 0, 'MNNDNC75ARR340CT', NULL, NULL, 'attivita1', 'Minnici Domenico', 6, 10.00, 10.00, NULL, 50.00, 500.00, 70.00, 1400.00, 900.00, 64.29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1001', '0', 2, 'MNNDNC75ARR340CT', NULL, NULL, 'attivita1', 'Minnici Domenico', 6, 17.00, 10.00, NULL, 50.00, 850.00, 70.00, 1890.00, 1040.00, 55.03, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1002', '0', 0, 'MNNDNC75ARR340CT', NULL, NULL, 'attivita 1', 'Minnici Domenico', 6, 30.00, 10.00, NULL, 70.00, 2100.00, 90.00, 3600.00, 1500.00, 41.67, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1002', '0', 1, 'MNNDNC75ARR340CT', NULL, NULL, 'attivita 1', 'Minnici Domenico', 6, 40.00, 10.00, NULL, 70.00, 2800.00, 90.00, 4500.00, 1700.00, 37.78, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('1002', '0', 2, 'tecnologica', NULL, NULL, 'attivita 2', 'dsffsdfsd', 6, 20.00, 5.00, NULL, 70.00, 1400.00, 90.00, 2250.00, 850.00, 37.78, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `aumento_riassorbibile`
--

CREATE TABLE `aumento_riassorbibile` (
  `idaumento` int(11) NOT NULL,
  `aumento_riassorbibile_descr` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `aumento_riassorbibile`
--

INSERT INTO `aumento_riassorbibile` (`idaumento`, `aumento_riassorbibile_descr`) VALUES
(1, 'SI'),
(2, 'NO'),
(3, 'a discrezione DATORE'),
(4, 'ALTRO');

-- --------------------------------------------------------

--
-- Struttura della tabella `autorizzazioni`
--

CREATE TABLE `autorizzazioni` (
  `idautorizzazioni` bigint(20) NOT NULL,
  `anagrafica_dipendente` varchar(20) DEFAULT NULL,
  `clienti` varchar(20) DEFAULT NULL,
  `commesse` varchar(20) DEFAULT NULL,
  `risorse_assegnate` varchar(20) DEFAULT NULL,
  `timesheet` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `autorizzazioni`
--

INSERT INTO `autorizzazioni` (`idautorizzazioni`, `anagrafica_dipendente`, `clienti`, `commesse`, `risorse_assegnate`, `timesheet`) VALUES
(1, 'rwd', 'rwd', 'rwd', 'rwd', 'rwd'),
(2, 'rw', 'rw', 'rw', 'rw', 'rw'),
(3, 'Not authorized', 'Not authorized', 'Not authorized', 'Not authorized', 'rwd'),
(4, 'Not authorized', 'ls', 'ls', 'ls', 'ls');

-- --------------------------------------------------------

--
-- Struttura della tabella `certificazioni_dipendente`
--

CREATE TABLE `certificazioni_dipendente` (
  `codice_fiscale` varchar(16) NOT NULL,
  `data_inserimento` datetime(6) DEFAULT NULL,
  `titolo_certificazione` varchar(50) DEFAULT NULL,
  `certificazione` int(11) DEFAULT NULL,
  `ente_certificatore` varchar(45) DEFAULT NULL,
  `data_conseguimento` datetime(6) DEFAULT NULL,
  `data_scadenza` datetime(6) DEFAULT NULL,
  `link_certificato` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `clienti_assegnati`
--

CREATE TABLE `clienti_assegnati` (
  `codice_fiscale_clienti` varchar(16) NOT NULL,
  `codice_fiscale_commerciale` varchar(16) NOT NULL,
  `note` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `commesse`
--

CREATE TABLE `commesse` (
  `codice_commessa` varchar(4) NOT NULL,
  `data_inserimento_nuova_commessa` datetime(6) DEFAULT NULL,
  `data_offerta` datetime(6) DEFAULT NULL,
  `idstati` bigint(20) DEFAULT NULL,
  `descrizione` varchar(50) DEFAULT NULL,
  `codice_ordine` varchar(45) DEFAULT NULL,
  `data_ordine` datetime(6) DEFAULT NULL,
  `valore_ordine` decimal(10,2) DEFAULT NULL,
  `commerciale` varchar(60) DEFAULT NULL,
  `account_riferimento` varchar(20) DEFAULT NULL,
  `pm` varchar(60) DEFAULT NULL,
  `data_inizio_attivita` datetime(6) DEFAULT NULL,
  `data_rilascio_prevista` datetime(6) DEFAULT NULL,
  `valore_totale_stimato` bigint(20) DEFAULT NULL,
  `codice_fiscale_clienti` varchar(16) NOT NULL COMMENT 'Riferito a cliente Medialogic',
  `codice_fiscale_cliente_finale` varchar(16) NOT NULL,
  `numero_gg_u_previsti` decimal(5,2) DEFAULT NULL,
  `totale_costo_previsto` decimal(10,2) DEFAULT NULL,
  `margine_previsto_euro` decimal(10,2) DEFAULT NULL,
  `margine_previsto_percent` decimal(10,2) DEFAULT NULL,
  `numero_gg_u_lavorati_alla_data` decimal(10,2) DEFAULT NULL,
  `costo_totale_alla_data` decimal(10,2) DEFAULT NULL,
  `ricavo_totale_alla_data` decimal(10,2) DEFAULT NULL,
  `margine_euro_alla_data` decimal(10,2) DEFAULT NULL,
  `margine_percent_alla_data` decimal(10,2) DEFAULT NULL,
  `avanzamento_produzione_alla_data` decimal(10,2) DEFAULT NULL,
  `data_ultimo_aggiornamento` datetime(6) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `commesse`
--

INSERT INTO `commesse` (`codice_commessa`, `data_inserimento_nuova_commessa`, `data_offerta`, `idstati`, `descrizione`, `codice_ordine`, `data_ordine`, `valore_ordine`, `commerciale`, `account_riferimento`, `pm`, `data_inizio_attivita`, `data_rilascio_prevista`, `valore_totale_stimato`, `codice_fiscale_clienti`, `codice_fiscale_cliente_finale`, `numero_gg_u_previsti`, `totale_costo_previsto`, `margine_previsto_euro`, `margine_previsto_percent`, `numero_gg_u_lavorati_alla_data`, `costo_totale_alla_data`, `ricavo_totale_alla_data`, `margine_euro_alla_data`, `margine_percent_alla_data`, `avanzamento_produzione_alla_data`, `data_ultimo_aggiornamento`, `note`) VALUES
('1001', '2025-12-03 11:08:00.000000', '2025-11-03 01:00:00.000000', 1, 'Commessa di test inserimento', 'AB19', '2025-11-27 01:00:00.000000', 100000.00, 'CPPFBA77P23F839I', 'CPPFBA77P23F839I', 'CPPFBA77P23F839I', '2025-11-03 01:00:00.000000', '2025-11-27 01:00:00.000000', 60000, '00929440592', '02022660357', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-03 11:08:00.000000', 'adsfdfdfdsfd'),
('1002', '2025-11-28 11:10:00.000000', '2025-11-03 01:00:00.000000', 1, 'Commessa di test inserimento', 'AB19', '2025-11-28 01:00:00.000000', 14000.00, 'MLNCLD78C44H501R', 'CPPFBA77P23F839I', 'CPPFBA77P23F839I', '2025-11-03 01:00:00.000000', '2025-11-28 01:00:00.000000', 60000, '00513990010', '02824320176', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-28 11:10:00.000000', 'asdsffdsfdsfdfdf');

-- --------------------------------------------------------

--
-- Struttura della tabella `commesse_assegnate`
--

CREATE TABLE `commesse_assegnate` (
  `codice_commessa` varchar(4) NOT NULL,
  `codice_fiscale_commerciale` varchar(16) NOT NULL,
  `note` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `commesse_assegnate`
--

INSERT INTO `commesse_assegnate` (`codice_commessa`, `codice_fiscale_commerciale`, `note`) VALUES
('1001', 'CPPFBA77P23F839I', NULL),
('1002', 'MLNCLD78C44H501R', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `contatti`
--

CREATE TABLE `contatti` (
  `data_inserimento` datetime(6) DEFAULT NULL,
  `codice_fiscale` varchar(16) NOT NULL,
  `nominativo_contatto` varchar(50) DEFAULT NULL,
  `indirizzo_email_contatto` varchar(50) DEFAULT NULL,
  `tel_fisso_contatto` varchar(15) DEFAULT NULL,
  `tel_mobile_contatto` varchar(15) DEFAULT NULL,
  `ruolo` varchar(50) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `contatti`
--

INSERT INTO `contatti` (`data_inserimento`, `codice_fiscale`, `nominativo_contatto`, `indirizzo_email_contatto`, `tel_fisso_contatto`, `tel_mobile_contatto`, `ruolo`, `note`) VALUES
('2025-10-22 00:00:00.000000', 'Mnndnc75a05', 'Minnici & company', 'minnici@aaaa', '4224', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `datore_lavoro`
--

CREATE TABLE `datore_lavoro` (
  `iddatore_lavoro` int(11) NOT NULL,
  `datore_descr` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `datore_lavoro`
--

INSERT INTO `datore_lavoro` (`iddatore_lavoro`, `datore_descr`) VALUES
(1, 'SPA'),
(2, 'TLC'),
(3, 'TEC'),
(4, 'PRG'),
(5, 'MAI');

-- --------------------------------------------------------

--
-- Struttura della tabella `macro_attivita`
--

CREATE TABLE `macro_attivita` (
  `codice_commessa` varchar(4) NOT NULL,
  `codice_macroattivita` varchar(2) NOT NULL,
  `descrizione` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `macro_attivita`
--

INSERT INTO `macro_attivita` (`codice_commessa`, `codice_macroattivita`, `descrizione`) VALUES
('1001', '0', 'macro attivita 0 per nuova commessa'),
('1001', '1', 'macro attivita 1'),
('1002', '0', 'consulenza specialistica'),
('1002', '1', 'Presidio');

-- --------------------------------------------------------

--
-- Struttura della tabella `personale_dettagli_ral`
--

CREATE TABLE `personale_dettagli_ral` (
  `codice_fiscale` varchar(20) NOT NULL,
  `data_inserimento` varchar(16) NOT NULL,
  `tipo_inserimento` varchar(16) DEFAULT NULL,
  `lordo_mensile` varchar(13) DEFAULT NULL,
  `importo_mensile_aumento_retribiuto` varchar(34) DEFAULT NULL,
  `nuova_retribuzione_mensile` varchar(26) DEFAULT NULL,
  `ral` varchar(3) DEFAULT NULL,
  `costo_mensile` varchar(13) DEFAULT NULL,
  `costo_u_giornaliero` varchar(21) DEFAULT NULL,
  `media_gg_u_lavorb_mese` varchar(22) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dump dei dati per la tabella `personale_dettagli_ral`
--

INSERT INTO `personale_dettagli_ral` (`codice_fiscale`, `data_inserimento`, `tipo_inserimento`, `lordo_mensile`, `importo_mensile_aumento_retribiuto`, `nuova_retribuzione_mensile`, `ral`, `costo_mensile`, `costo_u_giornaliero`, `media_gg_u_lavorb_mese`) VALUES
('', '', '', '', '', '', '', ' 3.371,70 ', ' 192,67 ', '17,5'),
('BLLGLR73T57H501O', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.958,08 ', ' 226,18 ', '17,5'),
('BRSFRC72L19H501F', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.850,41 ', ' 220,02 ', '17,5'),
('CCCSRN75B61H501V', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.071,28 ', ' 232,64 ', '17,5'),
('CPPFBA77P23F839I', '01/11/2025', 'Iniziale', '', '', '', '', ' 10.500,00 ', ' 600,00 ', '17,5'),
('CSSDGI96H04H501E', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.675,00 ', ' 210,00 ', '17,5'),
('DDNBDT78C46H501W', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.967,52 ', ' 226,72 ', '17,5'),
('DLLRCR98A25H501W', '01/11/2025', 'Iniziale', '', '', '', '', ' 2.990,86 ', ' 170,91 ', '17,5'),
('DMSVCN82D22A783H', '01/11/2025', 'Iniziale', '', '', '', '', ' 5.105,56 ', ' 291,75 ', '17,5'),
('DRYSHC71D59Z114P', '01/11/2025', 'Iniziale', '', '', '', '', ' 8.334,79 ', ' 476,27 ', '17,5'),
('DSNMST78D45L049S', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.449,70 ', ' 197,13 ', '17,5'),
('FLSMTT97M10D662C', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.580,37 ', ' 261,74 ', '17,5'),
('FRTMNL99T30C773M', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.309,73 ', ' 189,13 ', '17,5'),
('GLDNRW77B01Z114F', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.694,97 ', ' 211,14 ', '17,5'),
('GNNFBA84L10Z600T', '01/11/2025', 'Iniziale', '', '', '', '', ' 2.712,50 ', ' 155,00 ', '17,5'),
('HMDSNM82H12Z225T', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.858,96 ', ' 220,51 ', '17,5'),
('LMBLRT87R02H501J', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.218,23 ', ' 241,04 ', '17,5'),
('LTANDR88T08C351F', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.479,89 ', ' 255,99 ', '17,5'),
('MGNMTN81C50H501E', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.794,43 ', ' 216,82 ', '17,5'),
('MGRMRZ97B60H501C', '01/11/2025', 'Iniziale', '', '', '', '', ' 2.265,55 ', ' 129,46 ', '17,5'),
('MLNCLD78C44H501R', '01/11/2025', 'Iniziale', '', '', '', '', ' 7.884,70 ', ' 450,55 ', '17,5'),
('MNNDNC75A05F112T', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.324,40 ', ' 247,11 ', '17,5'),
('MRCLSN95P17H501N', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.433,79 ', ' 196,22 ', '17,5'),
('MRNGPP75P04I452K', '01/11/2025', 'Iniziale', '', '', '', '', ' 5.859,84 ', ' 334,85 ', '17,5'),
('MROLRD78E16L182M', '01/11/2025', 'Iniziale', '', '', '', '', ' 5.467,90 ', ' 312,45 ', '17,5'),
('MRRMRC75S04L049P', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.967,76 ', ' 226,73 ', '17,5'),
('PCLMCR73M43G039T', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.881,77 ', ' 221,82 ', '17,5'),
('PLMVLR84P02H501V', '01/11/2025', 'Iniziale', '', '', '', '', ' 5.184,78 ', ' 296,27 ', '17,5'),
('RMGSRA82S66D972V', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.015,96 ', ' 229,48 ', '17,5'),
('RNDTZN78A62I548I', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.307,80 ', ' 189,02 ', '17,5'),
('SVTFNC81D12H501X', '01/11/2025', 'Iniziale', '', '', '', '', ' 9.747,95 ', ' 557,03 ', '17,5'),
('TCCVCN76A13F839K', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.568,56 ', ' 261,06 ', '17,5'),
('TMPVCN80H22L049S', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.261,72 ', ' 243,53 ', '17,5'),
('TRCRFL76D16H926M', '01/11/2025', 'Iniziale', '', '', '', '', ' 8.805,98 ', ' 503,20 ', '17,5'),
('TSNFNC87R19H501Z', '01/11/2025', 'Iniziale', '', '', '', '', ' 5.212,08 ', ' 297,83 ', '17,5'),
('VLPNDR86T05H501D', '01/11/2025', 'Iniziale', '', '', '', '', ' 4.766,02 ', ' 272,34 ', '17,5'),
('VLRMRC99T07H501C', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.371,70 ', ' 192,67 ', '17,5'),
('VRNNGL78P19H501A', '01/11/2025', 'Iniziale', '', '', '', '', ' 3.944,10 ', ' 225,38 ', '17,5');

-- --------------------------------------------------------

--
-- Struttura della tabella `ral`
--

CREATE TABLE `ral` (
  `codice_fiscale` varchar(16) NOT NULL,
  `data_inserimento` datetime(6) NOT NULL,
  `tipo_inserimento` int(11) DEFAULT NULL,
  `lordo_mensile` decimal(9,2) DEFAULT NULL,
  `importo_mensile_aumento_retribiuto` decimal(9,2) DEFAULT NULL,
  `nuova_retribuzione_mensile` decimal(9,2) DEFAULT NULL,
  `ral` decimal(9,2) DEFAULT NULL,
  `costo_mensile` decimal(9,2) DEFAULT NULL,
  `costo_u_giornaliero` decimal(9,2) DEFAULT NULL,
  `media_gg_u_lavorb_mese` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ral`
--

INSERT INTO `ral` (`codice_fiscale`, `data_inserimento`, `tipo_inserimento`, `lordo_mensile`, `importo_mensile_aumento_retribiuto`, `nuova_retribuzione_mensile`, `ral`, `costo_mensile`, `costo_u_giornaliero`, `media_gg_u_lavorb_mese`) VALUES
('Mnndnc75a05', '2025-10-22 00:00:00.000000', 1, 1800.00, NULL, NULL, 26000.00, NULL, 70.00, 17.00);

-- --------------------------------------------------------

--
-- Struttura della tabella `ruoli`
--

CREATE TABLE `ruoli` (
  `idruoli` bigint(20) NOT NULL,
  `ruoli_descr` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `ruoli`
--

INSERT INTO `ruoli` (`idruoli`, `ruoli_descr`) VALUES
(0, 'Analista'),
(1, 'Programmatore'),
(2, 'Commerciale'),
(3, 'Dirigente'),
(4, 'Tecnico'),
(5, 'Impiegato'),
(6, 'Dipendente');

-- --------------------------------------------------------

--
-- Struttura della tabella `sedi`
--

CREATE TABLE `sedi` (
  `data_inserimento` datetime(6) DEFAULT NULL,
  `codice_fiscale` varchar(16) NOT NULL,
  `tipo_sede` int(11) DEFAULT NULL,
  `nazione_sede` varchar(50) DEFAULT NULL,
  `comune_sede` varchar(50) DEFAULT NULL,
  `provincia_sede` varchar(2) DEFAULT NULL,
  `cap_sede` varchar(5) DEFAULT NULL,
  `indirizzo_sede` varchar(50) DEFAULT NULL,
  `civico_sede` varchar(10) DEFAULT NULL,
  `recapito_telefonico_azienda` varchar(15) DEFAULT NULL,
  `email_sede` varchar(25) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `sedi`
--

INSERT INTO `sedi` (`data_inserimento`, `codice_fiscale`, `tipo_sede`, `nazione_sede`, `comune_sede`, `provincia_sede`, `cap_sede`, `indirizzo_sede`, `civico_sede`, `recapito_telefonico_azienda`, `email_sede`, `note`) VALUES
('2025-10-22 00:00:00.000000', 'Mnndnc75a05', 1, 'Italia', 'Roma', 'RM', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `stati`
--

CREATE TABLE `stati` (
  `idstati` bigint(20) NOT NULL,
  `descrizione` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `stati`
--

INSERT INTO `stati` (`idstati`, `descrizione`) VALUES
(1, 'In preanalisi senza Offerta'),
(2, 'Offerta'),
(3, 'Offerta in valutazione del Cliente'),
(4, ' Offerta Valutata e in attesa di Conferma/Ordine'),
(5, ' Commessa in lavorazione senza Ordine'),
(6, ' Commessa in lavorazione con Ordine'),
(7, 'Commessa rilasciata e Chiusa'),
(8, 'Commessa sospesa dal Cliente o annullata');

-- --------------------------------------------------------

--
-- Struttura della tabella `timesheet`
--

CREATE TABLE `timesheet` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `data_attivita` datetime(6) DEFAULT NULL,
  `codice_fiscale` varchar(16) NOT NULL,
  `codice_commessa` varchar(4) DEFAULT NULL,
  `codice_macroattivita` varchar(2) DEFAULT NULL,
  `codice_attivita` int(3) DEFAULT NULL,
  `descrizione_lavoro_svolto` varchar(1024) DEFAULT NULL,
  `ore_lavorate` decimal(4,2) DEFAULT NULL,
  `gg_lavorati` decimal(5,2) DEFAULT NULL,
  `nota_attivita` varchar(1024) DEFAULT NULL,
  `data_inserimento` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `timesheet`
--

INSERT INTO `timesheet` (`data_attivita`, `codice_fiscale`, `codice_commessa`, `codice_macroattivita`, `codice_attivita`, `descrizione_lavoro_svolto`, `ore_lavorate`, `gg_lavorati`, `nota_attivita`, `data_inserimento`) VALUES
('2025-08-17 02:00:00.000000', 'MNNDNC75ARR340CT', '2010', 'B4', 109, 'servizi oracle 10', 8.00, 3.00, 'Attivita di restore database', SYSDATE());

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_asset`
--

CREATE TABLE `tipo_asset` (
  `idtipo_asset` int(11) NOT NULL,
  `descrizione` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipo_asset`
--

INSERT INTO `tipo_asset` (`idtipo_asset`, `descrizione`) VALUES
(1, 'cellulare'),
(2, 'pc'),
(3, 'licenze software'),
(4, 'monitor'),
(5, 'SIM');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_certificazione`
--

CREATE TABLE `tipo_certificazione` (
  `idtipo_certificazione` int(11) NOT NULL,
  `descrizione` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipo_certificazione`
--

INSERT INTO `tipo_certificazione` (`idtipo_certificazione`, `descrizione`) VALUES
(1, 'attestato formazione 81/2008 base+ specifico (obb)'),
(2, 'attestato formazione 81/2088 RLS'),
(3, 'attestato formazione 81/2088 Preposto'),
(4, 'attestato formazione 81/2088 RSPP'),
(5, 'attestato formazione 81/2088 Datore di Lavoro'),
(6, 'attestato formazione Primo Soccorso'),
(7, 'attestato formazione Addetto Antincendio'),
(8, 'attestato idoneità alla Mansione  (obb)');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_contratto`
--

CREATE TABLE `tipo_contratto` (
  `idtipo_contratto` int(11) NOT NULL,
  `descr_tipo_contratto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipo_contratto`
--

INSERT INTO `tipo_contratto` (`idtipo_contratto`, `descr_tipo_contratto`) VALUES
(1, 'Tempo Indeterminato'),
(2, 'Tempo Determinato'),
(3, 'Apprendistato');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_fine_rapporto`
--

CREATE TABLE `tipo_fine_rapporto` (
  `idtipo_fine_rapporto` int(11) NOT NULL,
  `fine_rapporto_descr` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipo_fine_rapporto`
--

INSERT INTO `tipo_fine_rapporto` (`idtipo_fine_rapporto`, `fine_rapporto_descr`) VALUES
(1, 'dimissioni'),
(2, 'licenziamento');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_pagatore`
--

CREATE TABLE `tipo_pagatore` (
  `idtipo_pagatore` int(11) NOT NULL,
  `pagatore_descr` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipo_pagatore`
--

INSERT INTO `tipo_pagatore` (`idtipo_pagatore`, `pagatore_descr`) VALUES
(1, 'Puntuale'),
(2, 'Ritardatario'),
(3, 'Moroso'),
(4, 'a Rischio');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_rapporto`
--

CREATE TABLE `tipo_rapporto` (
  `idtipo_rapporto` int(11) NOT NULL,
  `range_fatturato` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipo_rapporto`
--

INSERT INTO `tipo_rapporto` (`idtipo_rapporto`, `range_fatturato`) VALUES
(1, '0-50000'),
(2, '50000-100000'),
(3, '100000-200000');

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_variazione`
--

CREATE TABLE `tipo_variazione` (
  `idtipovariazione` int(11) NOT NULL,
  `descr_variazione` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `tipo_variazione`
--

INSERT INTO `tipo_variazione` (`idtipovariazione`, `descr_variazione`) VALUES
(1, 'Aumenti contrattuali'),
(2, 'Aumenti ad personam');

-- --------------------------------------------------------

--
-- Struttura della tabella `utenze`
--

CREATE TABLE `utenze` (
  `codice_fiscale` varchar(16) NOT NULL,
  `user_id` varchar(35) NOT NULL,
  `password` varchar(12) DEFAULT NULL,
  `idautorizzazioni` bigint(20) DEFAULT NULL,
  `data_creazione_accesso` datetime DEFAULT NULL,
  `cambio_password` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `utenze`
--

INSERT INTO `utenze` (`codice_fiscale`, `user_id`, `password`, `idautorizzazioni`, `data_creazione_accesso`, `cambio_password`) VALUES
('CPPFBA77P23F839I', 'coppellecchia@medialogic.it', 'c', 4, '2025-04-11 11:00:00', 'SI'),
('MLNCLD78C44H501R', 'milani@medialogic.it', 'm', 4, '2025-04-11 11:00:00', 'SI'),
('MNNDNC75ARR340CT', 'minnici@medialogic.it', 'm', 1, '2025-04-11 11:00:00', 'NO');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `anagrafica_clienti_fornitori`
--
ALTER TABLE `anagrafica_clienti_fornitori`
  ADD PRIMARY KEY (`codice_fiscale`,`tipo_soggetto`),
  ADD KEY `idx_idtiporapporto` (`idtiporapporto`),
  ADD KEY `idtipopagatore` (`idtipopagatore`);

--
-- Indici per le tabelle `anagrafica_dipendenti`
--
ALTER TABLE `anagrafica_dipendenti`
  ADD PRIMARY KEY (`codice_fiscale`);

--
-- Indici per le tabelle `asset_dipendente`
--
ALTER TABLE `asset_dipendente`
  ADD PRIMARY KEY (`codice_fiscale`);

--
-- Indici per le tabelle `attivita`
--
ALTER TABLE `attivita`
  ADD PRIMARY KEY (`codice_commessa`,`codice_macroattivita`,`codice_attivita`);

--
-- Indici per le tabelle `attivita_assegnate`
--
ALTER TABLE `attivita_assegnate`
  ADD PRIMARY KEY (`codice_commessa`,`codice_macroattivita`,`codice_attivita`),
  ADD KEY `idx_idruoli` (`idruoli`),
  ADD KEY `idx_codice_commessa` (`codice_commessa`);

--
-- Indici per le tabelle `aumento_riassorbibile`
--
ALTER TABLE `aumento_riassorbibile`
  ADD PRIMARY KEY (`idaumento`);

--
-- Indici per le tabelle `autorizzazioni`
--
ALTER TABLE `autorizzazioni`
  ADD PRIMARY KEY (`idautorizzazioni`);

--
-- Indici per le tabelle `certificazioni_dipendente`
--
ALTER TABLE `certificazioni_dipendente`
  ADD PRIMARY KEY (`codice_fiscale`);

--
-- Indici per le tabelle `clienti_assegnati`
--
ALTER TABLE `clienti_assegnati`
  ADD PRIMARY KEY (`codice_fiscale_clienti`,`codice_fiscale_commerciale`);

--
-- Indici per le tabelle `commesse`
--
ALTER TABLE `commesse`
  ADD PRIMARY KEY (`codice_commessa`),
  ADD KEY `idx_idstati` (`idstati`),
  ADD KEY `idx_codice_fiscale_clienti` (`codice_fiscale_clienti`);

--
-- Indici per le tabelle `commesse_assegnate`
--
ALTER TABLE `commesse_assegnate`
  ADD PRIMARY KEY (`codice_commessa`,`codice_fiscale_commerciale`);

--
-- Indici per le tabelle `contatti`
--
ALTER TABLE `contatti`
  ADD PRIMARY KEY (`codice_fiscale`);

--
-- Indici per le tabelle `datore_lavoro`
--
ALTER TABLE `datore_lavoro`
  ADD PRIMARY KEY (`iddatore_lavoro`);

--
-- Indici per le tabelle `macro_attivita`
--
ALTER TABLE `macro_attivita`
  ADD PRIMARY KEY (`codice_commessa`,`codice_macroattivita`);

--
-- Indici per le tabelle `personale_dettagli_ral`
--
ALTER TABLE `personale_dettagli_ral`
  ADD PRIMARY KEY (`codice_fiscale`,`data_inserimento`);

--
-- Indici per le tabelle `ral`
--
ALTER TABLE `ral`
  ADD PRIMARY KEY (`codice_fiscale`,`data_inserimento`);

--
-- Indici per le tabelle `ruoli`
--
ALTER TABLE `ruoli`
  ADD PRIMARY KEY (`idruoli`);

--
-- Indici per le tabelle `sedi`
--
ALTER TABLE `sedi`
  ADD PRIMARY KEY (`codice_fiscale`);

--
-- Indici per le tabelle `stati`
--
ALTER TABLE `stati`
  ADD PRIMARY KEY (`idstati`);

--
-- Indici per le tabelle `timesheet`
--

--
-- Indici per le tabelle `tipo_asset`
--
ALTER TABLE `tipo_asset`
  ADD PRIMARY KEY (`idtipo_asset`);

--
-- Indici per le tabelle `tipo_certificazione`
--
ALTER TABLE `tipo_certificazione`
  ADD PRIMARY KEY (`idtipo_certificazione`);

--
-- Indici per le tabelle `tipo_contratto`
--
ALTER TABLE `tipo_contratto`
  ADD PRIMARY KEY (`idtipo_contratto`);

--
-- Indici per le tabelle `tipo_fine_rapporto`
--
ALTER TABLE `tipo_fine_rapporto`
  ADD PRIMARY KEY (`idtipo_fine_rapporto`);

--
-- Indici per le tabelle `tipo_pagatore`
--
ALTER TABLE `tipo_pagatore`
  ADD PRIMARY KEY (`idtipo_pagatore`);

--
-- Indici per le tabelle `tipo_rapporto`
--
ALTER TABLE `tipo_rapporto`
  ADD PRIMARY KEY (`idtipo_rapporto`);

--
-- Indici per le tabelle `tipo_variazione`
--
ALTER TABLE `tipo_variazione`
  ADD PRIMARY KEY (`idtipovariazione`);

--
-- Indici per le tabelle `utenze`
--
ALTER TABLE `utenze`
  ADD PRIMARY KEY (`codice_fiscale`,`user_id`),
  ADD KEY `idx_idautorizzazioni` (`idautorizzazioni`);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `attivita_assegnate`
--
ALTER TABLE `attivita_assegnate`
  ADD CONSTRAINT `FK_idruoli` FOREIGN KEY (`idruoli`) REFERENCES `ruoli` (`idruoli`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `commesse`
--
ALTER TABLE `commesse`
  ADD CONSTRAINT `FK_idstati` FOREIGN KEY (`idstati`) REFERENCES `stati` (`idstati`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `utenze`
--
ALTER TABLE `utenze`
  ADD CONSTRAINT `FK_idautorizzazioni` FOREIGN KEY (`idautorizzazioni`) REFERENCES `autorizzazioni` (`idautorizzazioni`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

