using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Principal;
using System.Collections;

namespace GestionFichajes
{
    static class Program
    {
        #region Constantes

        private const string CTE_FICHERO_USUARIOS_AUTORIZADOS_FORZOSAMENTE = @"C:\apps\gf\gf_auth.users";

        #endregion Constantes

        #region Variables internas

        private static System.IntPtr identidadToken;
        private static string nameUser;

        #endregion Variables internas

        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // si existe el fichero de autorizaciones, se valida el usuario conectado contra la lista de usuarios del fichero
            ArrayList usuariosAutorizadosForzosamente = new ArrayList(0);
            if (System.IO.File.Exists(CTE_FICHERO_USUARIOS_AUTORIZADOS_FORZOSAMENTE))
            {
                IEnumerable<String> listaUsuarios = System.IO.File.ReadLines(CTE_FICHERO_USUARIOS_AUTORIZADOS_FORZOSAMENTE).ToList();

                if (
                    (listaUsuarios != null) &&
                    (listaUsuarios.Count() > 0)
                )
                {
                    usuariosAutorizadosForzosamente = new ArrayList(listaUsuarios.ToList());
                } // then
            } // then

            identidadToken = WindowsIdentity.GetCurrent().Token;
            nameUser = WindowsIdentity.GetCurrent().Name;

            if (
                (nameUser != @"EAN\cafreire") &&
                (nameUser != @"EAN\abprecedo") &&
                (nameUser != @"EAN\scaamano") &&
                (nameUser != @"EAN\eares") &&
                (!usuariosAutorizadosForzosamente.Contains(nameUser))
            )
            {
                MessageBox.Show("Usuario no autorizado a usar esta aplicación.", "ADVERTENCIA", MessageBoxButtons.OK);

                Application.Exit();
                return;
            } // then
            else
            {
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new fGestionFichajes(nameUser));
            } // else
        } // Main
    } // class
} // namespace
