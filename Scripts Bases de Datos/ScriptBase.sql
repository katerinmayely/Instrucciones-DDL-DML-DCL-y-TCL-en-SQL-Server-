CREATE DATABASE Colegio;
GO

USE Colegio;
GO

CREATE TABLE Estudiantes(
Id INTEGER PRIMARY KEY IDENTITY(1,1),
PrimerNombre VARCHAR(50) NOT NULL,
SegundoNombre VARCHAR(50),
PrimerApellido VARCHAR(50) NOT NULL,
SegundoApellido VARCHAR(50),
Telefono VARCHAR(8),
FechaNacimiento DATE NOT NULL --Formato (YYYY-MM-DD)
);
GO

CREATE TABLE Cursos(
Id INTEGER PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(100) NOT NULL,
UnidadValorativa INTEGER NOT NULL
);
GO

CREATE TABLE Roles(
Id INTEGER PRIMARY KEY IDENTITY(1,1),
Nombre VARCHAR(50) NOT NULL
);
GO

CREATE TABLE EncargadoMatricula(
Id INTEGER PRIMARY KEY IDENTITY(1,1),
DNI VARCHAR(13) NOT NULL,
PrimerNombre VARCHAR(50) NOT NULL,
SegundoNombre VARCHAR(50),
PrimerApellido VARCHAR(50) NOT NULL,
SegundoApellido VARCHAR(50),
Telefono VARCHAR(8),
FechaNacimiento DATE NOT NULL, --Formato (YYYY-MM-DD)
Correo VARCHAR(100) NOT NULL,
Contrasenia VARCHAR(100) NOT NULL,
Roles_id INTEGER REFERENCES Roles(Id)
);
GO

CREATE TABLE Docentes(
Id INTEGER PRIMARY KEY IDENTITY(1,1),
DNI VARCHAR(13) NOT NULL,
PrimerNombre VARCHAR(50) NOT NULL,
SegundoNombre VARCHAR(50),
PrimerApellido VARCHAR(50) NOT NULL,
SegundoApellido VARCHAR(50),
Telefono VARCHAR(8),
FechaNacimiento DATE NOT NULL, --Formato (YYYY-MM-DD)
);
GO

CREATE TABLE Matriculas(
Id INTEGER PRIMARY KEY IDENTITY(1,1),
Fecha DATE DEFAULT GETDATE(),
Seccion VARCHAR(4) NOT NULL,
Estudiante_id INTEGER REFERENCES Estudiantes(id),
Docente_id INTEGER REFERENCES Docentes(id),
Curso_id INTEGER REFERENCES Cursos(id),
Encargado_id INTEGER REFERENCES EncargadoMatricula(id),
);
GO

-- ISERTS DE LAS TABLAS

INSERT INTO Roles(Nombre) VALUES 
('Coordinador'),
('Docente'),
('Jefe');
GO

INSERT INTO EncargadoMatricula(DNI, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Telefono,
 FechaNacimiento, Correo, Contrasenia, Roles_id) VALUES 
('080119587856', 'Juan', 'Carlos', 'Perez', 'Torre', '99889988', '1958-10-23', 'juan@gmail.com', 'juan123', 1),
('080120027856', 'Samuel', 'Alejandro', 'Romero', 'Dominguez', '77668899', '2002-10-23', 'samuel@gmail.com', 'samuel123', 2),
('080119917856', 'Sofia', 'Maria', 'Valladares', 'Medina', '33445566', '1991-10-23', 'sofia@gmail.com', 'juan123', 3);
GO

INSERT INTO Docentes(DNI, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Telefono,
 FechaNacimiento) VALUES
('180420025678', 'Mario', 'Alex', 'Rodriguez', 'Santos', '11223344', '2002-05-23'),
('180419755678', 'Carla', 'Alejandra', 'Ramos', 'Castillo', '88779966', '1975-05-23');
GO

INSERT INTO Estudiantes(PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Telefono,
 FechaNacimiento) VALUES 
('Ramón', 'Alberto', 'Romero', 'Galeano', '95573158', '2002-07-27'),
('Jos', 'Gilberto', 'Urbina', 'Ramirez', '99667788', '2000-05-06');
GO

INSERT Cursos(Nombre, UnidadValorativa) VALUES
('Base de Datos I', 5),
('Programacion II', 5),
('Finanzas', 4);
GO

INSERT INTO Matriculas(Seccion, Estudiante_id, Docente_id, Curso_id , Encargado_id) VALUES
('1500', 1, 1, 1, 1),
('1601', 1, 2, 2, 1),
('0801', 2, 1, 1, 2);
GO

SELECT * FROM Matriculas;
GO


