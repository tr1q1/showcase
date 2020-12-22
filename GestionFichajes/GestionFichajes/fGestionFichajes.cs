using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

using GestionFichajes.Entities;
using GestionFichajes.Entities.BOL.Fichajes;

namespace GestionFichajes
{
    public partial class fGestionFichajes : Form
    {
        #region Definición de Tipos

        public enum TipoOperacion
        {
            Alta = 0,
            Borrado = 1,
            Modificacion = 2,
            Importacion = 3,
            BorradoConjunto = 4,
            DeshacerBorrado = 5,
            EnEspera = 666
        } // TipoOperacion

        #endregion Definición de Tipos

        #region Variables internas

        private TipoOperacion operacionActual = TipoOperacion.EnEspera;
        private string fichero = String.Empty;
        private Guid idFichajeSeleccionado = Guid.Empty;
        private string nameUser = String.Empty;

        #endregion Variables internas

        #region Constructores

        public fGestionFichajes(string nameUser)
        {
            InitializeComponent();

            this.nameUser = nameUser;
            this.Text = "Gestion Fichajes - " + this.nameUser;
        } // fGestionFichajes

        #endregion Constructores

        #region Métodos de Negocio

        private Int32 ToBase60(Int32 minutos)
        {
            if (minutos < 0)
            {
                minutos = 0;
            } // then

            Int32 resultado = (minutos * 60) / 100;

            return resultado;
        } // ToBase60 

        #endregion Métodos de Negocio

        #region Métodos de manejo de eventos

        private void fGestionFichajes_Load(object sender, EventArgs e)
        {
            this.Cursor = System.Windows.Forms.Cursors.WaitCursor;

            #region Se comprueba que se tenga acceso a la tabla de Fichajes en la BBDD de Epsilon

            Boolean resultado = false;
            using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
            {
                resultado = FichajeDAO.tablaFichajesAccesible(conexion);

                NHibernateSession.CerrarBBDD(conexion);
            } // using

            if (resultado)
            {
                this.lblEstado.Text = "Conectado a la BBDD de Epsilon";
                this.lblEstado.BackColor = Color.LightGreen;

                System.Collections.IDictionary settings = (System.Collections.IDictionary)System.Configuration.ConfigurationManager.GetSection("GestionFichajes");
                String server = (string)settings["EPSILONBD"];

                this.Text = this.Text + " (" + server + ")";

                this.recargarListaFichajes();
            } // then
            else
            {
                this.lblEstado.Text = "NO Conectado a la BBDD de Epsilon";
                this.lblEstado.BackColor = Color.Red;

                this.btnAlta.Enabled = false;
                this.btnBorrar.Enabled = false;
                this.btnModificar.Enabled = false;
                this.btnImportar.Enabled = false;
                this.btnBorrarConjunto.Enabled = false;
                this.btnDeshacerBorrado.Enabled = false;

                this.btnAceptar.Enabled = false;
                this.btnAceptar.BackColor = this.btnAlta.BackColor;
                this.btnCancelar.Enabled = false;
                this.btnCancelar.BackColor = this.btnAlta.BackColor;
            } // else

            #endregion Se comprueba que se tenga acceso a la tabla de Fichajes en la BBDD de Epsilon

            this.Cursor = System.Windows.Forms.Cursors.Default;
        } // fGestionFichajes_Load 

        private void btnImportar_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;

            System.Windows.Forms.OpenFileDialog ofd = new System.Windows.Forms.OpenFileDialog();
            ofd.InitialDirectory = "c:\\";
            ofd.Filter = "txt files (*.txt)|*.txt|prn files (*.prn)|*.prn";
            ofd.FilterIndex = 3;

            if (ofd.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                this.fichero = ofd.FileName; // nombre incluyendo la ruta completa hasta el mismo
                this.txbFicheroAImportar.Text = ofd.SafeFileName;

                this.operacionActual = TipoOperacion.Importacion;
                this.HabilitarBotonesDeConfirmacion();
            } // then

            Cursor.Current = Cursors.Default;
        } // btnImportar_Click

