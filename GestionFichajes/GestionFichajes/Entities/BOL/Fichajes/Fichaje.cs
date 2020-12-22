using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionFichajes.Entities.BOL.Fichajes
{
    public class Fichaje: Entity<Guid>
    {
        #region Propiedades

        public virtual int Empresa { get; set; }
        public virtual int Empleado { get; set; }
        public virtual DateTime Fecha { get; set; }
        public virtual string Concepto { get; set; }
        public virtual int Horas { get; set; }
        public virtual int Minutos { get; set; }
        public virtual int Borrado { get; set; }

        #endregion Propiedades

        #region Constructores

        public Fichaje()
        {
        }

        #endregion Constructores
    } // class
} // namespace
