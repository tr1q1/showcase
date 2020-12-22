namespace GestionFichajes
{
    partial class fGestionFichajes
    {
        /// <summary>
        /// Variable del diseñador necesaria.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén usando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben desechar; false en caso contrario.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido de este método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle10 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle11 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle12 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(fGestionFichajes));
            this.dgvFichajes = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.btnAlta = new System.Windows.Forms.Button();
            this.btnModificar = new System.Windows.Forms.Button();
            this.btnBorrar = new System.Windows.Forms.Button();
            this.btnImportar = new System.Windows.Forms.Button();
            this.txbFicheroAImportar = new System.Windows.Forms.TextBox();
            this.btnAceptar = new System.Windows.Forms.Button();
            this.btnCancelar = new System.Windows.Forms.Button();
            this.txbFecha = new System.Windows.Forms.MaskedTextBox();
            this.txbEmpresa = new System.Windows.Forms.MaskedTextBox();
            this.txbEmpleado = new System.Windows.Forms.MaskedTextBox();
            this.txbConcepto = new System.Windows.Forms.MaskedTextBox();
            this.txbHoras = new System.Windows.Forms.MaskedTextBox();
            this.txbMinutos = new System.Windows.Forms.MaskedTextBox();
            this.chbMostrarBorrados = new System.Windows.Forms.CheckBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lblEstado = new System.Windows.Forms.Label();
            this.btnBorrarConjunto = new System.Windows.Forms.Button();
            this.lblContador = new System.Windows.Forms.Label();
            this.btnDeshacerBorrado = new System.Windows.Forms.Button();
            this.txbEmpleadoABuscar = new System.Windows.Forms.MaskedTextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.btnBuscarEmpleado = new System.Windows.Forms.Button();
            this.btnRefrescar = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvFichajes)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvFichajes
            // 
            this.dgvFichajes.AllowUserToAddRows = false;
            this.dgvFichajes.AllowUserToDeleteRows = false;
            dataGridViewCellStyle10.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle10.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle10.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle10.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle10.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle10.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle10.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvFichajes.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle10;
            this.dgvFichajes.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle11.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle11.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle11.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle11.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle11.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle11.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle11.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgvFichajes.DefaultCellStyle = dataGridViewCellStyle11;
            this.dgvFichajes.Location = new System.Drawing.Point(12, 12);
            this.dgvFichajes.Name = "dgvFichajes";
            this.dgvFichajes.ReadOnly = true;
            dataGridViewCellStyle12.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle12.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle12.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle12.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle12.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle12.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle12.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgvFichajes.RowHeadersDefaultCellStyle = dataGridViewCellStyle12;
            this.dgvFichajes.Size = new System.Drawing.Size(654, 276);
            this.dgvFichajes.TabIndex = 0;
            this.dgvFichajes.CellEnter += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvFichajes_CellEnter);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(38, 339);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(56, 14);
            this.label1.TabIndex = 2;
            this.label1.Text = "Empresa";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(215, 339);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(63, 14);
            this.label2.TabIndex = 4;
            this.label2.Text = "Empleado";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(416, 339);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(42, 14);
            this.label3.TabIndex = 6;
            this.label3.Text = "Fecha";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(31, 394);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(63, 14);
            this.label4.TabIndex = 8;
            this.label4.Text = "Concepto";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(236, 394);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(42, 14);
            this.label5.TabIndex = 10;
            this.label5.Text = "Horas";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(402, 394);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(56, 14);
            this.label6.TabIndex = 12;
            this.label6.Text = "Minutos";
            // 
            // btnAlta
            // 
            this.btnAlta.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAlta.Location = new System.Drawing.Point(12, 444);
            this.btnAlta.Name = "btnAlta";
            this.btnAlta.Size = new System.Drawing.Size(84, 23);
            this.btnAlta.TabIndex = 8;
            this.btnAlta.Text = "Añadir";
            this.btnAlta.UseVisualStyleBackColor = true;
            this.btnAlta.Click += new System.EventHandler(this.btnAlta_Click);
            // 
            // btnModificar
            // 
            this.btnModificar.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnModificar.Location = new System.Drawing.Point(191, 444);
            this.btnModificar.Name = "btnModificar";
            this.btnModificar.Size = new System.Drawing.Size(85, 23);
            this.btnModificar.TabIndex = 10;
            this.btnModificar.Text = "Modificar";
            this.btnModificar.UseVisualStyleBackColor = true;
            this.btnModificar.Click += new System.EventHandler(this.btnModificar_Click);
            // 
            // btnBorrar
            // 
            this.btnBorrar.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnBorrar.Location = new System.Drawing.Point(100, 444);
            this.btnBorrar.Name = "btnBorrar";
            this.btnBorrar.Size = new System.Drawing.Size(85, 23);
            this.btnBorrar.TabIndex = 9;
            this.btnBorrar.Text = "Borrar";
            this.btnBorrar.UseVisualStyleBackColor = true;
            this.btnBorrar.Click += new System.EventHandler(this.btnBorrar_Click);
            // 
            // btnImportar
            // 
            this.btnImportar.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnImportar.Location = new System.Drawing.Point(591, 442);
            this.btnImportar.Name = "btnImportar";
            this.btnImportar.Size = new System.Drawing.Size(75, 23);
            this.btnImportar.TabIndex = 11;
            this.btnImportar.Text = "Importar";
            this.btnImportar.UseVisualStyleBackColor = true;
            this.btnImportar.Click += new System.EventHandler(this.btnImportar_Click);
            // 
            // txbFicheroAImportar
            // 
            this.txbFicheroAImportar.Enabled = false;
            this.txbFicheroAImportar.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbFicheroAImportar.Location = new System.Drawing.Point(327, 444);
            this.txbFicheroAImportar.MaxLength = 7;
            this.txbFicheroAImportar.Name = "txbFicheroAImportar";
            this.txbFicheroAImportar.ReadOnly = true;
            this.txbFicheroAImportar.Size = new System.Drawing.Size(258, 21);
            this.txbFicheroAImportar.TabIndex = 17;
            // 
            // btnAceptar
            // 
            this.btnAceptar.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnAceptar.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.btnAceptar.Enabled = false;
            this.btnAceptar.Image = ((System.Drawing.Image)(resources.GetObject("btnAceptar.Image")));
            this.btnAceptar.Location = new System.Drawing.Point(617, 339);
            this.btnAceptar.Name = "btnAceptar";
            this.btnAceptar.Size = new System.Drawing.Size(38, 31);
            this.btnAceptar.TabIndex = 12;
            this.btnAceptar.UseVisualStyleBackColor = true;
            this.btnAceptar.Click += new System.EventHandler(this.btnAceptar_Click);
            // 
            // btnCancelar
            // 
            this.btnCancelar.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnCancelar.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancelar.Enabled = false;
            this.btnCancelar.Image = ((System.Drawing.Image)(resources.GetObject("btnCancelar.Image")));
            this.btnCancelar.Location = new System.Drawing.Point(617, 381);
            this.btnCancelar.Name = "btnCancelar";
            this.btnCancelar.Size = new System.Drawing.Size(38, 31);
            this.btnCancelar.TabIndex = 13;
            this.btnCancelar.UseVisualStyleBackColor = true;
            this.btnCancelar.Click += new System.EventHandler(this.btnCancelar_Click);
            // 
            // txbFecha
            // 
            this.txbFecha.Enabled = false;
            this.txbFecha.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbFecha.Location = new System.Drawing.Point(465, 336);
            this.txbFecha.Mask = "00/00/0000";
            this.txbFecha.Name = "txbFecha";
            this.txbFecha.ReadOnly = true;
            this.txbFecha.Size = new System.Drawing.Size(100, 21);
            this.txbFecha.TabIndex = 4;
            this.txbFecha.ValidatingType = typeof(System.DateTime);
            // 
            // txbEmpresa
            // 
            this.txbEmpresa.Enabled = false;
            this.txbEmpresa.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbEmpresa.Location = new System.Drawing.Point(101, 336);
            this.txbEmpresa.Mask = "0000";
            this.txbEmpresa.Name = "txbEmpresa";
            this.txbEmpresa.ReadOnly = true;
            this.txbEmpresa.Size = new System.Drawing.Size(100, 21);
            this.txbEmpresa.TabIndex = 2;
            // 
            // txbEmpleado
            // 
            this.txbEmpleado.Enabled = false;
            this.txbEmpleado.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbEmpleado.Location = new System.Drawing.Point(284, 337);
            this.txbEmpleado.Mask = "00000";
            this.txbEmpleado.Name = "txbEmpleado";
            this.txbEmpleado.ReadOnly = true;
            this.txbEmpleado.Size = new System.Drawing.Size(100, 21);
            this.txbEmpleado.TabIndex = 3;
            // 
            // txbConcepto
            // 
            this.txbConcepto.Enabled = false;
            this.txbConcepto.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbConcepto.Location = new System.Drawing.Point(100, 391);
            this.txbConcepto.Mask = "00";
            this.txbConcepto.Name = "txbConcepto";
            this.txbConcepto.ReadOnly = true;
            this.txbConcepto.Size = new System.Drawing.Size(100, 21);
            this.txbConcepto.TabIndex = 5;
            // 
            // txbHoras
            // 
            this.txbHoras.Enabled = false;
            this.txbHoras.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbHoras.Location = new System.Drawing.Point(284, 391);
            this.txbHoras.Mask = "0000000";
            this.txbHoras.Name = "txbHoras";
            this.txbHoras.ReadOnly = true;
            this.txbHoras.Size = new System.Drawing.Size(100, 21);
            this.txbHoras.TabIndex = 6;
            // 
            // txbMinutos
            // 
            this.txbMinutos.Enabled = false;
            this.txbMinutos.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbMinutos.Location = new System.Drawing.Point(464, 391);
            this.txbMinutos.Mask = "00";
            this.txbMinutos.Name = "txbMinutos";
            this.txbMinutos.ReadOnly = true;
            this.txbMinutos.Size = new System.Drawing.Size(100, 21);
            this.txbMinutos.TabIndex = 7;
            // 
            // chbMostrarBorrados
            // 
            this.chbMostrarBorrados.AutoSize = true;
            this.chbMostrarBorrados.Font = new System.Drawing.Font("Source Code Pro", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chbMostrarBorrados.ImageAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.chbMostrarBorrados.Location = new System.Drawing.Point(542, 294);
            this.chbMostrarBorrados.Name = "chbMostrarBorrados";
            this.chbMostrarBorrados.Size = new System.Drawing.Size(124, 15);
            this.chbMostrarBorrados.TabIndex = 1;
            this.chbMostrarBorrados.Text = "Mostrar los borrados";
            this.chbMostrarBorrados.UseVisualStyleBackColor = true;
            this.chbMostrarBorrados.CheckedChanged += new System.EventHandler(this.chbMostrarBorrados_CheckedChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.Font = new System.Drawing.Font("Source Code Pro", 6.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(16, 312);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(583, 111);
            this.groupBox1.TabIndex = 27;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Fichaje actual";
            // 
            // lblEstado
            // 
            this.lblEstado.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblEstado.Location = new System.Drawing.Point(9, 528);
            this.lblEstado.Name = "lblEstado";
            this.lblEstado.Size = new System.Drawing.Size(654, 14);
            this.lblEstado.TabIndex = 28;
            this.lblEstado.Text = "No conectado";
            // 
            // btnBorrarConjunto
            // 
            this.btnBorrarConjunto.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnBorrarConjunto.Location = new System.Drawing.Point(12, 473);
            this.btnBorrarConjunto.Name = "btnBorrarConjunto";
            this.btnBorrarConjunto.Size = new System.Drawing.Size(264, 23);
            this.btnBorrarConjunto.TabIndex = 29;
            this.btnBorrarConjunto.Text = "Borrar los seleccionados";
            this.btnBorrarConjunto.UseVisualStyleBackColor = true;
            this.btnBorrarConjunto.Click += new System.EventHandler(this.button1_Click);
            // 
            // lblContador
            // 
            this.lblContador.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblContador.ForeColor = System.Drawing.Color.Red;
            this.lblContador.Location = new System.Drawing.Point(281, 492);
            this.lblContador.Name = "lblContador";
            this.lblContador.Size = new System.Drawing.Size(384, 14);
            this.lblContador.TabIndex = 30;
            this.lblContador.Text = "--";
            // 
            // btnDeshacerBorrado
            // 
            this.btnDeshacerBorrado.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDeshacerBorrado.Location = new System.Drawing.Point(12, 502);
            this.btnDeshacerBorrado.Name = "btnDeshacerBorrado";
            this.btnDeshacerBorrado.Size = new System.Drawing.Size(264, 23);
            this.btnDeshacerBorrado.TabIndex = 31;
            this.btnDeshacerBorrado.Text = "Recuperar borrados seleccionados";
            this.btnDeshacerBorrado.UseVisualStyleBackColor = true;
            this.btnDeshacerBorrado.Click += new System.EventHandler(this.btnDeshacerBorrado_Click);
            // 
            // txbEmpleadoABuscar
            // 
            this.txbEmpleadoABuscar.Font = new System.Drawing.Font("Source Code Pro Semibold", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txbEmpleadoABuscar.Location = new System.Drawing.Point(85, 290);
            this.txbEmpleadoABuscar.Mask = "00000";
            this.txbEmpleadoABuscar.Name = "txbEmpleadoABuscar";
            this.txbEmpleadoABuscar.Size = new System.Drawing.Size(100, 21);
            this.txbEmpleadoABuscar.TabIndex = 32;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(16, 292);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(63, 14);
            this.label7.TabIndex = 33;
            this.label7.Text = "Empleado";
            // 
            // btnBuscarEmpleado
            // 
            this.btnBuscarEmpleado.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnBuscarEmpleado.Location = new System.Drawing.Point(191, 290);
            this.btnBuscarEmpleado.Name = "btnBuscarEmpleado";
            this.btnBuscarEmpleado.Size = new System.Drawing.Size(75, 23);
            this.btnBuscarEmpleado.TabIndex = 34;
            this.btnBuscarEmpleado.Text = "Filtrar";
            this.btnBuscarEmpleado.UseVisualStyleBackColor = true;
            this.btnBuscarEmpleado.Click += new System.EventHandler(this.btnBuscarEmpleado_Click);
            // 
            // btnRefrescar
            // 
            this.btnRefrescar.Font = new System.Drawing.Font("Source Code Pro", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnRefrescar.Location = new System.Drawing.Point(272, 290);
            this.btnRefrescar.Name = "btnRefrescar";
            this.btnRefrescar.Size = new System.Drawing.Size(75, 23);
            this.btnRefrescar.TabIndex = 35;
            this.btnRefrescar.Text = "Limpiar Filtros";
            this.btnRefrescar.UseVisualStyleBackColor = true;
            this.btnRefrescar.Click += new System.EventHandler(this.btnRefrescar_Click);
            // 
            // fGestionFichajes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(678, 553);
            this.Controls.Add(this.btnRefrescar);
            this.Controls.Add(this.btnBuscarEmpleado);
            this.Controls.Add(this.txbEmpleadoABuscar);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.btnDeshacerBorrado);
            this.Controls.Add(this.lblContador);
            this.Controls.Add(this.btnBorrarConjunto);
            this.Controls.Add(this.lblEstado);
            this.Controls.Add(this.chbMostrarBorrados);
            this.Controls.Add(this.txbMinutos);
            this.Controls.Add(this.txbHoras);
            this.Controls.Add(this.txbConcepto);
            this.Controls.Add(this.txbEmpleado);
            this.Controls.Add(this.txbEmpresa);
            this.Controls.Add(this.txbFecha);
            this.Controls.Add(this.btnCancelar);
            this.Controls.Add(this.btnAceptar);
            this.Controls.Add(this.txbFicheroAImportar);
            this.Controls.Add(this.btnImportar);
            this.Controls.Add(this.btnBorrar);
            this.Controls.Add(this.btnModificar);
            this.Controls.Add(this.btnAlta);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dgvFichajes);
            this.Controls.Add(this.groupBox1);
            this.Name = "fGestionFichajes";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Gestion Fichajes";
            this.Load += new System.EventHandler(this.fGestionFichajes_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvFichajes)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvFichajes;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button btnAlta;
        private System.Windows.Forms.Button btnModificar;
        private System.Windows.Forms.Button btnBorrar;
        private System.Windows.Forms.Button btnImportar;
        private System.Windows.Forms.TextBox txbFicheroAImportar;
        private System.Windows.Forms.Button btnAceptar;
        private System.Windows.Forms.Button btnCancelar;
        private System.Windows.Forms.MaskedTextBox txbFecha;
        private System.Windows.Forms.MaskedTextBox txbEmpresa;
        private System.Windows.Forms.MaskedTextBox txbEmpleado;
        private System.Windows.Forms.MaskedTextBox txbConcepto;
        private System.Windows.Forms.MaskedTextBox txbHoras;
        private System.Windows.Forms.MaskedTextBox txbMinutos;
        private System.Windows.Forms.CheckBox chbMostrarBorrados;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label lblEstado;
        private System.Windows.Forms.Button btnBorrarConjunto;
        private System.Windows.Forms.Label lblContador;
        private System.Windows.Forms.Button btnDeshacerBorrado;
        private System.Windows.Forms.MaskedTextBox txbEmpleadoABuscar;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Button btnBuscarEmpleado;
        private System.Windows.Forms.Button btnRefrescar;
    }
}

