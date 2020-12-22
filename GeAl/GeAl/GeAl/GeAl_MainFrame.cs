using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using log4net.Config;
//********************
using GeAl.util;
using GeAl.persitencia.articulo;
using GeAl.persitencia.tipoarticulo;
using GeAl.persitencia.cliente;
using GeAl.persitencia.movimiento;

namespace GeAl
{
    public partial class GeAl_MainFrame : Form
    {
        public GeAl_MainFrame()
        {
            InitializeComponent();
        }

        #region carga inicial

        private void GeAl_MainFrame_Load(object sender, EventArgs e)
        {
            // 1. acceso al fichero de configuracion
            Dictionary<string, string> configuracion = FileSystemHelper.ReadDictionaryFile();
            foreach (String key in configuracion.Keys)
            {
                System.Console.WriteLine(key + " - '" + configuracion[key] + "'");
            } // foreach

            if (0 < configuracion.Keys.Count)
            {
                // 2. se carga la configuracion para el logger
                XmlConfigurator.Configure(new System.IO.FileInfo(FileSystemHelper.GetValueFromConfig("LOG_CONF")));

                // 3. verificar que conecta correctamente la bbdd
                System.Console.WriteLine(DBHelper.testConexion());

                Movimiento item = new Movimiento();
                item.TipoMovimiento = "S";
                item.NumAlbaran = 16005588;
                item.Linea = 2;
                item.CodClienteProveedor = "3";
                item.CodArticuloProveedor = "8806084082060";
                item.Cantidad = 2;
                item.ObservacionesLinea = "";

                MovimientoDAO.insert(item);

                List<Movimiento> listado = MovimientoDAO.findByExternalArticuloId("8806084082060");
                foreach (Movimiento it in listado)
                {
                    System.Console.WriteLine(it.Id + " - '" + it.NumAlbaran + "' - '" + it.TipoMovimiento + "'");
                } // foreach

                // 4. cargar el listado del estado general del almacen (ordenado alfabeticamente por articulo)
            } // then
            else
            {
                MessageBox.Show("[ERROR] GeAl: imposible obtener los datos de configuración para esta instancia de la aplicación.");
            } // else
        } // GeAl_MainFrame_Load

        #endregion
    }
}
