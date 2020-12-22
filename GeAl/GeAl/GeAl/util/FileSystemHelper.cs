using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GeAl.util
{
    class FileSystemHelper
    {
        #region Constantes

        public const string CTE_GeAl_CONFIG = @"C:\geal\conf\geal.properties";

        #endregion

        #region Variables de clase

        private static Dictionary<string, Dictionary<string, string>> configuracion = new Dictionary<string, Dictionary<string, string>>(0);

        #endregion

        public static Dictionary<string, string> ReadDictionaryFile()
        {
            return ReadDictionaryFile(CTE_GeAl_CONFIG);
        } // ReadDictionaryFile

        /// <summary>
        /// Se devuelve un Dictionary con todas las properties definidas en el fichero de configuracion proporcionado
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns>Dictionary con todas las properties</returns>
        public static Dictionary<string, string> ReadDictionaryFile(string fileName)
        {
            if (
                (0 >= configuracion.Count) ||
                (! configuracion.ContainsKey(fileName)) ||
                (0 >= configuracion[fileName].Count)
            )
            {
                Dictionary<string, string> propiedades = new Dictionary<string, string>(0);
                foreach (string line in System.IO.File.ReadAllLines(fileName))
                {
                    if (
                        (!string.IsNullOrEmpty(line)) &&
                        (!line.StartsWith(";")) &&
                        (!line.StartsWith("#")) &&
                        (!line.StartsWith("'")) &&
                        (line.Contains('='))
                    )
                    {
                        int index = line.IndexOf('=');
                        string key = line.Substring(0, index).Trim();
                        string value = line.Substring(index + 1).Trim();

                        if (
                            (value.StartsWith("\"") && value.EndsWith("\"")) ||
                            (value.StartsWith("'") && value.EndsWith("'"))
                        )
                        {
                            value = value.Substring(1, value.Length - 2);
                        } // then

                        propiedades.Add(key, value);
                    } // then
                } // foreach

                configuracion.Add(fileName, propiedades);
            } // then

            return configuracion[fileName];
        } // ReadDictionaryFile

        public static String GetValueFromConfig(string property)
        {
            return GetValueFromConfig(CTE_GeAl_CONFIG, property);
        } // GetValueFromConfig

        /// <summary>
        /// Se devuelve el valor de la propiedad especificada del fichero de configuracion proporcionado
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="property"></param>
        /// <returns>Valor de la propiedad especificada</returns>
        public static String GetValueFromConfig(string filename, string property)
        {
            string valorPropiedad = String.Empty;
            Dictionary<string, string> propiedades = ReadDictionaryFile(filename);

            propiedades.TryGetValue(property, out valorPropiedad); // si existe la propiedad devolvera el valor que tenga, si no existe seguira vacia la variable intermedia

            return valorPropiedad;
        } // GetValueFromConfig
    }
}
