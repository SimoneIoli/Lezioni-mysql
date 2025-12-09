INSERT INTO moduli (nome, numero_ore, unita_formativa_id) VALUES
('Sicurezza Informatica', 25, 1),
('Analisi dei Dati', 30, 2),
('Cloud Computing', 20, 3);
/*Query di selezione: la SELECT (ovvero la possibilità di leggere i dati)*/
SELECT * FROM moduli; /*Seleziono tutti i dati dentro la tabella*/
SELECT nome, numero_ore FROM moduli; /*Seleziono solo le colonne nome e numero_ore (così avrò un risparmio di dati)*/

SELECT moduli.nome, unita_formative.nome FROM moduli 
JOIN unita_formative ON moduli.unita_formativa_id = unita_formative.id;

--estrarre tutti i corsisti (nome, cognome, data_di_nascita) 
--e il (nome) del modulo a cui sono iscritti
SELECT corsisti.nome, corsisti.cognome, corsisti.data_di_nascita, moduli.nome AS modulo_nome FROM corsisti JOIN iscrizioni ON corsisti.id = iscrizioni.corsista_id JOIN moduli ON moduli.id =  iscrizioni.modulo_id;

/*RIGHT / LEFT JOIN per stampare anche dei dati che non ci sono in altre tabelle, utili per selezione tutti i clienti, anche quelli che non comprano da tanto o che hanno degli abbonamenti non attivi, ma che rimangono sempre nella lista clienti*/
SELECT corsisti.nome, corsisti.cognome, corsisti.data_di_nascita, moduli.nome AS modulo_nome 
FROM corsisti RIGHT JOIN iscrizioni ON corsisti.id /*Tabella di sinistra*/= iscrizioni.corsista_id /*tabella di destra*/
JOIN moduli ON moduli.id =  iscrizioni.modulo_id;

/*Condizione di seleione WHERE, quindi dove dobbiamo selezionare tramite una condizione di ricerca*/
SELECT nome,cognome,localita_residenza FROM corsisti WHERE localita_residenza = 'Roma';

SELECT nome FROM moduli WHERE nome LIKE '%sql%';
/*gli '%' prima e dopo a sql indicano che ci potrebbe essere come non essere del testo prima e dopo della scritta*/


/*Selezionare tutti i campi di quelli che rispettano una condizione*/
SELECT * FROM corsisti WHERE data_di_nascita < '1990-01-01';

/*Selezionare un campo e rinominarlo al momento della stampa*/
SELECT data_di_nascita AS dt_nascita FROM corsisti WHERE data_di_nascita < '1990-01-01';

--corsisti nati tra il 1980 e il 1990
SELECT nome, cognome, data_di_nascita FROM corsisti WHERE data_di_nascita BETWEEN '1980-01-01' AND '1990-12-31';
-- corsisti che sono tra id 1 e 3
SELECT nome, cognome FROM corsisti WHERE id IN (1,2,3);
-- corsisti con id compreso tra 1 e 3
SELECT nome, cognome FROM corsisti WHERE id BETWEEN 1 AND 3;
---corsisti di genere femminile residenti a Milano
SELECT nome, cognome FROM corsisti WHERE genere = 'F' AND localita_residenza = 'Milano';
--corsisti senza email
SELECT nome, cognome FROM corsisti WHERE email IS NULL;
--corsisti con il nome che termine con "a"
SELECT nome, cognome FROM corsisti WHERE nome LIKE '%a';
---corsisti che risiedono a Roma, Milano o Torino
SELECT nome, cognome, localita_residenza FROM corsisti WHERE localita_residenza = 'Roma' OR localita_residenza = 'Milano' 
OR localita_residenza = 'Torino';
---corsisti femmine che abitano a Roma o a Torino (valgono le parentesi rotonde come per gli operatori logici)
SELECT nome, cognome, localita_residenza FROM corsisti WHERE genere = 'F' AND (localita_residenza = 'Roma' 
OR localita_residenza = 'Torino');

--Stampare con l'uso di operatori aritmetici 
SELECT nome, costo_orario * numero_ore AS costo_totale FROM moduli; 

--lezioni da 5 ore :
SELECT nome, FLOOR(numero_ore / 5) AS giorni_totali FROM moduli WHERE id =2;
-- ore dell'ultima lezione: 
SELECT nome, numero_ore % 4 AS resto_divisione FROM moduli WHERE id =2;

-- mysql functions
SELECT CONCAT(nome, ' ', cognome) AS nome_completo, 
UPPER(nome) AS nome_maiuscolo, 
LOWER(cognome) AS cognome_minuscolo FROM corsisti;
--tutto unito diventa una riga così
SELECT UPPER(CONCAT(nome, ' ', cognome)) AS nome_completo FROM corsisti;
SELECT CONCAT_WS(' ', nome, cognome) AS nome_completo FROM corsisti; --lo spazio indica che cosa ci sarà tra le parle nome e cognome

SELECT CONCAT(nome, ' - ', cognome, ' - ', localita_residenza, ' - ', cap_residenza, ' - ', indirizzo_residenza) AS info_corsista FROM corsisti;
SELECT CONCAT_WS(' - ', nome, cognome, localita_residenza, cap_residenza, indirizzo_residenza) AS info_corsista FROM corsisti;
--vedere l'età del corsista, quindi fare una differena di età (in anni) tra la sua data di nascita e la data attuale
SELECT CONCAT_WS(' ', nome, cognome) AS nome_completo, TIMESTAMPDIFF(YEAR, data_di_nascita, CURDATE()) AS eta FROM corsisti;

--selezionare tutti quelli che hanno più di 40 anni
SELECT * FROM corsisti WHERE TIMESTAMPDIFF(YEAR, data_di_nascita, CURDATE()) >= 40;

SELECT nome, CEIL(numero_ore / 3) AS numero_lezione FROM moduli;
SELECT nome, CEIL(numero_ore / 3) AS numero_lezione, numero_ore * 0.2 AS max_ore_di_assenza FROM moduli;

--media ore dei moduli
SELECT AVG(numero_ore) AS media_ore_moduli FROM moduli;







