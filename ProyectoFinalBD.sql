CREATE DATABASE ControlAccesos
USE ControlAccesos

--CREACION DE TABLAS--
--PERSONAS--
CREATE TABLE Personas (
	PersonaId       INT PRIMARY KEY IDENTITY(1,1),
    TipoPersona     NVARCHAR(20) NOT NULL,   -- Visitante / Proveedor / Aplicante
    NombreCompleto  NVARCHAR(120) NOT NULL,
    Empresa         NVARCHAR(120) NULL,
    Telefono        NVARCHAR(30) NULL,
    Identificacion  NVARCHAR(60) NULL,
    Notas           NVARCHAR(250) NULL
);
INSERT INTO Personas (TipoPersona, NombreCompleto, Empresa, Telefono, Identificacion, Notas)
VALUES 
('Visitante', 'Carlos Ramirez', 'Consultores IT', '6641234567', 'INE12345', 'Reunion con area de sistemas'),
('Proveedor', 'Laura Martinez', 'Servicios Industriales del Norte', '6649876543', 'INE98765', 'Entrega de refacciones'),
('Aplicante', 'Daniel Torres', NULL, '6644567890', 'INE45678', 'Entrevista para puesto de desarrollador'),
('Visitante', 'Sofia Herrera', 'Auditoria Global', '6641122334', 'PAS123456', 'Auditoria interna'),
('Proveedor', 'Miguel Lopez', 'Transportes Baja Logistics', '6649988776', 'LIC87654', 'Entrega de material');

CREATE TABLE Accesos (
    AccesoID            INT PRIMARY KEY IDENTITY(1,1),
    PersonaID           INT NOT NULL,
    TipoAcceso          NVARCHAR(20) NOT NULL, -- Peatonal / Vehicular
    MotivoVisita        NVARCHAR(200) NOT NULL,
    Anfitrion           NVARCHAR(120) NULL,
    AreaDestino         NVARCHAR(100) NULL,
    FechaHoraEntrada    DATETIME NOT NULL,
    FechaHoraSalida     DATETIME NULL,
    Estatus             NVARCHAR(20) NOT NULL, -- EnSitio / Salio / Denegado
    CapturadoPor        NVARCHAR(80) NULL,

    CONSTRAINT FK_Accesos_Personas
    FOREIGN KEY (PersonaID) REFERENCES Personas(PersonaID)
);
INSERT INTO Accesos 
(PersonaID, TipoAcceso, MotivoVisita, Anfitrion, AreaDestino, FechaHoraEntrada, FechaHoraSalida, Estatus, CapturadoPor)
VALUES
(1, 'Peatonal', 'Reunion de proyecto', 'Juan Perez', 'Sistemas', '2026-03-06 09:15:00', '2026-03-06 10:30:00', 'Salio', 'Guardia1'),
(2, 'Vehicular', 'Entrega de refacciones', 'Luis Gomez', 'Mantenimiento', '2026-03-06 08:45:00', NULL, 'EnSitio', 'Guardia1'),
(3, 'Peatonal', 'Entrevista laboral', 'Maria Lopez', 'Recursos Humanos', '2026-03-06 11:00:00', NULL, 'EnSitio', 'Guardia2'),
(4, 'Peatonal', 'Auditoria de procesos', 'Ricardo Silva', 'Administracion', '2026-03-06 10:00:00', '2026-03-06 12:15:00', 'Salio', 'Guardia1'),
(5, 'Vehicular', 'Entrega de material', 'Pedro Sanchez', 'Almacen', '2026-03-06 07:30:00', NULL, 'EnSitio', 'Guardia2');

CREATE TABLE Vehiculos (
    VehiculoID      INT PRIMARY KEY IDENTITY(1,1),
    AccesoID        INT NOT NULL,
    Placas          NVARCHAR(15) NOT NULL,
    Marca           NVARCHAR(40) NULL,
    Modelo          NVARCHAR(40) NULL,
    Color           NVARCHAR(30) NULL,
    TipoVehiculo    NVARCHAR(30) NULL,
    NoEconomico     NVARCHAR(30) NULL,

    CONSTRAINT FK_Vehiculos_Accesos
    FOREIGN KEY (AccesoID) REFERENCES Accesos(AccesoID),

    CONSTRAINT UQ_Vehiculos_AccesoID UNIQUE (AccesoID)
);
INSERT INTO Vehiculos
(AccesoID, Placas, Marca, Modelo, Color, TipoVehiculo, NoEconomico)
VALUES
(2, 'BC1234A', 'Ford', 'Transit', 'Blanco', 'Van', 'ECO001'),
(5, 'BC5678B', 'Chevrolet', 'Silverado', 'Rojo', 'Pickup', 'ECO002');

CREATE TABLE Evidencias (
    EvidenciaID         INT PRIMARY KEY IDENTITY(1,1),
    AccesoID            INT NOT NULL,
    TipoEvidencia       NVARCHAR(30) NOT NULL, -- FotoRostro / FotoID / Otro
    RutaArchivo         NVARCHAR(255) NOT NULL,
    FechaHoraCaptura    DATETIME NOT NULL,

    CONSTRAINT FK_Evidencias_Accesos
    FOREIGN KEY (AccesoID) REFERENCES Accesos(AccesoID)
);
INSERT INTO Evidencias
(AccesoID, TipoEvidencia, RutaArchivo, FechaHoraCaptura)
VALUES
(1, 'FotoRostro', 'C:\ControlAccesos\Fotos\visitante1.jpg', '2026-03-06 09:16:00'),
(2, 'FotoRostro', 'C:\ControlAccesos\Fotos\proveedor1.jpg', '2026-03-06 08:46:00'),
(3, 'FotoID', 'C:\ControlAccesos\Fotos\aplicante1.jpg', '2026-03-06 11:01:00'),
(4, 'FotoRostro', 'C:\ControlAccesos\Fotos\visitante2.jpg', '2026-03-06 10:01:00');