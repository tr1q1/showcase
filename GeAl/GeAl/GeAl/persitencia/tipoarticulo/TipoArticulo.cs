using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data;

namespace GeAl.persitencia.tipoarticulo
{
    class TipoArticulo
    {
        private UInt32 id;
        private string nombre;
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

        /// <summary>
        /// constructor de clase
        /// </summary>
        public TipoArticulo()
        {
            this.Id = 0;
            this.Nombre = String.Empty;
            this.FechaAlta = new DateTime();
            this.UsuarioAlta = String.Empty;
            this.FechaModificacion = new DateTime();
            this.UsuarioModificacion = String.Empty;
            this.Borrado = "N";
            this.FechaBorrado = new DateTime();
            this.UsuarioBorrado = String.Empty;
        }
    }
}
