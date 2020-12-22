using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.IO;

namespace NotificacionErroresEscaneo
{
    class Program
    {
        private static void enviarMail(string servidor, string asunto, string mensaje)
        {
            MailMessage email = new MailMessage();
            email.To.Add(new MailAddress("desarrolloinformatico@einsa.com"));
            email.From = new MailAddress("desarrolloinformatico@einsa.com");
            email.Subject = asunto;
            email.Body = mensaje;
            email.IsBodyHtml = true;
            email.Priority = MailPriority.Normal;

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "172.17.1.250";
            smtp.Port = 25;
            smtp.EnableSsl = false;
            smtp.UseDefaultCredentials = false;

            string output = null;

            try
            {
                smtp.Send(email);
                email.Dispose();
                //                output = "Correo electrónico enviado satisfactoriamente.";
            } // try
            catch (Exception ex)
            {
                output = "Error enviando correo electrónico: " + ex.Message;
            } // catcg

            Console.WriteLine(output);
        } // enviarMail

        static void Main(string[] args)
        {
            // parametros
            String servidor = Environment.MachineName;
            String ruta = String.Empty;

            if (
                (args == null) ||
                (args.Length < 1)
            )
            {
                Console.WriteLine("No se han especificado los parámetros adecuados: VerificacionEstadoServicio <RUTA_LOGS_ERROR>");
            } // then
            else
            {
                ruta = args[0];

                try
                {
                    DirectoryInfo directory = new DirectoryInfo(ruta);
                    FileInfo[] files = directory.GetFiles("*.*"); // no debería haber ficheros, dado que al procesarlos deberiamos eliminarlos de dicha ruta

                    String mensaje = "Ha fallado el procesamiento de AutoStore, se requiere intervención manual: ";
                    if (files.Length > 0)
                    {
                        for (int i = 0; i < files.Length; i++)
                        {
                            mensaje += "<BR>&emsp;-&nbsp;" + (((FileInfo)files[i]).FullName);
                        } // for

                        enviarMail(servidor, "[ALERTA] Ha fallado el procesamiento de AutoStore de algún albarán", mensaje);
                    } // then
                } // try
                catch (Exception ex)
                {
                    Console.WriteLine(ex.ToString());
                } // catch
            } // else
        } // Main
    } // class
} // namespace
