pipeline {
    agent any
    
    environment {

        TELEGRAM_TOKEN = '8848797656:AAGeXg46KAY9BHljENMo09jphdOFtlt-Llk'
        TELEGRAM_CHAT_ID = '8924945926'
        REPO_URL = 'https://github.com/Paolo-Cd/UPAO-SCRIPTS.git'
    }
    stages  {
        stage('1.Conectar') {
            steps {
                echo ' Iniciando conexión con el entorno local.... '
        }
    }
        stage('2.Extraer') {
            steps {
                echo 'ejecutando datos extraidos del GitHub ......'
               git branch: 'main', url: "${REPO_URL}"
            }
        }
        
    stage('3. Verificación de conexión') {
            steps {
                echo 'Verificando la conectividad con SQL Server (OMEGA\\SQLEXPRESS)...'
                bat 'sqlcmd -S "OMEGA\\SQLEXPRESS" -d "GESTION_DE_REQUERIMIENTOS" -E -C -Q "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = \'BASE TABLE\';"'
            }
    }
    stage('4. Actualizacion de datos ') {
        steps {
            echo 'Ejecuatnto scrip extraido del repositorio.'
          bat 'sqlcmd -S "OMEGA\\SQLEXPRESS" -d "GESTION_DE_REQUERIMIENTOS" -E -C -i "%WORKSPACE%\\actualizacion_requerimientos.sql"'
    
        }
            
        }
    
    stage('5. Notificaiones o altertas ') {
        steps {
            echo 'Pipeline se ejecuto correctamento! Notificacion a sido enviada'
            bat """
            curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" -d "chat_id=${TELEGRAM_CHAT_ID}" -d "text=EXITO: PROCESO FINALIZADO EXITOSAMENTE."
        """
        }
    }
    
    }

     post { 
        success {
            echo 'El flujo de DataOps finalizó con éxito.'
             }
    failure {
        echo ' Se detecto que hubo un error en la ejecucion Revisar los registro con urgencia .'
        bat """
            curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" -d "chat_id=${TELEGRAM_CHAT_ID}" -d "text=ALERTA: Ocurrió un error en la ejecución del pipeline de Jenkins."
        """
        }
    }
  }