        private void HabilitarBotonesDeConfirmacion()
        {
            this.btnAlta.Enabled = false;
            this.btnBorrar.Enabled = false;
            this.btnModificar.Enabled = false;
            this.btnImportar.Enabled = false;
            this.btnBorrarConjunto.Enabled = false;
            this.btnDeshacerBorrado.Enabled = false;

            this.btnAceptar.Enabled = true;
            this.btnAceptar.BackColor = Color.LightGreen;
            this.btnCancelar.Enabled = true;
            this.btnCancelar.BackColor = Color.Red;
        } // HabilitarBotonesDeConfirmacion

        private void DeshabilitarBotones()
        {
            this.btnAlta.Enabled = false;
            this.btnBorrar.Enabled = false;
            this.btnModificar.Enabled = false;
            this.btnImportar.Enabled = false;
            this.btnBorrarConjunto.Enabled = false;
            this.btnDeshacerBorrado.Enabled = false;

            this.btnAceptar.Enabled = false;
            this.btnAceptar.BackColor = this.btnAlta.BackColor;
            this.btnCancelar.Enabled = false;
            this.btnCancelar.BackColor = this.btnAlta.BackColor;
        } // DeshabilitarBotones

        private void HabilitarBotonesDeOperaciones()
        {
            this.txbEmpresa.Enabled = false;
            this.txbEmpresa.ReadOnly = true;
//            this.txbEmpresa.Text = "";

            this.txbEmpleado.Enabled = false;
            this.txbEmpleado.ReadOnly = true;
//            this.txbEmpleado.Text = "";

            this.txbFecha.Enabled = false;
            this.txbFecha.ReadOnly = true;
//            this.txbFecha.Text = "";

            this.txbConcepto.Enabled = false;
            this.txbConcepto.ReadOnly = true;
//            this.txbConcepto.Text = "";

            this.txbHoras.Enabled = false;
            this.txbHoras.ReadOnly = true;
//            this.txbHoras.Text = "";

            this.txbMinutos.Enabled = false;
            this.txbMinutos.ReadOnly = true;
//            this.txbMinutos.Text = "";

            this.btnAlta.Enabled = true;
            this.btnBorrar.Enabled = true;
            this.btnModificar.Enabled = true;
            this.btnImportar.Enabled = true;
            this.btnBorrarConjunto.Enabled = true;
            this.btnDeshacerBorrado.Enabled = true;

            //            this.txbFicheroAImportar.Text = "";

            this.btnAceptar.Enabled = false;
            this.btnAceptar.BackColor = this.btnAlta.BackColor;
            this.btnCancelar.Enabled = false;
            this.btnCancelar.BackColor = this.btnAlta.BackColor;
            this.operacionActual = TipoOperacion.EnEspera;

            this.lblContador.Text = "--";
        } // HabilitarBotonesDeOperaciones

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            switch (this.operacionActual)
            {
                case TipoOperacion.Alta:
                    if (
                        (this.txbEmpresa.Text.Trim() != String.Empty) &&
                        (this.txbEmpleado.Text.Trim() != String.Empty) &&
                        (this.txbFecha.Text.Trim() != String.Empty) &&
                        (this.txbConcepto.Text.Trim() != String.Empty) &&
                        (this.txbHoras.Text.Trim() != String.Empty) &&
                        (this.txbMinutos.Text.Trim() != String.Empty)
                    )
                    {
                        using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
                        {
                        //                            if (! FichajeDAO.existeFichaje(conexion, Int32.Parse(this.txbEmpleado.Text.Trim()), DateTime.Parse(this.txbFecha.Text.Trim())))
                        //                            {
                            String resultadoOp = FichajeDAO.altaFichaje(
                                                        conexion,
                                                        Int32.Parse(this.txbEmpresa.Text.Trim()),
                                                        Int32.Parse(this.txbEmpleado.Text.Trim()),
                                                        DateTime.Parse(this.txbFecha.Text.Trim()),
                                                        this.txbConcepto.Text.Trim(),
                                                        Int32.Parse(this.txbHoras.Text.Trim()),
                                                        this.ToBase60(Int32.Parse(this.txbMinutos.Text.Trim())));

                            NHibernateSession.CerrarBBDD(conexion);

                            if (
                                (resultadoOp != null) &&
                                (resultadoOp != String.Empty)
                            )
                            {
                                MessageBox.Show(resultadoOp, "ADVERTENCIA", MessageBoxButtons.OK);
                            } // then
//                            } // then 
//                            else
//                            {
//                                MessageBox.Show("Fichaje para el empleado '" + this.txbEmpleado.Text.Trim() + "' en la fecha '" + DateTime.Parse(this.txbFecha.Text.Trim()) + "' insertado con anterioridad.", "ADVERTENCIA", MessageBoxButtons.OK);
//                            } // else
                        } // using 
                    } // then
                    else
                    {
                        MessageBox.Show("Falta algún valor de las propiedades del fichaje", "ADVERTENCIA", MessageBoxButtons.OK);
                    } // else

                    if (this.dgvFichajes.CurrentRow != null)
                    {
                        this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Empty;
                    } // then
                    break;

                case TipoOperacion.Borrado:
                    DialogResult confirmacion = MessageBox.Show("¿Está segur@ de querer borrar los datos resaltados?", "ADVERTENCIA", MessageBoxButtons.OKCancel);
                    if (confirmacion == DialogResult.OK)
                    {
                        using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
                        {
                            String resultadoOp = FichajeDAO.eliminarFichaje(conexion, this.idFichajeSeleccionado);

                            NHibernateSession.CerrarBBDD(conexion);

                            if (
                                (resultadoOp != null) &&
                                (resultadoOp != String.Empty)
                            )
                            {
                                MessageBox.Show(resultadoOp, "ADVERTENCIA", MessageBoxButtons.OK);
                            } // then
                        } // using 
                    } // then

                    if (this.dgvFichajes.CurrentRow != null)
                    {
                        this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Empty;
                    } // then
                    break;

                case TipoOperacion.Modificacion:
                    if (
                        (this.txbEmpresa.Text.Trim() != String.Empty) &&
                        (this.txbEmpleado.Text.Trim() != String.Empty) &&
                        (this.txbFecha.Text.Trim() != String.Empty) &&
                        (this.txbConcepto.Text.Trim() != String.Empty) &&
                        (this.txbHoras.Text.Trim() != String.Empty) &&
                        (this.txbMinutos.Text.Trim() != String.Empty)
                    )
                    {
                        using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
                        {
                            String resultadoOp = FichajeDAO.modificarFichaje(
                                                            conexion,
                                                            this.idFichajeSeleccionado,
                                                            Int32.Parse(this.txbEmpresa.Text.Trim()),
                                                            Int32.Parse(this.txbEmpleado.Text.Trim()),
                                                            DateTime.Parse(this.txbFecha.Text.Trim()),
                                                            this.txbConcepto.Text.Trim(),
                                                            Int32.Parse(this.txbHoras.Text.Trim()),
                                                            this.ToBase60(Int32.Parse(this.txbMinutos.Text.Trim())));

                            NHibernateSession.CerrarBBDD(conexion);

                            if (
                                (resultadoOp != null) &&
                                (resultadoOp != String.Empty)
                            )
                            {
                                MessageBox.Show(resultadoOp, "ADVERTENCIA", MessageBoxButtons.OK);
                            } // then
                        } // using 
                    } // then
                    else
                    {
                        MessageBox.Show("Falta algún valor de las propiedades del fichaje", "ADVERTENCIA", MessageBoxButtons.OK);
                    } // else

                    if (this.dgvFichajes.CurrentRow != null)
                    {
                        this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Empty;
                    } // then
                    break;

                case TipoOperacion.Importacion:
                    confirmacion = MessageBox.Show("¿Está segur@ de querer importar los datos del fichero '" + this.txbFicheroAImportar.Text + "'?", "ADVERTENCIA", MessageBoxButtons.OKCancel);
                    if (confirmacion == DialogResult.OK)
                    {
                        using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
                        {
                            IEnumerable<String> lines = System.IO.File.ReadLines(this.fichero);
                            String resultadoOp = String.Empty;
                            foreach (String line in lines)
                            {
                                if (line != String.Empty)
                                {
                                    //                                    if (! FichajeDAO.existeFichaje(conexion, Int32.Parse(line.Substring(4, 5)), DateTime.ParseExact(line.Substring(9, 8), "yyyyMMdd", new System.Globalization.CultureInfo("es-ES"))))
                                    //                                    {
                                    resultadoOp += FichajeDAO.altaFichaje(
                                                                conexion,
                                                                Int32.Parse(line.Substring(0, 4)),
                                                                Int32.Parse(line.Substring(4, 5)),
                                                                DateTime.ParseExact(line.Substring(9, 8), "yyyyMMdd", new System.Globalization.CultureInfo("es-ES")),
                                                                line.Substring(29, 2),
                                                                Int32.Parse(line.Substring(17, 7)),
                                                                this.ToBase60(Int32.Parse(line.Substring(24, 2))));

                                        if (
                                            (resultadoOp != null) &&
                                            (resultadoOp != String.Empty)
                                        )
                                        {
                                            MessageBox.Show(resultadoOp, "ADVERTENCIA", MessageBoxButtons.OK);
                                        } // then
//                                    } // then
//                                    else
//                                    {                                                                                                     
//                                        resultadoOp += "Fichaje para el empleado '" + Int32.Parse(line.Substring(4, 5))  + "' en la fecha '" + DateTime.ParseExact(line.Substring(9, 8), "yyyyMMdd", new System.Globalization.CultureInfo("es-ES")) + "' insertado con anterioridad.\r\n";
//                                    } // else
                                } // then
                            } // foreach

                            NHibernateSession.CerrarBBDD(conexion);

                            if (
                                (resultadoOp != null) &&
                                (resultadoOp != String.Empty)
                            )
                            {
                                MessageBox.Show(resultadoOp, "ADVERTENCIA", MessageBoxButtons.OK);
                            } // then
                            else
                            {
                                MessageBox.Show("Proceso de importación del fichero '" + this.txbFicheroAImportar.Text + "' finalizada.", "Información", MessageBoxButtons.OK);
                            } // then
                        } // using 
                    } // then 
                    break;

                case TipoOperacion.BorradoConjunto:
                    confirmacion = MessageBox.Show("¿Está segur@ de querer borrar los datos resaltados?", "ADVERTENCIA", MessageBoxButtons.OKCancel);
                    if (confirmacion == DialogResult.OK)
                    {
                        using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
                        {
                            String resultadoOp = String.Empty;
                            
                            DataGridViewSelectedRowCollection SelectRowsSet = this.dgvFichajes.SelectedRows;
                            System.Collections.IEnumerator iterador = SelectRowsSet.GetEnumerator();
                            iterador.Reset();
                            while (iterador.MoveNext())
                            {
                                DataGridViewRow row = (DataGridViewRow)iterador.Current;
                                resultadoOp += FichajeDAO.eliminarFichaje(conexion, Guid.Parse(row.Cells["Id"].Value.ToString()));
                            } // while
                            
                            NHibernateSession.CerrarBBDD(conexion);

                            if (
                                (resultadoOp != null) &&
                                (resultadoOp != String.Empty)
                            )
                            {
                                MessageBox.Show(resultadoOp, "ADVERTENCIA", MessageBoxButtons.OK);
                            } // then
                        } // using 
                    } // then

                    if (this.dgvFichajes.CurrentRow != null)
                    {
                        this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Empty;
                    } // then
                    break;

                case TipoOperacion.DeshacerBorrado:
                    confirmacion = MessageBox.Show("¿Está segur@ de querer recuperar los datos resaltados?", "ADVERTENCIA", MessageBoxButtons.OKCancel);
                    if (confirmacion == DialogResult.OK)
                    {
                        using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
                        {
                            String resultadoOp = String.Empty;

                            DataGridViewSelectedRowCollection SelectRowsSet = this.dgvFichajes.SelectedRows;
                            System.Collections.IEnumerator iterador = SelectRowsSet.GetEnumerator();
                            iterador.Reset();
                            while (iterador.MoveNext())
                            {
                                DataGridViewRow row = (DataGridViewRow)iterador.Current;
                                resultadoOp += FichajeDAO.deshacerBorrado(conexion, Guid.Parse(row.Cells["Id"].Value.ToString()));
                            } // while

                            NHibernateSession.CerrarBBDD(conexion);

                            if (
                                (resultadoOp != null) &&
                                (resultadoOp != String.Empty)
                            )
                            {
                                MessageBox.Show(resultadoOp, "ADVERTENCIA", MessageBoxButtons.OK);
                            } // then
                        } // using 
                    } // then

                    if (this.dgvFichajes.CurrentRow != null)
                    {
                        this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Empty;
                    } // then
                    break;

                case TipoOperacion.EnEspera:
                default:
                    break;
            } // switch

