CREATE DATABASE Permiso
GO

USE Permiso;
GO

CREATE TABLE MENU(
Id INT PRIMARY KEY,
Nombre VARCHAR(50),
Icono VARCHAR(50)
);
GO

CREATE TABLE SUBMENU(
Id INT PRIMARY KEY,
Nombre VARCHAR(50),
NombreFormulario varchar(50),
IdMenu INT REFERENCES MENU(Id)
);
GO

CREATE TABLE ROL(
Id INT PRIMARY KEY,
Nombre VARCHAR(50)
);
GO

CREATE TABLE PERMISO(
IdPermiso INT PRIMARY KEY IDENTITY,
Activo BIT,
IdSubMenu INT REFERENCES SUBMENU(Id),
IdRol INT REFERENCES ROL(id),
);
GO

CREATE TABLE USUARIOS(
Id INT PRIMARY KEY IDENTITY,
Nombres VARCHAR(50),
Usuario VARCHAR(50),
Clave VARCHAR(50),
IdRol INT REFERENCES ROL(Id)
);
GO

-- INSERTS 
 SELECT * FROM MENU;
 

 INSERT INTO MENU(Id,Nombre,Icono) VALUES 
 (1,'Usuarios','\Iconos\Usuario.png'),
 (2,'Ventas','\Iconos\Ventas.png'),
 (3,'Reportes','\Iconos\Reportes.png');
 GO

 SELECT * FROM SUBMENU;

 --MENU USUARIOS
 INSERT INTO SUBMENU(Id,IdMenu,Nombre,NombreFormulario) VALUES
 (1,1,'Crear Usuario','frmCrearUsuario'),
 (2,1,'Editar Usuario','frmEditarUsuario'),
 (3,1,'Eliminar Usuario','frmEliminarUsuario');
 GO

  --MENU VENTAS
 INSERT INTO SUBMENU(Id,IdMenu,Nombre,NombreFormulario) VALUES
 (4,2,'Crear Venta','frmCrearVenta'),
 (5,2,'Editar Venta','frmEditarVenta');
 GO

  --MENU REPORTES
 INSERT INTO SUBMENU(Id,IdMenu,Nombre,NombreFormulario) VALUES
 (6,3,'Reporte Ventas','frmReporteVenta'),
 (7,3,'Reporte Cliente','frmReporteCliente');
 GO

 SELECT * FROM MENU m
 INNER JOIN SUBMENU sb on m.Id = sb.idmenu;
 GO

  SELECT * FROM ROL;
 GO

 --ROLES
 INSERT INTO ROL(Id,Nombre) VALUES 
 (1,'ADMINISTRADOR'),
 (2,'EMPLEADO');
 GO


 SELECT * FROM PERMISO;
 GO

 --PERMISOS ADMINISTRADOR
 INSERT INTO PERMISO(IdRol,IdSubMenu,Activo) VALUES
 (1,1,1),
 (1,2,1),
 (1,3,1),
 (1,4,1),
 (1,5,1),
 (1,6,1),
 (1,7,1);
 GO

 --PERMISOS EMPLEADO
  INSERT INTO PERMISO(IdRol,IdSubMenu,Activo) VALUES
 (2,1,0),
 (2,2,0),
 (2,3,0),
 (2,4,1),
 (2,5,1),
 (2,6,0),
 (2,7,0);
 GO

 SELECT * FROM USUARIOS;

 INSERT INTO USUARIOS(Nombres,Usuario,Clave,IdRol) VALUES
 ('PERSONA 01','ADMIN','123',1),
 ('PERSONA 02','EMP','456',2);
 GO