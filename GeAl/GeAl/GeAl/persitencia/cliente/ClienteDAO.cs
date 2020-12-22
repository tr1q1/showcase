using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using MySql.Data.MySqlClient;
using GeAl.util;

namespace GeAl.persitencia.cliente
{
    class ClienteDAO
    {
        #region Variables de clase

        private static readonly ILog log = LogManager.GetLogger(typeof(ClienteDAO));

        #endregion

        internal static Cliente findByExternalId(string codProveedor)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlCommand cmd = conexion.CreateCommand();

            cmd.CommandText = StatementObtenerClientes(codProveedor);
            cmd.Parameters.AddWithValue(
                DBHelper.GetParameterName("codigo_proveedor"),
                codProveedor.Trim()
            );

            Cliente resultado = new Cliente();
            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                if (reader.HasRows)
                {
                    reader.Read();

                    int i = 0;
                    resultado.Id = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                    resultado.Nombre = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.Direccion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.Cp = DBHelper.GetTNullable<int>(reader.GetValue(i++));
                    resultado.Poblacion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.Provincia = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.Pais = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.Telefono = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.CodProveedor = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                    resultado.FechaAlta = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    resultado.UsuarioAlta = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.FechaModificacion = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    resultado.UsuarioModificacion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.Borrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    resultado.FechaBorrado = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                    resultado.UsuarioBorrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                } // then
            } // using

            DBHelper.cerrarConexion(conexion);

            return resultado;
        } // findByExternalId

        private static string StatementObtenerClientes(string codProveedor)
        {
            StringBuilder sb = new StringBuilder(0);
            sb.Append("SELECT id, nombre, direccion, cp, poblacion, provincia, pais, telefono, codigo_proveedor, fecha_alta, user_alta, fecha_modificacion, user_modificacion, borrado, fecha_borrado, user_borrado ");
            sb.Append("FROM ga.cliente ");
            sb.Append("WHERE borrado = 'N' ");

            if (0 < codProveedor.Trim().Length)
            {
                sb.Append("AND codigo_proveedor = ");
                sb.Append(DBHelper.GetParameterSyntax("codigo_proveedor"));
            } // then

            return sb.ToString();
        } // StatementObtenerClientes

        /// <summary>
        /// Se inserta un cliente en bbdd
        /// </summary>
        /// <param name="cliente"></param>
        internal static void insert(Cliente cliente)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlTransaction transaccion = conexion.BeginTransaction();

            try
            {
                MySqlCommand cmd = conexion.CreateCommand();
                cmd.CommandText = StatementInsertarCliente();
                cmd.Transaction = transaccion;

                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("nombre"), cliente.Nombre.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("direccion"), cliente.Direccion.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("cp"), cliente.Cp);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("poblacion"), cliente.Poblacion.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("provincia"), cliente.Provincia.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("pais"), cliente.Pais.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("telefono"), cliente.Telefono.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("codigo_proveedor"), cliente.CodProveedor.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_alta"), cliente.UsuarioAlta.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_modificacion"), cliente.UsuarioModificacion.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_borrado"), cliente.UsuarioBorrado.Trim());

                cmd.ExecuteNonQuery();

                transaccion.Commit();
            } // try
            catch (Exception ex)
            {
                transaccion.Rollback();

                log.Error(ex.Message);
            } // catch
            finally
            {
                DBHelper.cerrarConexion(conexion);
            } // finally
        } // insert

        private static string StatementInsertarCliente()
        {
            StringBuilder sb = new StringBuilder(0);

            sb.Append("INSERT INTO ga.cliente (nombre, direccion, cp, poblacion, provincia, pais, telefono, codigo_proveedor, fecha_alta, user_alta, user_modificacion, user_borrado) ");
            sb.Append("VALUES ( ");
            sb.Append(DBHelper.GetParameterSyntax("nombre")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("direccion")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("cp")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("poblacion")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("provincia")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("pais")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("telefono")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("codigo_proveedor")).Append(", ");
            sb.Append("now(), ");
            sb.Append(DBHelper.GetParameterSyntax("user_alta")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("user_modificacion")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("user_borrado"));
            sb.Append(" ) ");

            return sb.ToString();
        } // QueryObtenerClientes
    } // class
} // namespace
