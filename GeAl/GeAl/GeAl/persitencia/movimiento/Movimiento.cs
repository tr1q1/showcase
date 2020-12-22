using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GeAl.persitencia.movimiento
{
    class Movimiento
    {
        private UInt32 id;
        private string tipoMovimiento;
        private UInt32 numAlbaran;
        private UInt32 linea;
        private string codClienteProveedor;
        private string nombreCliente;
        private string direccionCliente;
        private long cpCliente;
        private string poblacionCliente;
        private string provinciaCliente;
        private string paisCliente;
        private string telefonoCliente;
        private string codArticuloProveedor;
        private string nombreArticulo;
        private UInt32 cantidad;
        private string observacionesLinea;

        private DateTime fechaAlta;
        private string usuarioAlta;
        private DateTime fechaModificacion;
        private string usuarioModificacion;
        private string borrado;
        private DateTime fechaBorrado;
        private string usuarioBorrado;

        public UInt32 Id
        {
            get
            {
                return id;
            }

            set
            {
                id = value;
            }
        }

        public string TipoMovimiento
        {
            get
            {
                return tipoMovimiento;
            }

            set
            {
                tipoMovimiento = value;
            }
        }

        public UInt32 NumAlbaran
        {
            get
            {
                return numAlbaran;
            }

            set
            {
                numAlbaran = value;
            }
        }

        public UInt32 Linea
        {
            get
            {
                return linea;
            }

            set
            {
                linea = value;
            }
        }

        public string CodClienteProveedor
        {
            get
            {
                return codClienteProveedor;
            }

            set
            {
                codClienteProveedor = value;
            }
        }

        public string CodArticuloProveedor
        {
            get
            {
                return codArticuloProveedor;
            }

            set
            {
                codArticuloProveedor = value;
            }
        }

        public UInt32 Cantidad
        {
            get
            {
                return cantidad;
            }

            set
            {
                cantidad = value;
            }
        }

        public string ObservacionesLinea
        {
            get
            {
                return observacionesLinea;
            }

            set
            {
                observacionesLinea = value;
            }
        }

        public DateTime FechaAlta
        {
            get
            {
                return fechaAlta;
            }

            set
            {
                fechaAlta = value;
            }
        }

        public string UsuarioAlta
        {
            get
            {
                return usuarioAlta;
            }

            set
            {
                usuarioAlta = value;
            }
        }

        public DateTime FechaModificacion
        {
            get
            {
                return fechaModificacion;
            }

            set
            {
                fechaModificacion = value;
            }
        }

        public string UsuarioModificacion
        {
            get
            {
                return usuarioModificacion;
            }

            set
            {
                usuarioModificacion = value;
            }
        }

        public string Borrado
        {
            get
            {
                return borrado;
            }

            set
            {
                borrado = value;
            }
        }

        public DateTime FechaBorrado
        {
            get
            {
                return fechaBorrado;
            }

            set
            {
                fechaBorrado = value;
            }
        }

        public string UsuarioBorrado
        {
            get
            {
                return usuarioBorrado;
            }

            set
            {
                usuarioBorrado = value;
            }
        }

        public string NombreCliente
        {
            get
            {
                return nombreCliente;
            }

            set
            {
                nombreCliente = value;
            }
        }

        public string DireccionCliente
        {
            get
            {
                return direccionCliente;
            }

            set
            {
                direccionCliente = value;
            }
        }

        public long CpCliente
        {
            get
            {
                return cpCliente;
            }

            set
            {
                cpCliente = value;
            }
        }

        public string PoblacionCliente
        {
            get
            {
                return poblacionCliente;
            }

            set
            {
                poblacionCliente = value;
            }
        }

        public string ProvinciaCliente
        {
            get
            {
                return provinciaCliente;
            }

            set
            {
                provinciaCliente = value;
            }
        }

        public string PaisCliente
        {
            get
            {
                return paisCliente;
            }

            set
            {
                paisCliente = value;
            }
        }

        public string TelefonoCliente
        {
            get
            {
                return telefonoCliente;
            }

            set
            {
                telefonoCliente = value;
            }
        }

        public string NombreArticulo
        {
            get
            {
                return nombreArticulo;
            }

            set
            {
                nombreArticulo = value;
            }
        }

        /// <summary>
        /// constructor de clase
        /// </summary>
        public Movimiento()
        {
            this.Id = 0;
            this.TipoMovimiento = "E";
            this.NumAlbaran = 0;
            this.Linea = 0;
            this.CodClienteProveedor = "";
            this.CodArticuloProveedor = "";
            this.Cantidad = 0;
            this.ObservacionesLinea = "";

            this.FechaAlta = new DateTime();
            this.UsuarioAlta = String.Empty;
            this.FechaModificacion = new DateTime();
            this.UsuarioModificacion = String.Empty;
            this.Borrado = "N";
            this.FechaBorrado = new DateTime();
            this.UsuarioBorrado = String.Empty;
        }
    } // class
}
