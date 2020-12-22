using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using log4net;
using GeAl.util;

namespace GeAl.util
{
    class DBHelper
    {
        #region Constantes

        private const string CTE_ConnectionString = "server={0};uid={1};pwd={2};database={3};";

        private const string CTE_SERVER = "SERVER";
        private const string CTE_USER = "USER";
        private const string CTE_PASS = "PASS";
        private const string CTE_INSTANCE = "INSTANCE";

        private const string CTE_PARAMETER_PREFIX = "@";

        #endregion

        #region Variables de clase

        private static readonly ILog log = LogManager.GetLogger(typeof(DBHelper));

        #endregion

        internal static MySqlConnection abrirConexion()
        {
            MySqlConnection conn = null;

            string servidor = FileSystemHelper.GetValueFromConfig(CTE_SERVER);
            string usuario = FileSystemHelper.GetValueFromConfig(CTE_USER);
            string clave = SecurityHelper.DecryptString(FileSystemHelper.GetValueFromConfig(CTE_PASS));
            string bd = FileSystemHelper.GetValueFromConfig(CTE_INSTANCE);

            try
            {
                conn = new MySqlConnection(System.String.Format(CTE_ConnectionString, servidor, usuario, clave, bd));
                conn.Open();

                return conn;
            } // try
            catch (MySqlException ex)
            {
                log.Error(ex.Message);

                return null;
            } // catch
        } // abrirConexion

        internal static bool cerrarConexion(MySqlConnection conexion)
        {
            try
            {
                conexion.Close();

                return true;
            } // try
            catch (Exception ex)
            {
                log.Error(ex.Message);

                return false;
            } // catch
        } // abrirConexion

        /// <summary>
        /// Permite comprobar la conexion con la bbdd
        /// </summary>
        /// <returns></returns>
        public static string testConexion()
        {
            string resultado = "NK";
            MySqlConnection conexion = abrirConexion();
            if (null != conexion)
            {
                resultado = "OK";

                cerrarConexion(conexion);
            } // then

            return resultado;
        } // testConexion

        internal static T GetTNullable<T>(object obj)
        {
            if (System.DBNull.Value == obj)
            {
                return default(T);
            } // then
            else
            {
                return (T)obj;
            } // else
        } // GetTNullable

        internal static String GetParameterName(string parameterName)
        {
            return CTE_PARAMETER_PREFIX + parameterName;
        } // GetParameterName

        internal static String GetParameterSyntax(string parameterName)
        {
            return CTE_PARAMETER_PREFIX + parameterName;
        } // GetParameterName
    } // class
} // namespace
