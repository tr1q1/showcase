MandoWebTV
=================

Se trata de una aplicación Android nativa para poder reemplazar el mando que viene de serie con el WebTV de Blu:Sens (http://blusens.com/productos/webtv-w/)
________________________



Server Scripts
=================

Se tratan de una serie de scripts (bash, python) básicos para la gestión de un servidor Linux casero:
  - Firewall
  - Control de dispositivos no conocidos conectados a la red local
  - Sistema de backup de todos los servicios del servidor 
  - Verificación del estado de la conexión del servidor
  - Actualización del cambio de IP tanto en DynDNS como en No-IP
  - Sincronización de listas de canciones con distintos dispositivos en la red local (para su utilización en modo off-line)
  - Control de permisos sobre los ficheros compartidos en la red interna entre los distintos dispositivos
  - Obtención de estadísticas de follows/unfollows a cuentas específicas de Twitter
  - Obtención de listados de los archivos multimedia disponibles agrupados por tipo (Audio, Video, Libro)
  - Conversión desde distintos formatos (WMA, M4A, FLAC, WAV, MP4, ) a MP3
  - Scripts para realizar distintos tipos de notificaciones: Telegram, Twitter, EMail
  - Script para la verificación del estado de la pantalla conectada, alertando en caso de que la pantalla se apague y recuperando la configuración de pantalla una vez que se vuelva a conectar
  - Script para la invocación del servicio de Gotham para que se procesen las notificaciones pendientes de enviar
  - Script para la verificación del tiempo de respuesta de una lista de máquinas (por IP). Si alguna no responde en 10 sg se solicitará a Gotham el envío de una alerta grave (vía SMS) con la incidencia. Si alguna de las máquinas responde en más tiempo del parametrizado se solicitará a Gotham el envío de una notificación (vía email) con la situación
  - Script para la verificación del estado en ejecución de un proceso concreto y, en caso de que no esté en ejecución, se arranca el proceso.

________________________



ACTP - Asistente Científico-Técnico Personal
=================

Se trata de una aplicación de escritorio realizada con OCamlTK emulando una CASIO fx-6300G

____________________________________________



SignBoard
=================

Se trata de una aplicación web de gestión de anuncios realizada:
  - Cliente: AngularJS + BootStrap
  - Servidor: Apache + Flask + Python + MySQL

________________________



GeAl
=================

Se trata de una aplicación .NET Windows Forms sobre una BBDD MySQL para la Gestión de Almacenes

________________________



JavaClientSMSGateway / PythonClientSMSGateway
=================

Se trata de dos clientes, uno Java usando Apache HttpClient y otro Python, para el envío de SMS por medio de un SMS Gateway.

________________________


Gotham <B><I>-- (en desarrollo) --</I></B>
=================

Se trata de un ERP J2EE basado en Spring 4.2.1 exponiendo las distinta funcionalidad por medio de servicios REST.

En esta versión inicial sólo se incluye un módulo de registro de Alertas/Notificaciones que se remitirán a distintos destinatarios por distintos canales en función de la Criticidad y/o Prioridad de la Alerta/Notificación correspondiente.
Se añade un nuevo servicio de negocio para la obtención de estadísticas, globales o diarias, de envío de notificaciones/alertas por los distintos canales.

El módulo encargado de procesar las Alertas/Notificaciones registradas las remitirá por los siguientes canales (de más a menos crítico/prioritario):
  - SMS
  - Telegram
  - EMail
  - Twitter

Se trata de un servicio de negocio más de la aplicación, que es invocado desde un cliente Java planificado en el crontab para ser ejecutado cada minuto.


Se incluye un cliente Java, <I><B>gotham-cl-registro</B></I>, ejecutable directamente, para la invocación al servicio REST de registro de Alertas/Notificaciones.


Se incluye un cliente Java, <I><B>gotham-cl-procesar</B></I>, ejecutable directamente, para la invocación al servicio REST de procesamiento/envío de Alertas/Notificaciones. Este cliente será el que se planifique para ser ejecutado cada minuto.

________________________


SMS Gateway
=================

Se trata de un gateway para el envío de SMSs desde cualquier móvil Android, expuesto por medio de servicios REST. Aplicación nativa Android compatible desde la versión 16 del SDK de Android (4.1 Jelly Bean).

________________________


Gestión de Fichajes
=================

Se trata de una aplicación .NET Windows Forms simple, para la gestión e importación de los fichajes realizados por los empleados a través de la máquina lectora de tarjetas al sistema Epsilon de RRHH.

________________________


MLARCH
=================

Proyecto formado por distintos componentes todos basados en Spring Boot (JMS Listeners, REST APIs, Scheduled Tasks...) de Arquitectura ML para recomendación y categorización de usuarios de Webs o Apps según su navegación: ActiveMQ, Elastic Seacrh, REST API, Apache Spark, MongoDB.

* navrec: Componente encargado de ingestar en ES los clicks remitidos desde las Webs/Apps por medio de mensajes en colas AMQ.
* mlws: Componente encargado de exponer los resultados de las recomendaciones y categorización de los usuarios, así cómo obtener distintas estadísticas de los datos ingestados.

________________________
