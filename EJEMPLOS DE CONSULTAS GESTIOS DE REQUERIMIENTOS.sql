USE GESTION_DE_REQUERIMIENTOS
GO

--Reporte Comercial Básico 
--Recursos Humanos necesita un listado con los nombres completos, DNI y teléfono de todos los solicitantes
--que ingresaron a trabajar específicamente en el puesto de 'Asesor Comercial'

SELECT S.* FROM SOLICITANTE S
SELECT A.* FROM ASIGNACION A
SELECT R.* FROM REQUERIMIENTOS R
SELECT P.* FROM PUESTOS_DISPONIBLES P

SELECT S.NOMBRES_Y_APELLIDOS AS SOLICITANTE, S.DNI AS 'DOCUMENTO DE IDENTIDAD' , S.NUMERO_DE_TELEFONO AS TELEFÓNO , P.NOMBRE_DEL_PUESTO AS 'PUESTO ENCARGADO' FROM SOLICITANTE S

JOIN ASIGNACION A ON S.DNI = A.DNI
JOIN REQUERIMIENTOS R  ON A.ID_REQUERIMIENTO = R.ID_REQUERIMIENTO
JOIN PUESTOS_DISPONIBLES P ON R.ID_PUESTO = P.ID_PUESTO 
WHERE P.NOMBRE_DEL_PUESTO = 'Asesor Comercial' ;

GO
--*******************************************************************

-- Historial de Contrataciones por Fechas 
-- La gerencia quiere auditar los contratos antiguos. Muestra el código de asignación, nombre del colaborador, 
-- el nombre del puesto y la fecha de ingreso, pero únicamente para aquellos cuyo ingreso haya sido entre el 1 de enero de 2023 y el 31 de diciembre de 2024.

SET DATEFORMAT DMY
	GO

SELECT A.ID_ASIGNACION AS 'CODIGO DE ASIGNACIÓN' , S.NOMBRES_Y_APELLIDOS AS  'NOMBRE DEL COLABORADOR ' ,P.NOMBRE_DEL_PUESTO AS 'PUESTO A CARGO ' , A.FECHA_DE_INGRESO FROM ASIGNACION A

JOIN SOLICITANTE S ON S.DNI = A.DNI
JOIN REQUERIMIENTOS R ON A.ID_REQUERIMIENTO = R.ID_REQUERIMIENTO
JOIN PUESTOS_DISPONIBLES P ON R.ID_PUESTO = P.ID_PUESTO
WHERE A.FECHA_DE_INGRESO BETWEEN '2023-01-01' AND '2024-12-31' 

GO