<?php
// Configuración de la base de datos
define('DB_HOST', 'bhngdszq0kgml0swdtdv-mysql.services.clever-cloud.com');
define('DB_USER', 'uuxl3ridzazjvw8o');
define('DB_PASS', 'tNFAW1Nt42mSYH74GpCG');
define('DB_NAME', 'bhngdszq0kgml0swdtdv');

// Crear la conexión con MySQLi
$conexion = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Verificar la conexión
if ($conexion->connect_error) {
    die("Error de Conexión: " . $conexion->connect_error);
}

// Establecer el charset a UTF-8
$conexion->set_charset("utf8mb4");