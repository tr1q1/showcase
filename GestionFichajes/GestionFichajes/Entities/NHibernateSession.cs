using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using NHibernate;
using NHibernate.Cfg;

namespace GestionFichajes.Entities
{
    public class NHibernateSession
    {
        public static ISession AbrirBBDD()
        {
            ISession resultado = null;

            try
            {
                Configuration configuration = new Configuration().Configure();
                ISessionFactory sessionFactory = configuration.BuildSessionFactory();

                resultado = sessionFactory.OpenSession();
            } // try
            catch (Exception ex)
            {
                throw ex;
            } // catch 

            return resultado;
        } // AbrirBBDD

        public static void CerrarBBDD(ISession conexion)
        {
            try
            {
                conexion.Close();
            } // try
            catch (Exception ex)
            {
                throw ex;
            } // catch 
        } // CerrarBBDD
    } // class
} // namespace
