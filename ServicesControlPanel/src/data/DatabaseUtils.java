package data;

import java.sql.Connection;
import java.sql.DriverManager;

import general.Log;

/**
 * Clase genérica que controla las conexiones a las base de datos de los ERPs
 * Advertencia: Para que funcione, hay que copiar la librería sqljdbc_auth.dll
 * en la carpeta System32 del ordenador cliente
 */
public class DatabaseUtils {

	// Databases
	public static int FENIX_DATABASE = 0;
	public static int NAUTILUS_DATABASE = 1;

	// Connections
	private static Connection fenixConnection = null;
	private static Connection nautilusConnection = null;

	/**
	 * Método que devuelve una conexión de Fénix o Nautilus, según el parámetro
	 * que se le pase
	 * 
	 * @param database
	 *            Fénix = 0, Nautilus=1
	 */
	public static Connection getConnection(int database) {

		Connection conn = null;

		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

			switch (database) {
			case 0:
				if (fenixConnection == null || fenixConnection.isClosed()) {
					fenixConnection = DriverManager.getConnection(Config.DATABASE_CONNECTION_FENIX);
					Log.message("Base de datos [" + fenixConnection.getCatalog() + "]: Conectada", Log.INFO_MESSAGE);
				}
				conn = fenixConnection;
				break;
			case 1:
				if (nautilusConnection == null || nautilusConnection.isClosed()) {
					nautilusConnection = DriverManager.getConnection(Config.DATABASE_CONNECTION_NAUTILUS);
					Log.message("Base de datos [" + nautilusConnection.getCatalog() + "]: Conectada", Log.INFO_MESSAGE);
				}
				conn = nautilusConnection;
				break;
			default:
				throw new Exception("Base de datos no encontrada");
			}

			return conn;

		} catch (Exception ex) {
			Log.message("Base de datos: Error en la conexión (" + ex.getMessage() + ")", Log.ERROR_MESSAGE);
			return null;
		}

	}

	public static void closeConnection(int database) {
		String databaseName = "";
		try {
			switch (database) {
			case 0:
				if (!fenixConnection.isClosed()) {
					databaseName = fenixConnection.getCatalog();
					fenixConnection.close();
					Log.message("Base de datos [" + databaseName + "]: Desconectada", Log.INFO_MESSAGE);
				}
				break;
			case 1:
				if (!nautilusConnection.isClosed()) {
					databaseName = nautilusConnection.getCatalog();
					nautilusConnection.close();
					Log.message("Base de datos [" + databaseName + "]: Desconectada", Log.INFO_MESSAGE);
				}
				break;
			default:
				throw new Exception("Base de datos no encontrada");
			}
		} catch (Exception ex) {
			Log.message("No se ha podido cerrar la conexión con la base de datos: " + ex.getMessage(),
					Log.ERROR_MESSAGE);
		}
	}

}
