using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GestionFichajes.Entities.BOL.Fichajes
{
    public class FichajeDAO
    {
        public static IList<Fichaje> obtenerFichajes(NHibernate.ISession session, string campoAOrdenar, string tipoOrdenacion, Boolean mostrarInclusoBorrados)
        {
            NHibernate.ICriteria query = session.CreateCriteria<Fichaje>();

            switch (mostrarInclusoBorrados)
            {
                case true:
                    break;

                case false:
                default:
                    query.Add(NHibernate.Criterion.Restrictions.Eq("Borrado", 0));
                    break;
            } // switch

            switch (tipoOrdenacion)
            {
                case "DESC":
                    query.AddOrder(NHibernate.Criterion.Order.Desc(campoAOrdenar));
                    break;

                case "ASC":
                default:
                    query.AddOrder(NHibernate.Criterion.Order.Asc(campoAOrdenar));
                    break;
            } // switch

            return query.List<Fichaje>();
        } // obtenerFichajes

        public static IList<Fichaje> obtenerFichajesEmpleado(NHibernate.ISession session, Int32 empleado, string campoAOrdenar, string tipoOrdenacion, Boolean mostrarInclusoBorrados)
        {
            NHibernate.ICriteria query = session.CreateCriteria<Fichaje>();
            query.Add(NHibernate.Criterion.Restrictions.Eq("Empleado", empleado));

            switch (mostrarInclusoBorrados)
            {
                case true:
                    break;

                case false:
                default:
                    query.Add(NHibernate.Criterion.Restrictions.Eq("Borrado", 0));
                    break;
            } // switch

            switch (tipoOrdenacion)
            {
                case "DESC":
                    query.AddOrder(NHibernate.Criterion.Order.Desc(campoAOrdenar));
                    break;

                case "ASC":
                default:
                    query.AddOrder(NHibernate.Criterion.Order.Asc(campoAOrdenar));
                    break;
            } // switch

            return query.List<Fichaje>();
        } // obtenerFichajes

        public static String eliminarFichaje(NHibernate.ISession session, Guid id)
        {
            String resultado = String.Empty;

            NHibernate.ITransaction tx = null;
            try
            {
                tx = session.BeginTransaction();

                Fichaje fichajeAEliminar = session.Get<Fichaje>(id);
                if (fichajeAEliminar != null)
                {
                    // borrado lógico
                    fichajeAEliminar.Borrado = 1;
                    session.SaveOrUpdate(fichajeAEliminar);
//                    session.Delete(fichajeAEliminar);

                    session.Flush();
                } // then

                tx.Commit();
            } // try
            catch (Exception ex)
            {
                resultado = ex.GetBaseException().ToString();

                try
                {
                    if (tx != null)
                    {
                        tx.Rollback();
                    } // then
                } // try
                catch (Exception e)
                {
                    resultado += " -- " + e.GetBaseException().ToString();
                } // catch
            } // catch

            return resultado;
        } // eliminarFichaje

        public static String deshacerBorrado(NHibernate.ISession session, Guid id)
        {
            String resultado = String.Empty;

            NHibernate.ITransaction tx = null;
            try
            {
                tx = session.BeginTransaction();

                Fichaje fichajeARecuperar = session.Get<Fichaje>(id);
                if (fichajeARecuperar != null)
                {
                    // borrado lógico
                    fichajeARecuperar.Borrado = 0;
                    session.SaveOrUpdate(fichajeARecuperar);
//                    session.Delete(fichajeAEliminar);

                    session.Flush();
                } // then

                tx.Commit();
            } // try
            catch (Exception ex)
            {
                resultado = ex.GetBaseException().ToString();

                try
                {
                    if (tx != null)
                    {
                        tx.Rollback();
                    } // then
                } // try
                catch (Exception e)
                {
                    resultado += " -- " + e.GetBaseException().ToString();
                } // catch
            } // catch

            return resultado;
        } // deshacerBorrado

        public static String modificarFichaje(NHibernate.ISession session, Guid id, Int32 empresa, Int32 empleado, DateTime fecha, String concepto, Int32 horas, Int32 minutos)
        {
            String resultado = String.Empty;

            NHibernate.ITransaction tx = null;
            try
            {
                tx = session.BeginTransaction();

                Fichaje fichajeAModificar = session.Get<Fichaje>(id);
                if (fichajeAModificar != null)
                {
                    fichajeAModificar.Empresa = empresa;
                    fichajeAModificar.Empleado = empleado;
                    fichajeAModificar.Fecha = fecha;
                    fichajeAModificar.Concepto = concepto;
                    fichajeAModificar.Horas = horas;
                    fichajeAModificar.Minutos = minutos;

                    session.SaveOrUpdate(fichajeAModificar);
                    session.Flush();
                } // then

                tx.Commit();
            } // try
            catch (Exception ex)
            {
                resultado = ex.GetBaseException().ToString();

                try
                {
                    if (tx != null)
                    {
                        tx.Rollback();
                    } // then
                } // try
                catch (Exception e)
                {
                    resultado += " -- " + e.GetBaseException().ToString();
                } // catch
            } // catch

            return resultado;
        } // modificarFichaje

        public static String altaFichaje(NHibernate.ISession session, Int32 empresa, Int32 empleado, DateTime fecha, String concepto, Int32 horas, Int32 minutos)
        {
            String resultado = String.Empty;

            NHibernate.ITransaction tx = null;
            try
            {
                tx = session.BeginTransaction();

                Fichaje nuevoFichaje = new Fichaje();
                nuevoFichaje.Empresa = empresa;
                nuevoFichaje.Empleado = empleado;
                nuevoFichaje.Fecha = fecha;
                nuevoFichaje.Concepto = concepto;
                nuevoFichaje.Horas = horas;
                nuevoFichaje.Minutos = minutos;

                session.Save(nuevoFichaje);
                session.Flush();

                tx.Commit();
            } // try
            catch (Exception ex)
            {
                resultado = ex.GetBaseException().ToString();

                try
                {
                    if (tx != null)
                    {
                        tx.Rollback();
                    } // then
                } // try
                catch (Exception e)
                {
                    resultado += " -- " + e.GetBaseException().ToString();
                } // catch
            } // catch

            return resultado;
        } // altaFichaje

        public static Boolean existeFichaje(NHibernate.ISession session, Int32 empleado, DateTime fecha)
        {
            Boolean resultado = false;

            NHibernate.ICriteria query = session.CreateCriteria<Fichaje>();
            query.Add(NHibernate.Criterion.Restrictions.Eq("Empleado", empleado));
            query.Add(NHibernate.Criterion.Restrictions.Eq("Fecha", fecha));
            query.Add(NHibernate.Criterion.Restrictions.Eq("Borrado", 0));

            if (query.List<Fichaje>().Count > 0)
            {
                resultado = true;
            } // then

            return resultado;
        } // existeFichaje

        public static Boolean tablaFichajesAccesible(NHibernate.ISession session)
        {
            Boolean resultado = false;

            NHibernate.ICriteria query = session.CreateCriteria<Fichaje>();
            query.SetProjection(NHibernate.Criterion.Projections.RowCount());

            try
            {
                Int32 total = Convert.ToInt32(query.UniqueResult());
                resultado = true;
            } // try
            catch (Exception ex)
            {
                resultado = false;
            } // catch

            return resultado;
        } // existeFichaje
    } // class
} // namespace
