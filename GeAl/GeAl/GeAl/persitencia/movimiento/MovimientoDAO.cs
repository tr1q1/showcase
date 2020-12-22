using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using log4net;
using MySql.Data.MySqlClient;
using GeAl.util;

namespace GeAl.persitencia.movimiento
{
    class MovimientoDAO
    {
        #region Variables de clase

        private static readonly ILog log = LogManager.GetLogger(typeof(MovimientoDAO));

        #endregion

        internal static List<Movimiento> findByExternalClienteId(string codClienteProveedor)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlCommand cmd = conexion.CreateCommand();

            cmd.CommandText = StatementObtenerMovimientos(codClienteProveedor, null);
            cmd.Parameters.AddWithValue(
                DBHelper.GetParameterName("codigo_cliente_proveedor"),
                codClienteProveedor.Trim()
            );

            List<Movimiento> resultados = new List<Movimiento>(0);
            try
            {
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Movimiento item = new Movimiento();
                        
                        int i = 0;
                        item.Id = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        item.TipoMovimiento = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.NumAlbaran = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        item.Linea = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        item.CodClienteProveedor = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.NombreCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.DireccionCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.CpCliente = DBHelper.GetTNullable<int>(reader.GetValue(i++));
                        item.PoblacionCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.ProvinciaCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.PaisCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.TelefonoCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                        item.FechaAlta = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        item.UsuarioAlta = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.FechaModificacion = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        item.UsuarioModificacion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.Borrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.FechaBorrado = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        item.UsuarioBorrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                        resultados.Add(item);
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

            return resultados;
        } // findByExternalClienteId

        internal static List<Movimiento> findByExternalArticuloId(string codArticuloProveedor)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlCommand cmd = conexion.CreateCommand();

            cmd.CommandText = StatementObtenerMovimientos(null, codArticuloProveedor);
            cmd.Parameters.AddWithValue(
                DBHelper.GetParameterName("codigo_articulo_proveedor"),
                codArticuloProveedor.Trim()
            );

            List<Movimiento> resultados = new List<Movimiento>(0);
            try
            {
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Movimiento item = new Movimiento();

                        int i = 0;
                        item.Id = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        item.TipoMovimiento = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.NumAlbaran = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        item.Linea = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));

                        item.CodClienteProveedor = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.NombreCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.DireccionCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.CpCliente = DBHelper.GetTNullable<int>(reader.GetValue(i++));
                        item.PoblacionCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.ProvinciaCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.PaisCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.TelefonoCliente = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                        item.CodArticuloProveedor = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.NombreArticulo = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                        item.Cantidad = DBHelper.GetTNullable<UInt32>(reader.GetValue(i++));
                        item.ObservacionesLinea = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                        item.FechaAlta = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        item.UsuarioAlta = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.FechaModificacion = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        item.UsuarioModificacion = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.Borrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));
                        item.FechaBorrado = DBHelper.GetTNullable<DateTime>(reader.GetValue(i++));
                        item.UsuarioBorrado = DBHelper.GetTNullable<String>(reader.GetValue(i++));

                        resultados.Add(item);
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

            return resultados;
        } // findByExternalArticuloId

        private static string StatementObtenerMovimientos(string codClienteProveedor, string codArticuloProveedor)
        {
            StringBuilder sb = new StringBuilder(0);
            sb.Append("SELECT a.id, a.tipo_movimiento, a.num_albaran, a.linea, ");
            sb.Append("a.codigo_cliente_proveedor, cliente.nombre, cliente.direccion, cliente.cp, cliente.poblacion, cliente.provincia, cliente.pais, cliente.telefono, ");
            sb.Append("a.codigo_articulo_proveedor, articulo.nombre, ");
            sb.Append("a.cantidad, a.observaciones_linea, a.fecha_alta, a.user_alta, a.fecha_modificacion, a.user_modificacion, a.borrado, a.fecha_borrado, a.user_borrado ");
            sb.Append("FROM ga.movimiento AS a, ga.cliente AS cliente, ga.articulo AS articulo ");
            sb.Append("WHERE a.borrado = 'N' ");
            sb.Append("AND cliente.codigo_proveedor = a.codigo_cliente_proveedor ");
            sb.Append("AND articulo.codigo_proveedor = a.codigo_articulo_proveedor ");

            if (
                (codClienteProveedor != null) &&
                (0 < codClienteProveedor.Trim().Length)
            )
            {
                sb.Append("AND a.codigo_cliente_proveedor = ");
                sb.Append(DBHelper.GetParameterSyntax("codigo_cliente_proveedor"));
            } // then

            if (
                (codArticuloProveedor != null) &&
                (0 < codArticuloProveedor.Trim().Length)
            )
            {
                sb.Append("AND a.codigo_articulo_proveedor = ");
                sb.Append(DBHelper.GetParameterSyntax("codigo_articulo_proveedor"));
            } // then

            return sb.ToString();
        } // QueryObtenerClientes

        internal static void insert(Movimiento movimiento)
        {
            MySqlConnection conexion = DBHelper.abrirConexion();
            MySqlTransaction transaccion = conexion.BeginTransaction();

            try
            {
                MySqlCommand cmd = conexion.CreateCommand();
                cmd.CommandText = StatementInsertarMovimiento();
                cmd.Transaction = transaccion;

                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("tipo_movimiento"), movimiento.TipoMovimiento.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("num_albaran"), movimiento.NumAlbaran);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("linea"), movimiento.Linea);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("codigo_cliente_proveedor"), movimiento.CodClienteProveedor.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("codigo_articulo_proveedor"), movimiento.CodArticuloProveedor.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("cantidad"), movimiento.Cantidad);
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("observaciones_linea"), movimiento.ObservacionesLinea.Trim());

                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_alta"), Environment.UserName.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_modificacion"), Environment.UserName.Trim());
                cmd.Parameters.AddWithValue(DBHelper.GetParameterName("user_borrado"), Environment.UserName.Trim());

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

        private static string StatementInsertarMovimiento()
        {
            StringBuilder sb = new StringBuilder(0);

            sb.Append("INSERT INTO ga.movimiento (tipo_movimiento, num_albaran, linea, codigo_cliente_proveedor, codigo_articulo_proveedor, cantidad, observaciones_linea, fecha_alta, user_alta, user_modificacion, user_borrado) ");
            sb.Append("VALUES ( ");
            sb.Append(DBHelper.GetParameterSyntax("tipo_movimiento")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("num_albaran")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("linea")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("codigo_cliente_proveedor")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("codigo_articulo_proveedor")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("cantidad")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("observaciones_linea")).Append(", ");

            sb.Append("now(), ");
            sb.Append(DBHelper.GetParameterSyntax("user_alta")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("user_modificacion")).Append(", ");
            sb.Append(DBHelper.GetParameterSyntax("user_borrado"));
            sb.Append(" ) ");

            return sb.ToString();
        } // QueryObtenerClientes
    } // class
} // namespace
