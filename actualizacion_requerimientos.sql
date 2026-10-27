-- ============================================================================
-- SCRIPT DE ACTUALIZACIÓN AUTOMATIZADA DE REQUERIMIENTOS Y POSTULANTES
-- Base de datos: GESTION_DE_REQUERIMIENTOS
-- Servidor: OMEGA\SQLEXPRESS
-- ============================================================================
 USE GESTION_DE_REQUERIMIENTOS ;
 GO

SET NOCOUNT ON;

BEGIN TRY

    BEGIN TRANSACTION;

        PRINT '--> Iniciando actualización de registros de requerimientos...';

        -- Actualizamos usando el nombre correcto de la columna 
     UPDATE dbo.REQUERIMIENTOS

         SET DECISION_DE_RRHH = 'APROBADO'

        WHERE FECHA_DE_SOLICITUD < GETDATE() AND (DECISION_DE_RRHH IS NULL OR DECISION_DE_RRHH = 'PENDIENTE');

        PRINT '--> Actualización de requerimientos completada.';

    -- Confirmación de cambios
    COMMIT TRANSACTION;

    PRINT '--> [EXITO] Proceso de actualización completado exitosamente.';

END TRY
BEGIN CATCH
    -- Si ocurre un error, se deshacen los cambios
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    PRINT '--> [ERROR] Se produjo un fallo durante el proceso de actualización:';
    PRINT ERROR_MESSAGE();

    THROW;
END CATCH;


-- ==========================================================
-- Procedimiento para contar solicitudes mensuales por puesto
-- ==========================================================
GO

IF OBJECT_ID('sp_ContarSolicitudesPorPuestoMes', 'P') IS NOT NULL
    DROP PROCEDURE sp_ContarSolicitudesPorPuestoMes;
GO

CREATE PROCEDURE sp_ContarSolicitudesPorPuestoMes
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        DATENAME(MONTH, FECHA_DE_SOLICITUD) AS Mes,
        YEAR(FECHA_DE_SOLICITUD) AS Anio,
        PUESTO AS Puesto, -- (Si tu columna de puesto se llama diferente, ajústala aquí)
        COUNT(1) AS TotalSolicitudes
    FROM 
        dbo.REQUERIMIENTOS
    GROUP BY 
        YEAR(FECHA_DE_SOLICITUD),
        DATENAME(MONTH, FECHA_DE_SOLICITUD),
        PUESTO
    ORDER BY 
        Anio DESC, 
        Mes DESC, 
        TotalSolicitudes DESC;
END;
GO

PRINT '--> [EXITO] Store Procedure sp_ContarSolicitudesPorPuestoMes creado correctamente.';
GO