            this.recargarListaFichajes();
            this.HabilitarBotonesDeOperaciones();
        } // btnAceptar_Click

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            if (this.dgvFichajes.CurrentRow != null)
            {
                this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Empty;
            } // then
            this.operacionActual = TipoOperacion.EnEspera;
            this.HabilitarBotonesDeOperaciones();
        } // btnCancelar_Click

        private void btnAlta_Click(object sender, EventArgs e)
        {
            this.operacionActual = TipoOperacion.Alta;
            this.HabilitarBotonesDeConfirmacion();

            this.txbEmpresa.Enabled = true;
            this.txbEmpresa.ReadOnly = false;
            this.txbEmpresa.Text = "1";

            this.txbEmpleado.Enabled = true;
            this.txbEmpleado.ReadOnly = false;
            this.txbEmpleado.Text = "";

            this.txbFecha.Enabled = true;
            this.txbFecha.ReadOnly = false;
            this.txbFecha.Text = DateTime.Now.ToString("dd/MM/yyyy");

            this.txbConcepto.Enabled = true;
            this.txbConcepto.ReadOnly = false;
            this.txbConcepto.Text = "00";

            this.txbHoras.Enabled = true;
            this.txbHoras.ReadOnly = false;
            this.txbHoras.Text = "0";

            this.txbMinutos.Enabled = true;
            this.txbMinutos.ReadOnly = false;
            this.txbMinutos.Text = "0";

            this.txbEmpleado.Focus();
        } // btnAlta_Click

        private void btnBorrar_Click(object sender, EventArgs e)
        {
            this.operacionActual = TipoOperacion.Borrado;
            this.HabilitarBotonesDeConfirmacion();

            if (this.dgvFichajes.CurrentRow != null)
            {
                this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Red;
            } // then
        } // btnBorrar_Click

        private void btnModificar_Click(object sender, EventArgs e)
        {
            this.operacionActual = TipoOperacion.Modificacion;
            this.HabilitarBotonesDeConfirmacion();

            if (this.dgvFichajes.CurrentRow != null)
            {
                this.dgvFichajes.CurrentRow.DefaultCellStyle.BackColor = Color.Red;
            } // then

            this.txbConcepto.Enabled = true;
            this.txbConcepto.ReadOnly = false;

            this.txbHoras.Enabled = true;
            this.txbHoras.ReadOnly = false;

            this.txbMinutos.Enabled = true;
            this.txbMinutos.ReadOnly = false;

            this.txbConcepto.Focus();
        } // btnModificar_Click

        private void dgvFichajes_CellEnter(object sender, DataGridViewCellEventArgs e)
        {
            if (
                (this.dgvFichajes.CurrentRow != null) &&
                (this.dgvFichajes.CurrentRow.Cells["Id"].Value != null) &&
                (this.idFichajeSeleccionado != Guid.Parse(this.dgvFichajes.CurrentRow.Cells["Id"].Value.ToString()))
            )
            {
                this.txbEmpresa.Text = this.dgvFichajes.CurrentRow.Cells["Empresa"].Value.ToString();
                this.txbEmpleado.Text = this.dgvFichajes.CurrentRow.Cells["Empleado"].Value.ToString();
                this.txbFecha.Text = this.dgvFichajes.CurrentRow.Cells["Fecha"].Value.ToString();
                this.txbConcepto.Text = this.dgvFichajes.CurrentRow.Cells["Concepto"].Value.ToString();
                this.txbHoras.Text = this.dgvFichajes.CurrentRow.Cells["Horas"].Value.ToString();
                this.txbMinutos.Text = this.dgvFichajes.CurrentRow.Cells["Minutos"].Value.ToString();

                this.idFichajeSeleccionado = Guid.Parse(this.dgvFichajes.CurrentRow.Cells["Id"].Value.ToString());

                if (this.dgvFichajes.CurrentRow.Cells["Borrado"].Value.ToString() == "1")
                {
                    this.DeshabilitarBotones();
                    this.btnDeshacerBorrado.Enabled = true;
                } // then
                else
                {
                    this.HabilitarBotonesDeOperaciones();
                } // else
            } // then
        } // dgvFichajes_CellEnter

        private void recargarListaFichajes()
        {
            using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
            {
                IList<Fichaje> fichajes = null;
                if (this.txbEmpleadoABuscar.Text.Trim() != String.Empty)
                {
                    fichajes = FichajeDAO.obtenerFichajesEmpleado(conexion, Int32.Parse(this.txbEmpleadoABuscar.Text.Trim()), "Fecha", "DESC", this.chbMostrarBorrados.Checked);
                } // then
                else
                {
                    fichajes = FichajeDAO.obtenerFichajes(conexion, "Fecha", "DESC", this.chbMostrarBorrados.Checked);
                } // else

                this.dgvFichajes.Rows.Clear();
                if (
                    (fichajes != null) &&
                    (fichajes.Count > 0)
                )
                {
                    // añadir los nombres de las columnas
                    this.dgvFichajes.ColumnCount = 8;
                    this.dgvFichajes.Columns[0].Name = "Empresa";
                    this.dgvFichajes.Columns[1].Name = "Empleado";
                    this.dgvFichajes.Columns[2].Name = "Fecha";
                    this.dgvFichajes.Columns[3].Name = "Concepto";
                    this.dgvFichajes.Columns[4].Name = "Horas";
                    this.dgvFichajes.Columns[5].Name = "Minutos";
                    this.dgvFichajes.Columns[6].Name = "Borrado";
                    this.dgvFichajes.Columns[7].Name = "Id";

                    foreach (Fichaje fichajeActual in fichajes)
                    {
                        DataGridViewRow row = (DataGridViewRow)this.dgvFichajes.RowTemplate.Clone();

                        row.CreateCells(this.dgvFichajes,
                                        fichajeActual.Empresa,
                                        fichajeActual.Empleado,
                                        fichajeActual.Fecha,
                                        fichajeActual.Concepto,
                                        fichajeActual.Horas,
                                        fichajeActual.Minutos,
                                        fichajeActual.Borrado,
                                        fichajeActual.Id
                                       );

                        if (fichajeActual.Borrado == 1)
                        {
                            row.DefaultCellStyle.BackColor = Color.LightGray;
                        } // then

                        this.dgvFichajes.Rows.Add(row);
                    } // foreach

                    this.dgvFichajes.Columns["Borrado"].Visible = false;
                    this.dgvFichajes.Columns["Id"].Visible = false;
                    this.dgvFichajes.Columns["Fecha"].DefaultCellStyle.Format = "dd/MM/yyyy";
                    this.dgvFichajes.Columns["Fecha"].HeaderText = "Fecha Inicio/Fin";
                    this.dgvFichajes.RowHeadersWidth = 30;
                } // then

                NHibernateSession.CerrarBBDD(conexion);
            } // using
        } // recargarListaFichajes

        private void chbMostrarBorrados_CheckedChanged(object sender, EventArgs e)
        {
            this.recargarListaFichajes();
        } // chbMostrarBorrados_CheckedChanged

        private void button1_Click(object sender, EventArgs e)
        {
            this.operacionActual = TipoOperacion.BorradoConjunto;
            this.HabilitarBotonesDeConfirmacion();

            if (this.dgvFichajes.SelectedRows != null)
            {
                this.lblContador.Text = "Tiene " + this.dgvFichajes.SelectedRows.Count + " fichajes seleccionados para ser borrados";
            } // then
        } // button1_Click

        private void btnDeshacerBorrado_Click(object sender, EventArgs e)
        {
            this.operacionActual = TipoOperacion.DeshacerBorrado;
            this.HabilitarBotonesDeConfirmacion();

            if (this.dgvFichajes.SelectedRows != null)
            {
                this.lblContador.Text = "Tiene " + this.dgvFichajes.SelectedRows.Count + " fichajes seleccionados para ser recuperados";
            } // then
        } // btnDeshacerBorrado_Click

        private void btnBuscarEmpleado_Click(object sender, EventArgs e)
        {
            if (this.txbEmpleadoABuscar.Text.Trim() != String.Empty)
            {
                using (NHibernate.ISession conexion = NHibernateSession.AbrirBBDD())
                {
                    IList<Fichaje> fichajes = FichajeDAO.obtenerFichajesEmpleado(conexion, Int32.Parse(this.txbEmpleadoABuscar.Text.Trim()), "Fecha", "DESC", this.chbMostrarBorrados.Checked);

                    this.dgvFichajes.Rows.Clear();
                    if (
                        (fichajes != null) &&
                        (fichajes.Count > 0)
                    )
                    {
                        // añadir los nombres de las columnas
                        this.dgvFichajes.ColumnCount = 8;
                        this.dgvFichajes.Columns[0].Name = "Empresa";
                        this.dgvFichajes.Columns[1].Name = "Empleado";
                        this.dgvFichajes.Columns[2].Name = "Fecha";
                        this.dgvFichajes.Columns[3].Name = "Concepto";
                        this.dgvFichajes.Columns[4].Name = "Horas";
                        this.dgvFichajes.Columns[5].Name = "Minutos";
                        this.dgvFichajes.Columns[6].Name = "Borrado";
                        this.dgvFichajes.Columns[7].Name = "Id";

                        foreach (Fichaje fichajeActual in fichajes)
                        {
                            DataGridViewRow row = (DataGridViewRow)this.dgvFichajes.RowTemplate.Clone();

                            row.CreateCells(this.dgvFichajes,
                                            fichajeActual.Empresa,
                                            fichajeActual.Empleado,
                                            fichajeActual.Fecha,
                                            fichajeActual.Concepto,
                                            fichajeActual.Horas,
                                            fichajeActual.Minutos,
                                            fichajeActual.Borrado,
                                            fichajeActual.Id
                                           );

                            if (fichajeActual.Borrado == 1)
                            {
                                row.DefaultCellStyle.BackColor = Color.LightGray;
                            } // then

                            this.dgvFichajes.Rows.Add(row);
                        } // foreach

                        this.dgvFichajes.Columns["Borrado"].Visible = false;
                        this.dgvFichajes.Columns["Id"].Visible = false;
                        this.dgvFichajes.Columns["Fecha"].DefaultCellStyle.Format = "dd/MM/yyyy";
                        this.dgvFichajes.Columns["Fecha"].HeaderText = "Fecha Inicio/Fin";
                        this.dgvFichajes.RowHeadersWidth = 30;
                    } // then

                    NHibernateSession.CerrarBBDD(conexion);
                } // using
            } // then
        } // btnBuscarEmpleado_Click

        private void btnRefrescar_Click(object sender, EventArgs e)
        {
            this.chbMostrarBorrados.Checked = false;
            this.txbEmpleadoABuscar.Text = "";

            this.recargarListaFichajes();
        } // btnRefrescar_Click

        #endregion Métodos de manejo de eventos
    } // class
} // namespace
