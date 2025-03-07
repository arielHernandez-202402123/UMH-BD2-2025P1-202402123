/*ARIEL HERNANDEZ 202402123*/

CREATE TABLE IF NOT EXISTS Cuentas (  
    Cuenta INT PRIMARY KEY,  
    TotalCreditos DECIMAL(10, 2) DEFAULT 0.00,  
    TotalDebitos DECIMAL(10, 2) DEFAULT 0.00,  
    Saldo DECIMAL(10, 2) DEFAULT 0.00  
);  

CREATE TABLE IF NOT EXISTS transacciones_usuario (  
    TransaccionID INT AUTO_INCREMENT PRIMARY KEY,  
    Cuenta INT,  
    Fecha DATE,  
    Credito DECIMAL(10, 2) DEFAULT 0.00,  
    Debito DECIMAL(10, 2) DEFAULT 0.00,  
    FOREIGN KEY (Cuenta) REFERENCES Cuentas(Cuenta)  
);  

/* DAtos iniciales de las tablas*/   
INSERT INTO Cuentas (Cuenta, TotalCreditos, TotalDebitos, Saldo) VALUES  
(20010001, 800.00, 0.00, 800.00),  
(20010002, 560.00, 0.00, 560.00),  
(20010003, 1254.00, 0.00, 1254.00),  
(20010004, 15000.00, 0.00, 15000.00),  
(20010005, 256.00, 0.00, 256.00);  

INSERT INTO transacciones_usuario (Cuenta, Fecha, Credito, Debito) VALUES  
(20010001, '2024-12-12', 800.00, 0.00),  
(20010002, '2025-01-05', 560.00, 0.00),  
(20010003, '2024-10-30', 1254.00, 0.00),  
(20010004, '2025-01-14', 15000.00, 0.00),  
(20010005, '2024-11-23', 256.00, 0.00);

/* Validacion de creacion de tablas*/
SELECT * FROM Cuentas;

SELECT * FROM transacciones_usuario;
  
/* Procedimientos*/
DROP PROCEDURE IF EXISTS RegistrarTransaccion;  

DELIMITER //  

CREATE PROCEDURE RegistrarTransaccion (  
    IN p_Cuenta INT,  
    IN p_Fecha DATE,  
    IN p_Monto DECIMAL(10, 2),  
    IN p_Tipo CHAR(1) /* Utilizar letra "C" para crédito, "D" para débito  */
)  
BEGIN  
      
    DECLARE v_Credito DECIMAL(10, 2) DEFAULT 0.00;  
    DECLARE v_Debito DECIMAL(10, 2) DEFAULT 0.00;  
    DECLARE v_SaldoActual DECIMAL(10, 2) DEFAULT 0.00;  

    /* Validación del tipo de transacción */ 
    IF p_Tipo NOT IN ('C', 'D') THEN  
        SELECT 'Tipo de transacción inválido. Use "C" para crédito o "D" para débito.' AS Mensaje;  
    ELSE  
        
        IF p_Tipo = 'C' THEN  
            SET v_Credito = p_Monto;  
        ELSE  
            SET v_Debito = p_Monto;  
        END IF;  

         
        INSERT INTO transacciones_usuario (Cuenta, Fecha, Credito, Debito)  
        VALUES (p_Cuenta, p_Fecha, v_Credito, v_Debito);  

          
        SELECT Saldo INTO v_SaldoActual FROM Cuentas WHERE Cuenta = p_Cuenta;  /* Obtener el saldo actual de la cuenta */ 

        /* Actualizar los totales en la tabla Cuentas */ 
        IF p_Tipo = 'C' THEN  
            UPDATE Cuentas  
            SET TotalCreditos = TotalCreditos + v_Credito,  
                Saldo = Saldo + v_Credito  
            WHERE Cuenta = p_Cuenta;  
        ELSE  
            UPDATE Cuentas  
            SET TotalDebitos = TotalDebitos + v_Debito,  
                Saldo = Saldo - v_Debito  
            WHERE Cuenta = p_Cuenta;  
        END IF;  

        SELECT Saldo FROM Cuentas WHERE Cuenta = p_Cuenta;  /* Ver el nuevo saldo de la cuenta */
    END IF;  
END //  

DELIMITER ;  

/*Transacciones Realizadas*/
  
CALL RegistrarTransaccion(20010001, '2025-03-08', 100.00, 'C');  
 
CALL RegistrarTransaccion(20010002, '2025-03-08', 50.00, 'D');  

CALL RegistrarTransaccion(20010003, '2025-03-09', 25.50, 'C');  

CALL RegistrarTransaccion(20010004, '2025-03-10', 120.75, 'D');  

CALL RegistrarTransaccion(20010005, '2025-03-07', 100, 'D');

CALL RegistrarTransaccion(20010005, '2025-03-07', 300.50, 'C');

/*Validación de datos en tablas*/
SELECT * FROM transacciones_usuario;

SELECT * FROM Cuentas;
