using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ServiceProcess;
using System.Net.Mail;

namespace VerificacionEstadoServicios
{
    class Program
    {
        private static void enviarMail(string servidor, string servicio, string asunto, string mensaje)
        {
            MailMessage email = new MailMessage();
            email.To.Add(new MailAddress("desarrolloinformatico@einsa.com")); // 
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
                Console.WriteLine(output);
            } // catcg
        } // enviarMail

        static void Main(string[] args)
        {
            // parametros
            String servidor = Environment.MachineName;
            String servicio = String.Empty;
            double tiempoEspera = 60000; // 1 minuto

            if (
                (args == null) ||
                (args.Length < 2)
            )
            {
                Console.WriteLine("No se han especificado los parámetros adecuados: VerificacionEstadoServicio <SERVICIO> <MILISEGUNDOS_ESPERA_ARRANQUE>");
            } // then
            else
            {
                servicio = args[0];
                tiempoEspera = Double.Parse(args[1]);

                TimeSpan timeout = TimeSpan.FromMilliseconds(tiempoEspera);
                ServiceController sc = new ServiceController(servicio);
                //            Console.WriteLine("El servicio '{0}' de '{1}' está '{2}'", servicio, servidor, sc.Status.ToString());

                String mensaje = String.Empty;
                if (! sc.Status.Equals(ServiceControllerStatus.Running))
                {
                    System.Diagnostics.Process pStart = new System.Diagnostics.Process();

                    string ejecutable = @"C:\EINSA\apps\ArranqueDiarioAutoStore\ArranqueAutoStoreService.bat";
                    pStart.StartInfo = new System.Diagnostics.ProcessStartInfo(ejecutable);

                    try
                    {
                        pStart.Start();
                        pStart.WaitForExit(30000);

                        sc.Refresh();
                        if (! sc.Status.Equals(ServiceControllerStatus.Running))
                        {
                            mensaje += "Finalizó el proceso de arranque sin que el proceso haya arrancado correctamente. REVISAR!";
                            enviarMail(servidor, servicio, "Servicio '" + servicio + "' detenido en el servidor '" + servidor + "', se requiere intervención manual", "El servicio '" + servicio + "' de '" + servidor + "' está '" + sc.Status.ToString() + "', se requiere intervención manual para arrancarlo: " + mensaje);
                        } // then
                        else
                        {
                            enviarMail(servidor, servicio, "Servicio '" + servicio + "' se ha arrancado en el servidor '" + servidor + "' al encontrarlo parado", "El servicio '" + servicio + "' de '" + servidor + "' estaba parado y ha sido arrancado automáticamente");
                        } // else
                    } // try
                    catch (Exception e)
                    {
                        sc.Refresh();
                        if (! sc.Status.Equals(ServiceControllerStatus.Running))
                        {
                            mensaje += "Trató de arrancarse pero falló el proceso de arranque: " + e.InnerException;
                            enviarMail(servidor, servicio, "Servicio '" + servicio + "' detenido en el servidor '" + servidor + "', se requiere intervención manual", "El servicio '" + servicio + "' de '" + servidor + "' está '" + sc.Status.ToString() + "', se requiere intervención manual para arrancarlo: " + mensaje);
                        } // then
                    } // catch
                } // then
            } // else

//            Console.ReadLine();

            Environment.Exit(0);
        } // Main
    } // class
} // namespace
