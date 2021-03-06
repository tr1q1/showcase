﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GeAl.persitencia.cliente
{
    class Cliente
    {
        private UInt32 id;
        private string nombre;
        private string direccion;
        private long cp;
        private string poblacion;
        private string provincia;
        private string pais;
        private string telefono;
        private string codProveedor;

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

        public string Direccion
        {
            get
            {
                return direccion;
            }

            set
            {
                direccion = value;
            }
        }

        public long Cp
        {
            get
            {
                return cp;
            }

            set
            {
                cp = value;
            }
        }

        public string Poblacion
        {
            get
            {
                return poblacion;
            }

            set
            {
                poblacion = value;
            }
        }

        public string Provincia
        {
            get
            {
                return provincia;
            }

            set
            {
                provincia = value;
            }
        }

        public string Pais
        {
            get
            {
                return pais;
            }

            set
            {
                pais = value;
            }
        }

        public string Telefono
        {
            get
            {
                return telefono;
            }

            set
            {
                telefono = value;
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
        public Cliente()
        {
            this.Id = 0;
            this.Nombre = "";
            this.Direccion = "";
            this.Cp = 0;
            this.Poblacion = "";
            this.Provincia = "";
            this.Pais = "";
            this.Telefono = "";
            this.CodProveedor = "";

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
