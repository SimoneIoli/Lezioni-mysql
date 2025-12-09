<?php
//php -S localhost:8000
//http://localhost:8000/lezioni/lezione3/connect_php_e_insert.php

// Configurazione del Database
$db_host = 'localhost';
$db_name = 'corso_gestione_aula'; // Ho usato il nome del DB dell'esercizio precedente.
$db_user = 'root';
$db_pass = 'root'; 

// 1. CONNESIONE AL DATABASE (PDO)
try {
    $pdo = new PDO("mysql:host=$db_host;dbname=$db_name;charset=utf8", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    //echo "Connessione al database avvenuta con successo!";
} catch (PDOException $e) {
    die("Errore di connessione al database: " . $e->getMessage());
}

// 3. ESECUZIONE DELLA QUERY SELECT RICHIESTA
$sql_select = "
    SELECT 
        nome, 
        CEIL(numero_ore / 3) AS numero_lezioni,
        FLOOR((numero_ore * 20) / 100) AS max_ore_assenza
    FROM 
        moduli;
";

try {
    $stmt_select = $pdo->query($sql_select);
    $risultati = $stmt_select->fetchAll(PDO::FETCH_ASSOC);
    
    // 4. STAMPA DEI RISULTATI IN UNA TABELLA HTML
    if ($risultati) {
        echo "<h2>Risultati Moduli e Lezioni</h2>";
        echo "<table border='1' cellpadding='10' cellspacing='0'>";
        echo "<thead><tr><th>Modulo</th><th>N. Lezioni (3h/cad)</th><th>Max Ore Assenza (20%)</th></tr></thead>";
        echo "<tbody>";

        // Loop per stampare ogni riga
        foreach ($risultati as $riga) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($riga['nome']) . "</td>";
            echo "<td>" . htmlspecialchars($riga['numero_lezioni']) . "</td>";
            echo "<td>" . htmlspecialchars($riga['max_ore_assenza']) . "</td>";
            echo "</tr>";
        }

        echo "</tbody>";
        echo "</table>";
    } else {
        echo "<p>Nessun modulo trovato nel database.</p>";
    }

} catch (PDOException $e) {
    echo "Errore nell'esecuzione della query SELECT: " . $e->getMessage();
}

// Chiudi la connessione
$pdo = null;

?>