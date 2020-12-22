using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using MySql.Data.MySqlClient;
using GeAl.util;

namespace GeAl.persitencia.tipoarticulo
{
    class TipoArticuloDAO
    {
        #region Variables de clase

        private static readonly ILog log = LogManager.GetLogger(typeof(TipoArticuloDAO));

        #endregion

        /// <summary>
        /// Se obtiene la lista completa de tipos de articulos
        /// </summary>
        /// <returns></returns>
        internal static List<TipoArticulo> findAll()
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlCommand cmd = conexion.CreateCommand();

            cmd.CommandText = QueryObtenerTiposArticulo(null);
            List<TipoArticulo> resultados = new List<TipoArticulo>(0);
            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    TipoArticulo ta = new TipoArticulo();
                    int i = 0;
                    ta.Id = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                    ta.Nombre = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                    ta.FechaAlta = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    ta.UsuarioAlta = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    ta.FechaModificacion = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    ta.UsuarioModificacion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    ta.Borrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    ta.FechaBorrado = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    ta.UsuarioBorrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                    resultados.Add(ta);
                } // while
            } // using

            DBHelper.cerrarConexion(conexion);

            return resultados;
        } // findAll

        /// <summary>
        /// se obtiene el tipo de articulo por el nombre del mismo
        /// </summary>
        /// <returns></returns>
        internal static TipoArticulo findByName(string nombre)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlCommand cmd = conexion.CreateCommand();

            cmd.CommandText = QueryObtenerTiposArticulo(nombre);
            cmd.Parameters.AddWithValue(
                DBHelper.GetParameterName("nombre"),
                nombre.Trim()
            );

            TipoArticulo ta = new TipoArticulo();
            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                if (reader.HasRows)
                {
                    reader.Read();

                    int i = 0;
                    ta.Id = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                    ta.Nombre = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                    ta.FechaAlta = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    ta.UsuarioAlta = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    ta.FechaModificacion = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    ta.UsuarioModificacion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    ta.Borrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    ta.FechaBorrado = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    ta.UsuarioBorrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                } // while
            } // using

            DBHelper.cerrarConexion(conexion);

            return ta;
        } // findByName

        private static string QueryObtenerTiposArticulo(string nombre)
        {
            StringBuilder sb = new StringBuilder(0);
            sb.Append("SELECT id, nombre, fecha_alta, user_alta, fecha_modificacion, user_modificacion, borrado, fecha_borrado, user_borrado ");
            sb.Append("FROM ga.tipo_articulo ");
            sb.Append("WHERE borrado = 'N' ");

            if (0 < nombre.Trim().Length)
            {
                sb.Append("AND nombre = ");
                sb.Append(DBHelper.GetParameterSyntax("nombre"));
            } // then

            return sb.ToString();
        } // QueryObtenerTiposArticulo
    } // class
} // namespace
