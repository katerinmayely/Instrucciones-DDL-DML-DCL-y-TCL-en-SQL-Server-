USE Permiso
GO

--PROCEDMIENTO PARA OBTENER USUARIO

CREATE PROCEDURE usp_LoginUsuario(
@Usuario varchar(60),
@Clave varchar(60),
@IdUsuario int output
)
AS
BEGIN
	SET @IdUsuario = 0
	IF exists(
	SELECT * FROM USUARIOS 
	WHERE Usuario COLLATE Latin1_General_CS_AS = @Usuario 
	AND Clave COLLATE Latin1_General_CS_AS = @Clave
	)

	SET @IdUsuario = (
	SELECT Id FROM USUARIOS 
	WHERE Usuario COLLATE Latin1_General_CS_AS = @Usuario 
	AND Clave COLLATE Latin1_General_CS_AS = @Clave
	)
END;
GO

DECLARE @IDUSUARIO_SALIDA INT

EXEC usp_LoginUsuario 'ADMIN', '123', @IDUSUARIO_SALIDA OUTPUT

SELECT @IDUSUARIO_SALIDA

 --MENUS
 SELECT DISTINCT M.*
 FROM PERMISO P
 JOIN ROL R ON R.Id = P.IdRol
 JOIN SUBMENU SM ON SM.Id = P.IdSubMenu
 JOIN MENU M ON M.Id = SM.IdMenu
 JOIN USUARIOS U ON U.IdRol = P.IdRol
 WHERE U.Id = 2;
 GO
 

 --SUB MENUS
 SELECT SM.*,P.Activo
 FROM PERMISO P
 JOIN ROL R ON R.Id = P.IdRol
 JOIN SUBMENU SM ON SM.Id = P.IdSubMenu
 JOIN USUARIOS U ON U.IdRol = P.IdRol
 WHERE U.Id = 2;
 GO


 --PROCEDMIENTO PARA OBTENER DETALLE USUARIO
CREATE PROCEDURE usp_ObtenerPermisos(
@IdUsuario int
)
AS
BEGIN
SELECT
 (

  SELECT vistaMenu.Nombre,vistaMenu.Icono,
  
   (SELECT SM.Nombre,sm.NombreFormulario
	 FROM PERMISO P
	 JOIN ROL R ON R.Id = P.IdRol
	 JOIN SUBMENU SM ON SM.Id = P.IdSubMenu
	 JOIN USUARIOS U ON U.IdRol = P.IdRol
	 where U.Id = US.Id and vistaMenu.Id = sm.IdMenu
	 FOR XML PATH ('SubMenu'),TYPE) AS 'DetalleSubMenu' 
  
   FROM (
	SELECT DISTINCT M.*
	 FROM PERMISO P
	 JOIN ROL R ON R.Id = P.IdRol
	 JOIN SUBMENU SM ON SM.Id = P.IdSubMenu
	 JOIN MENU M ON M.Id = SM.IdMenu
	 JOIN USUARIOS U ON U.IdRol = P.IdRol
	 WHERE U.Id = US.Id and p.Activo = 1
	 ) vistaMenu
	 FOR XML PATH ('Menu'),TYPE) AS 'DetalleMenu' 


from USUARIOS US
WHERE us.Id = @IdUsuario
FOR XML PATH(''), ROOT('PERMISOS') 
END;
GO

EXEC usp_ObtenerPermisos 1;
GO
EXEC usp_ObtenerPermisos 2;
GO 