using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GeAl.persitencia.articulo
{
    class Articulo
    {
        private UInt32 id;
        private string nombre;
        private UInt32 idTipo;
        private string nombreTipo;
        private string codProveedor;
        private string descripcion;
        private UInt32 division;
        private UInt32 accion;
        private UInt32 almacen;
        private UInt32 stock;
        private string observaciones;
        private decimal precioUnitario;

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

        public string Nombre
        {
            get
            {
                return nombre;
            }

            set
            {
                nombre = value;
            }
        }

        public UInt32 IdTipo
        {
            get
            {
                return idTipo;
            }

            set
            {
                idTipo = value;
            }
        }

        public string NombreTipo
        {
            get
            {
                return nombreTipo;
            }

            set
            {
                nombreTipo = value;
            }
        }

        public string CodProveedor
        {
            get
            {
                return codProveedor;
            }

            set
            {
                codProveedor = value;
            }
        }

        public string Descripcion
        {
            get
            {
                return descripcion;
            }

            set
            {
                descripcion = value;
            }
        }

        public UInt32 Division
        {
            get
            {
                return division;
            }

            set
            {
                division = value;
            }
        }

        public UInt32 Accion
        {
            get
            {
                return accion;
            }

            set
            {
                accion = value;
            }
        }

        public UInt32 Almacen
        {
            get
            {
                return almacen;
            }

            set
            {
                almacen = value;
            }
        }

        public UInt32 Stock
        {
            get
            {
                return stock;
            }

            set
            {
                stock = value;
            }
        }

        public string Observaciones
        {
            get
            {
                return observaciones;
            }

            set
            {
                observaciones = value;
            }
        }

        public decimal PrecioUnitario
        {
            get
            {
                return precioUnitario;
            }

            set
            {
                precioUnitario = value;
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

        public Articulo()
        {
            this.Id = 0;
            this.Nombre = "";
            this.IdTipo = 0;
            this.CodProveedor = "";
            this.Descripcion = "";
            this.Division = 1;
            this.Accion = 3;
            this.Almacen = 27;
            this.Stock = 0;
            this.Observaciones = "";
            this.PrecioUnitario = 0;

            this.FechaAlta = new DateTime();
            this.UsuarioAlta = String.Empty;
            this.FechaModificacion = new DateTime();
            this.UsuarioModificacion = String.Empty;
            this.Borrado = "N";
            this.FechaBorrado = new DateTime();
            this.UsuarioBorrado = String.Empty;
    }
    } // class
} // namespace
