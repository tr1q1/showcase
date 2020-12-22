using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionFichajes.Entities
{
    public abstract class Entity<Guid>
    {
        #region Propiedades

        public virtual Guid Id
        {
            get;
            set;
        }

        protected virtual int Version
        {
            get;
            set;
        }

/*
        public virtual String userc
        {
            get;
            set;
        }

        public virtual String hostc
        {
            get;
            set;
        }

        public virtual DateTime datec
        {
            get;
            set;
        }

        public virtual String usera
        {
            get;
            set;
        }

        public virtual String hosta
        {
            get;
            set;
        }

        public virtual DateTime datea
        {
            get;
            set;
        }
*/
        #endregion Propiedades

        #region Métodos

        public override bool Equals(object obj)
        {
            return Equals(obj as Entity<Guid>);
        } // Equals

        private static bool IsTransient(Entity<Guid> obj)
        {
            return (
                    (obj != null) &&
                    (Equals(obj.Id, default(Guid)))
                   );
        }

        private Type GetUnproxiedType()
        {
            return GetType();
        }

        public virtual bool Equals(Entity<Guid> other)
        {
            if (other == null)
            {
                return false;
            } // then

            if (ReferenceEquals(this, other))
            {
                return true;
            } // then

            if (
                ! IsTransient(this) &&
                ! IsTransient(other) &&
                Equals(Id, other.Id)
            )
            {
                Type otherType = other.GetUnproxiedType();
                Type thisType = GetUnproxiedType();

                return thisType.IsAssignableFrom(otherType) || otherType.IsAssignableFrom(thisType);
            } // then

            return false;
        } // Equals

        public override int GetHashCode()
        {
            if (Equals(Id, default(Guid)))
            {
                return base.GetHashCode();
            } // then

            return Id.GetHashCode();
        } // GetHashCode

        #endregion Métodos
    } // abstract class
} // namespace
