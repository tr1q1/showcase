using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using MySql.Data.MySqlClient;
using GeAl.util;

namespace GeAl.persitencia.articulo
{
    class ArticuloDAO
    {
        #region Variables de clase

        private static readonly ILog log = LogManager.GetLogger(typeof(ArticuloDAO));

        #endregion

        internal static Articulo findByExternalId(string codProveedor)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlCommand cmd = conexion.CreateCommand();

            cmd.CommandText = StatementObtenerArticulos(codProveedor);
            cmd.Parameters.AddWithValue(
                DBHelper.GetParameterName("codigo_proveedor"),
                codProveedor.Trim()
            );

            Articulo resultado = new Articulo();
            try
            {
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        reader.Read();

                        int i = 0;
                        resultado.Id = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        resultado.Nombre = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.IdTipo = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        resultado.NombreTipo = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.CodProveedor = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.Descripcion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.Division = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        resultado.Accion = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        resultado.Almacen = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        resultado.Stock = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        resultado.Observaciones = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.PrecioUnitario = DBHelper.GetTNullable<decimal>(reader.GetValue(i++));

                        resultado.FechaAlta = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        resultado.UsuarioAlta = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.FechaModificacion = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        resultado.UsuarioModificacion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.Borrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        resultado.FechaBorrado = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        resultado.UsuarioBorrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                    } // while
                } // using
            } // try
            catch (Exception ex)
            {
                log.Error(ex.Message);
            } // catch
            finally
            {
                DBHelper.cerrarConexion(conexion);
            } // finally

            return resultado;
        } // findByExternalId

        private static string StatementObtenerArticulos(string codProveedor)
        {
            StringBuilder sb = new StringBuilder(0);
            sb.Append("SELECT a.id, a.nombre, a.idtipo, tipo.nombre, a.codigo_proveedor, a.descripcion, a.division, a.accion, a.almacen, a.stock, a.observaciones, a.precio_unitario, a.fecha_alta, a.user_alta, a.fecha_modificacion, a.user_modificacion, a.borrado, a.fecha_borrado, a.user_borrado ");
            sb.Append("FROM ga.articulo AS a, ga.tipo_articulo AS tipo ");
            sb.Append("WHERE a.borrado = 'N' ");
            sb.Append("AND tipo.id = a.idtipo ");

            if (0 < codProveedor.Trim().Length)
            {
                sb.Append("AND a.codigo_proveedor = ");
                sb.Append(DBHelper.GetParameterSyntax("codigo_proveedor"));
            } // then

            return sb.ToString();
        } // QueryObtenerClientes

        internal static void insert(Articulo articulo)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlTransaction transaccion = conexion.BeginTransaction();

            try
            {
                MySqlCommand cmd = conexion.CreateCommand();
                cmd.CommandText = StatementInsertarArticulo();
                cmd.Transaction = transaccion;

                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("nombre"), articulo.Nombre.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("idtipo"), articulo.IdTipo);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("codigo_proveedor"), articulo.CodProveedor.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("descripcion"), articulo.Descripcion.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("division"), articulo.Division);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("accion"), articulo.Accion);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("almacen"), articulo.Almacen);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("stock"), articulo.Stock);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("observaciones"), articulo.Observaciones.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("precio_unitario"), articulo.PrecioUnitario);

                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_alta"), articulo.UsuarioAlta.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_modificacion"), articulo.UsuarioModificacion.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_borrado"), articulo.UsuarioBorrado.Trim());

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

        private static string StatementInsertarArticulo()
        {
            StringBuilder sb = new StringBuilder(0);

            sb.Append("INSERT INTO ga.articulo (nombre, idtipo, codigo_proveedor, descripcion, division, accion, almacen, stock, observaciones, precio_unitario, fecha_alta, user_alta, user_modificacion, user_borrado) ");
            sb.Append("VALUES ( ");
            sb.Append(DBHelper.GetParameterSyntax("nombre")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("idtipo")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("codigo_proveedor")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("descripcion")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("division")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("accion")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("almacen")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("stock")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("observaciones")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("precio_unitario")).Append(", ");

            sb.Append("now(), ");
            sb.Append(DBHelper.GetParameterSyntax("user_alta")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("user_modificacion")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("user_borrado"));
            sb.Append(" ) ");

            return sb.ToString();
        } // QueryObtenerClientes
    } // class
} // namespace
