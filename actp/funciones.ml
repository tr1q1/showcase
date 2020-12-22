open Tk;;
open Definiciones;;
open Funciones_comunes;;

(*INI	funciones de control y manejo de operaciones (A) *)
let es_entero =
(*
objectivo:
	se le pasa como parametro un STRING con un valor y se devuelve un BOOL, si el valor es entero
	se devuelve TRUE y si el valor no es entero o no es numero se devuelve FALSE
	Ej.
	"2.1"	->	TRUE
	"2"	->	FALSE
	""	->	FALSE
	"ACTP"	->	FALSE
*)
	function valor ->
		try
			if (valor = "") then
				false
			else ((float_of_int (int_of_float (float_of_string valor))) = (float_of_string valor))
		with _ -> false
;; (* function es_entero string -> bool *)

let parte_entera = function valor ->
(*
objectivo:
	se le pasa como parametro un STRING con un valor, si el valor es un numero (real o entero)
	se devuelve un STRING con su parte entera y, en otro caso, se devuelve el STRIN "0"
	Ej.
	"2.1"	->	"2"
	"2"	->	"2"
	""	->	"0"
	"ACTP"	->	"0"
*)
	try
		string_of_float (floor (float_of_string valor));
	with _ -> "0"
;; (* function parte_entera string -> string *)

let parte_real = function valor ->
(*
objectivo:
	se le pasa como parametro un STRING con un valor, si el valor es un numero (real o entero)
	se devuelve un STRING con su parte real y, en otro caso, se devuelve el STRIN "0.0"
	Ej.
	"2.1"	->	"0.1"
	"2"	->	"2"
	""	->	"0"
	"ACTP"	->	"0"
*)
	let valor_aux = ref 0.0 in
	try
		valor_aux := (float_of_string valor);
		valor_aux := !valor_aux -. (floor !valor_aux);

		string_of_float !valor_aux
	with _ -> "0.0"
;; (* function parte_real string -> string *)

let es_memoria =
(*
objectivo:
	se le pasa como parametro un STRING con un valor, si el valor equivale a una de las memorias de
	la calculadora se devuelve TRUE, en otro caso se devuelve FALSE
*)
	function comando ->
		match (String.sub comando 0 1) with
		  "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M"
		| "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z"	-> true
		| _	-> false
;; (* function string -> bool *)

let obtener_contenido =
(*
objectivo:
	se pasa como parametro un OBJECTO y se devuleve un STRING
	con el valor actual del objecto
*)
	function objecto ->
		try
			List.hd objecto.contenido
		with _ -> ""
;; (* function obtener_contenido objecto -> string *)

let formatear_salida =
(*
objectivo:
	se pasa como parametro un STRING con el modo de funcionamiento actual de la calculadora y
	otro STRING con el resultado de la operacion ejecutada.
*)
	function resultado ->
		if ((es_entero (resultado)) = true) then
			resultado
		else begin
			try
				let aux = ref "" in
				let decimales = ref (int_of_string !numero_decimales) in
				aux := !aux ^ (String.sub resultado 0 ((String.index resultado '.') + 1));

				if (((String.length resultado) - (String.length !aux)) < !decimales) then
					aux := resultado
				else aux := !aux ^ (String.sub resultado ((String.index resultado '.') + 1) !decimales);

				!aux
			with _ -> resultado
		end (* else *)
;; (* function formatear_salida string * string -> string *)

let interpretar_valor =
(*
objectivo:
	se le pasa como parametro un STRING con un valor (comando), si el valor equivale a la funcion "e"
	de la calculadora entonces se devuelve un STRING con el valor "x10e" que equivale a un comando
	valido equivalente al dado para el parseador de operaciones, en otro caso se devuelve el mismo
	valor (comando) pasado
*)
	function valor ->
		if ((es_memoria valor) = true) then
			Funciones_comunes.obtener_valor_memoria valor
		else begin
			match valor with
		  	"e"	-> "x10e"
			| "r"	-> begin
			  	if (!conversiones = 1) then
				begin
					match (obtener_contenido modo_funcionamiento) with
					  "1"
					| "4" -> "dr"
					| "5" -> "rr"
					| "6" -> "gr"
					| _ -> valor
				end
				else valor
			end
			| "d"	-> begin
			  	if (!conversiones = 1) then
				begin
					match (obtener_contenido modo_funcionamiento) with
					  "1"
					| "4" -> "dd"
					| "5" -> "rd"
					| "6" -> "gd"
					| _ -> valor
				end
				else valor
			end
			| "g"	-> begin
			  	if (!conversiones = 1) then
				begin
					match (obtener_contenido modo_funcionamiento) with
					  "1"
					| "4" -> "dg"
					| "5" -> "rg"
					| "6" -> "gg"
					| _ -> valor
				end
				else valor
			end
			| _ 	-> valor
		end (* else *)
;; (* function interpretar_valor string -> string *)

let obtener_expresion_valor =
(*
objectivo:
	se le pasa como parametro un STRING con un valor (comando) en formato de la calculadora y se
	devuelve un STRING con el mismo comando en formato del parser del ACTP.
	Ej.
	"23.45e-10"	 ->	"23.45x10e-10"
	"2+3"		->	"2+3"
*)
	function valor ->
		let aux = ref "" in
		let anterior = ref "" in
		let indice = ref 0 in

		if (((String.length valor) - 1) >= 0) then
		begin
			while (!indice < (String.length valor)) do
				if (((String.sub valor !indice 1) = "X") && (es_entero !anterior)) then
					aux := !aux ^ "xX"
				else if ((!anterior = "X") && (es_entero (String.sub valor !indice 1))) then
					aux := !aux ^ "x" ^ (interpretar_valor (String.sub valor !indice 1))
				else if (((es_memoria (String.sub valor !indice 1)) = true) && ((!indice + 1) < (String.length valor)) && ((es_entero (String.sub valor (!indice + 1) 1)) = true)) then
				begin
					let valor_aux = ref (String.sub valor !indice 1) in
					while (((!indice + 1) < (String.length valor)) && ((es_entero (String.sub valor (!indice + 1) 1)) = true)) do
						valor_aux := !valor_aux ^ (String.sub valor (!indice + 1) 1);
						indice := !indice + 1;
					done; (* while *)
					
					aux := !aux ^ (interpretar_valor !valor_aux);
				end (* else if .. then *)
				else aux := !aux ^ (interpretar_valor (String.sub valor !indice 1));

				anterior := (String.sub valor !indice 1);
				
				indice := !indice + 1;
			done; (* while *)
		end; (* then *)

		!aux;
;; (* obtener_expresion_valor string -> string *)

let obtener_valor_fichero =
(*
objectivo:
	se le pasa como parametro un STRING con un nombre de fichero, se devuelve un STRING con el
	contenido del fichero. En caso de que no exista el fichero se devuelve ""
*)
	function fichero ->
		if (Sys.file_exists (ruta_local ^ fichero ^ tipo_ficheros_datos)) then
			try
				let id_fichero = open_in (ruta_local ^ fichero ^ tipo_ficheros_datos) in
				let anterior = input_line id_fichero in
					close_in id_fichero;
					obtener_expresion_valor anterior;
			with End_of_file -> ""
		else fichero
;; (* function obtener_valor_fichero string -> string *)

let interpretar_comando =
(*
objectivo:
	se pasa como parametro un STRING con la ultima tecla pulsada por el usuario,
	se devuelve otro STRING con el valor correspondiente a la tecla pulsada
*)
	function comando ->
(*		if ((es_memoria comando) && (!modo_programacion = 0)) then
			obtener_valor_fichero comando
		else*)
			match comando with
			  "Ans" -> obtener_valor_fichero fichero_ultimo_resultado
			| "x-¹"		-> "-¹"
			| _		-> comando
;; (* function interpretar_comando string -> string *)

let interpretar_operacion =
(*
objectivo:
	(la inversa de la anterior)
	se pasa como parametro un STRING con el valor de una tecla y se devuelve un STRING
	con la tecla correspondiente
*)
	function operacion ->
		match operacion with
		  "-¹"		-> "x-¹"
		| _		-> operacion
;; (* function interpretar_operacion string -> string *)

let limpiar_grafica =
(*
objectivo:
	borrar las graficas representadas anteriormente
*)
	function (contenedor, grafica) ->
		for indice=1 to (List.length grafica.segmentos) do
			Canvas.delete contenedor [List.nth grafica.segmentos indice]
		done; (* for *)
		grafica.segmentos <- [];
		grafica.puntos <- [];
		grafica.en_pantalla <- false;
		grafica.existe <- false;
		if ((Sys.file_exists (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos)) && (Sys.file_exists (ruta_local ^ grafica.fichero_y ^ tipo_ficheros_datos))) then
		begin
			Sys.remove (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos);
			Sys.remove (ruta_local ^ grafica.fichero_y ^ tipo_ficheros_datos);
		end (* then *)
		else ();

		"done"
;; (* function limpiar_grafica widget * grafica -> string *)

let estaModoGrafico =
(*
objetivo:
	comprobar si el asistente esta dibujando alguna grafica
*)
	function () ->
		((eje_x.en_pantalla = true) && (eje_y.en_pantalla = true))
;; (* function estaModoGrafico unit -> bool *)

let existeGrafica =
(*
objectivo:
	comprobar si ya se habia generado una grafica anteriormente.
*)
	function grafica ->
		(grafica.puntos <> [])
;; (* function existeGrafica grafica -> bool *)

let rec dibujar_grafica =
(*
objectivo:
	se pasa como parametro una grafica a la que ya se le han generado los puntos por los que pasa
	y se representa en pantalla
*)
	function (lista_puntos, contenedor) ->
		match lista_puntos with
		  []		-> []
 		| h::[]		-> begin
			if ((fst h) > !grafica_max) then
				[(Canvas.create_line contenedor [(Millimeters !grafica_max); (Millimeters (snd h)); (Millimeters !grafica_max); (Millimeters (snd h))] [])]
			else [(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters (fst h)); (Millimeters (snd h))] [])]
		end
		| h::t::[]	-> begin
			if ((fst h) > !grafica_max) then
			begin
				if ((fst t) > !grafica_max) then
					[]
				else [(Canvas.create_line contenedor [(Millimeters !grafica_max); (Millimeters (snd h)); (Millimeters (fst t)); (Millimeters (snd t))] [])]
			end (* then *)
			else begin
				if ((fst t) > !grafica_max) then
					[(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters !grafica_max); (Millimeters (snd t))] [])]
				else [(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters (fst t)); (Millimeters (snd t))] [])]
			end (* else *)
		end
		| h::m::t	-> begin
			if ((fst h) > !grafica_max) then
			begin
				if ((fst m) > !grafica_max) then
					[] @ (dibujar_grafica (m::t, contenedor))
				else [(Canvas.create_line contenedor [(Millimeters !grafica_max); (Millimeters (snd h)); (Millimeters (fst m)); (Millimeters (snd m))] [])] @ (dibujar_grafica (m::t, contenedor))
			end (* then *)
			else begin
				if ((fst m) > !grafica_max) then
					[(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters (fst h)); (Millimeters (snd h))] [])] @ (dibujar_grafica (m::t, contenedor))
				else [(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters (fst m)); (Millimeters (snd m))] [])] @ (dibujar_grafica (m::t, contenedor))
			end (* else *)
		end
;; (* dibujar_grafica float * float list -> Tk.tagOrId *)

let ocultarGraficas =
(*
objectivo:
	borrar las graficas representadas anteriormente
*)
	function (contenedor, grafica) ->
		if (grafica.en_pantalla = true) then
		begin
			for indice=0 to ((List.length grafica.segmentos) - 1) do
				Canvas.delete contenedor [List.nth grafica.segmentos indice]
			done; (* for *)

			grafica.segmentos <- [];
			grafica.en_pantalla <- false;
		end
		else ()
;; (* function ocultarGraficas widget -> string *)

let ocultarGraficaBarras =
(*
objectivo:
	borrar las graficas representadas anteriormente
*)
	function contenedor ->
		if (grafica_barras.en_pantalla = true) then
		begin
			for indice=0 to ((List.length grafica_barras.segmentos) - 1) do
				Canvas.delete contenedor [List.nth grafica_barras.segmentos indice]
			done; (* for *)

			grafica_barras.segmentos <- [];
			grafica_barras.en_pantalla <- false;
		end
		else ()
;; (* function ocultarGraficas widget -> string *)

let modulo =
(*
objetivo:
	realizar la operacion mod para valores float
*)
	function (valor, valor_modulo) ->
		valor -. (valor_modulo *. (float_of_string (parte_entera (string_of_float (valor /. valor_modulo)))))
;; (* function modulo float -> float *)

let valor_absoluto =
	function valor ->
		if (valor < 0.0) then
			(-1.0) *. valor
		else valor
;; (* function valor_absoluto float -> float *)

let adaptar_valor_x =
(*
objetivo:
	se trata de adaptar los distintos valores obtenidos para la representacion grafica a la pantalla del a.c.t.p.
	valores validos 0..30
*)
	function valor ->
		if (valor = !xmin) then
			!grafica_min
		else if (valor = !xmax) then
			!grafica_max
		else begin
			if (valor < 0.0) then
				(!grafica_max /. 2.0) -. (valor_absoluto (valor /. !xscl)) *. !grafica_xscl
			else (!grafica_max /. 2.0) +. (valor_absoluto (valor /. !xscl)) *. !grafica_xscl
		end (* else *)
;; (* function adaptar_valor_x float -> float*)

let adaptar_valor_y =
(*
objetivo:
	se trata de adaptar los distintos valores obtenidos para la representacion grafica a la pantalla del a.c.t.p.
	valores validos 10..110
*)
	function valor ->
		if (valor = !ymin) then
			!grafica_max
		else if (valor = !ymax) then
			!grafica_min
		else begin
			if (valor < 0.0) then
				(!grafica_max /. 2.0) +. (valor_absoluto (valor /. !yscl)) *. !grafica_yscl
			else (!grafica_max /. 2.0) -. (valor_absoluto (valor /. !yscl)) *. !grafica_yscl
		end; (* else *)
;; (* function adaptar_valor_y float -> float *)

let aplicarZoom =
(*
objectivo:
	se trata de aplicar el nuevo valor del zoom a los valores de las graficas
*)
	function valor ->
		if (!grafica_zoomx > 1.0) then
		begin
			if (!grafica_zoomy > 1.0) then
				(((fst valor) *. !grafica_zoomx) -. (!grafica_max /. 2.0), ((snd valor) *. !grafica_zoomy) -. (!grafica_max /. 2.0))
			else (((fst valor) *. !grafica_zoomx) -. (!grafica_max /. 2.0), (snd valor) *. !grafica_zoomy)
		end (* then *)
		else if (!grafica_zoomy > 1.0) then
		begin
			if (!grafica_zoomx > 1.0) then
				(((fst valor) *. !grafica_zoomx) -. (!grafica_max /. 2.0), ((snd valor) *. !grafica_zoomy) -. (!grafica_max /. 2.0))
			else ((fst valor) *. !grafica_zoomx, ((snd valor) *. !grafica_zoomy) -. (!grafica_max /. 2.0))
		end (* else *)
		else ((fst valor) *. !grafica_zoomx, (snd valor) *. !grafica_zoomy)
;; (* function aplicarZoom *)

let aplicarDesplazamiento =
(*
objectivo:
	se trata de aplicar el desplazamiento (arriba, abajo, izquierda, derecha) en la representacion de graficas
*)
	function valor ->
		match !tipo_desplazamiento with
		  1	-> (fst valor, (snd valor) +. longitud_desplazamiento) (* desplazamiento hacia abajo *)
		| 2	-> (fst valor, (snd valor) -. longitud_desplazamiento) (* desplazamiento hacia arriba *)
		| 3	-> ((fst valor) +. longitud_desplazamiento, snd valor) (* desplazamiento hacia derecha *)
		| 4	-> ((fst valor) -. longitud_desplazamiento, snd valor) (* desplazamiento hacia izquierda *)
		| _	-> valor
;; (* function aplicarDesplazamiento *)

let mostrarEjes =
(*
objectivo:
	se trata de mostrar los ejes de coordenadas antes de generar las graficas
*)
	function contenedor ->
		eje_x.puntos <- [((!grafica_min -. !grafica_max), (!grafica_max /. 2.0)); ((2.0 *. !grafica_max), (!grafica_max /. 2.0))];
		eje_y.puntos <- [((!grafica_max /. 2.0), (!grafica_min -. !grafica_max)); ((!grafica_max /. 2.0), (2.0 *. !grafica_max))];

		if ((existeGrafica eje_x) = true) then
		begin
			eje_x.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom eje_x.puntos)), contenedor);
			eje_x.existe <- true;
			eje_x.en_pantalla <- true;
		end; (* then *)

		if ((existeGrafica eje_y) = true) then
		begin
			eje_y.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom eje_y.puntos)), contenedor);
			eje_y.existe <- true;
			eje_y.en_pantalla <- true;
		end; (* then *)
;; (* function mostrarEjes widget -> unit *)

let ocultarEjes =
(*
objectivo:
	se trata de ocultar los ejes de coordenadas antes de generar las graficas
*)
	function contenedor ->
		if (eje_x.en_pantalla = true) then
		begin
			for indice=0 to ((List.length eje_x.segmentos) - 1) do
				Canvas.delete contenedor [List.nth eje_x.segmentos indice]
			done; (* for *)
			eje_x.segmentos <- [];
			eje_x.en_pantalla <- false;
		end;

		if (eje_y.en_pantalla = true) then
		begin
			for indice=0 to ((List.length eje_y.segmentos) - 1) do
				Canvas.delete contenedor [List.nth eje_y.segmentos indice]
			done; (* for *)
			eje_y.segmentos <- [];
			eje_y.en_pantalla <- false;
		end;
;; (* function ocultarEjes widget -> unit *)

let cargarGrafica =
(*
objectivo:
	cargar los datos de graficas dibujadas anteriormente y almacenadas en ficheros
*)
	function grafica ->
		if ((Sys.file_exists (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos)) &&  (Sys.file_exists (ruta_local ^ grafica.fichero_y ^ tipo_ficheros_datos))) then
		begin
			let id_fichero_x = open_in (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos) in
			let id_fichero_y = open_in (ruta_local ^ grafica.fichero_y ^ tipo_ficheros_datos) in
				let seguir = ref true in
				while (!seguir = true) do
					try
						let valor_x = input_line id_fichero_x in
						let valor_y = input_line id_fichero_y in
							grafica.puntos <- grafica.puntos @ [((float_of_string valor_x), (float_of_string valor_y))];
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;
				close_in id_fichero_y;
		end (* then *)
		else ();
;; (* function cargarGrafica grafica -> unit *)

let repintarGraficas =
(*
objetivo:
	cumplir el caso de cambiar de modo grafico a texto, y viceversa. Tecla G<->T.
	Ademas es en esta funcion donde se aplicara el ZOOM
*)
	function contenedor ->
		mostrarEjes contenedor;

		if (((existeGrafica grafica_A) = true) && (grafica_A.en_pantalla = false)) then
		begin
			grafica_A.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom grafica_A.puntos)), contenedor);
			grafica_A.en_pantalla <- true;
		end; (* then *)

		if (((existeGrafica grafica_B) = true) && (grafica_B.en_pantalla = false)) then
		begin
			grafica_B.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom grafica_B.puntos)), contenedor);
			grafica_B.en_pantalla <- true;
		end; (* then *)

		if (((existeGrafica grafica_C) = true) && (grafica_C.en_pantalla = false)) then
		begin
			grafica_C.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom grafica_C.puntos)), contenedor);
			grafica_C.en_pantalla <- true;
		end (* then *)
;; (* function repintarGraficas widget -> unit *)

let aumentar_zoom =
(*
*)
	function () ->
		if (!xfact < 0.0) then
			grafica_zoomx := 1.0
		else grafica_zoomx := !grafica_zoomx *. !xfact;

		if (!yfact < 0.0) then
			grafica_zoomy := 1.0
		else grafica_zoomy := !grafica_zoomy *. !yfact;
;; (* function aumentar_zoom unit -> unit *)

let disminuir_zoom =
(*
*)
	function () ->
		if (!xfact < 1.0) then
			grafica_zoomx := 1.0
		else grafica_zoomx := !grafica_zoomx /. !xfact;

		if (!yfact < 1.0) then
			grafica_zoomy := 1.0
		else grafica_zoomy := !grafica_zoomy /. !yfact;
;; (* function disminuir_zoom unit -> unit *)

let almacenarGrafica =
(*
objectivo:
*)
	function grafica ->
		if ((existeGrafica grafica) = true) then
		begin
			if ((Sys.file_exists (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos)) && (Sys.file_exists (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos))) then
			begin
				let id_fichero_x = open_out_gen [Open_wronly] 700 (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos) in
				let id_fichero_y = open_out_gen [Open_wronly] 700 (ruta_local ^ grafica.fichero_y ^ tipo_ficheros_datos) in

					for indice=0 to ((List.length grafica.puntos) - 1) do
						output_string id_fichero_x ((string_of_float (fst (List.nth grafica.puntos indice))) ^ "\n");
						flush id_fichero_x;

						output_string id_fichero_y ((string_of_float (snd (List.nth grafica.puntos indice))) ^ "\n");
						flush id_fichero_y;
					done; (* for *)
					close_out id_fichero_x;
					close_out id_fichero_y;
			end (* then *)
			else begin
				let id_fichero_x = open_out (ruta_local ^ grafica.fichero_x ^ tipo_ficheros_datos) in
				let id_fichero_y = open_out (ruta_local ^ grafica.fichero_y ^ tipo_ficheros_datos) in

					for indice=0 to ((List.length grafica.puntos) - 1) do
						output_string id_fichero_x ((string_of_float (fst (List.nth grafica.puntos indice))) ^ "\n");
						flush id_fichero_x;

						output_string id_fichero_y ((string_of_float (snd (List.nth grafica.puntos indice))) ^ "\n");
						flush id_fichero_y;
					done; (* for *)
					close_out id_fichero_x;
					close_out id_fichero_y;
			end (* else *)
		end (* then *)
		else ()
;; (* function almacenarGrafica grafica -> unit *)

let rec formar_comando =
(*
objectivo:
	se pasa como parametro un STRING LIST con el comando actual y se
	devuelve un STRING con el comando actual (para ejecutarse o para
	mostrarse en pantalla)
	Ej.
	["2"; "+"; "3"]	->	"2+3"
*)
	function comando ->
		match comando with
		  [] -> ""
		| h::t -> h ^ (formar_comando t)
;; (* function rec formar_comando string list -> string *)

let existeOperacion =
(*
objectivo:
	se trata de comprobar si existe una determinada operacion en el comando a ejecutar
*)
	function (comando, operacion) ->
		let existe x = if (x = operacion) then true else false in
		List.exists existe comando
;; (* function existeOperacion string list * string -> bool*)

let ejecutarCalculo = 
(*
objectivo:
	se trata de realizar el calculo de una operacion solicitada por el usuario
*)
	function calculo ->
(*		salida_por_pantalla (formar_comando calculo);
		salida_por_pantalla (obtener_expresion_valor (formar_comando calculo)); *)
		let resultado = ref "" in
		let comando_ejecutar = ref ((obtener_expresion_valor (formar_comando calculo)) ^ "\n") in
		try
			let command = Lexing.from_string (!comando_ejecutar) in
			let result = Parser.main Lexer.token command in
				resultado := (string_of_float result);
			if (!resultado = "nan") then
				"Error de rango"
			else if (!resultado = "inf") then
				"infinito"
			else !resultado
		with
		  	Lexer.Eof	-> "Syntax Error"
			| _		-> "Error"	
;; (* function ejecutarCalculo string_list -> string *)

let obtenerIndiceMemoriaMatricial = 
(*
objectivo:
	se trata de obtener el valor del indice dentro de un programa para una memoria matricial
*)
	function (programa, memoria) ->
		let indice = ref 0 in
		let encontrado = ref false in
		let indice_matricial = ref [] in
		
		while (!indice < (List.length programa))  do
			if (((List.nth programa !indice) = memoria) && ((List.nth programa (!indice + 1)) = "[")) then
			begin
				encontrado := true;
				indice := !indice + 2;
			end (* then *)
			else if ((List.nth programa !indice) = "]") then
				encontrado := false;
				
			if (!encontrado = true) then
				indice_matricial := !indice_matricial @ [(List.nth programa !indice)];
			
			indice := !indice + 1;
		done; (* while *)
		
		!indice_matricial
;; (* function obtenerIndiceMemoriaMatricial string list -> string list *)

let obtenerComandoMemoriaMatricial =
(*
objectivo:
	se trata de asignar el valor resultado de la ejecucion de un programa a la operacion en la que se incluyo
*)
	function comando ->
		let indice = ref 0 in
		let comando_aux = ref [] in
		let memoria = ref "" in
		let encontrado = ref false in
		
		while (!indice < (List.length comando)) do
			if (((es_memoria (List.nth comando !indice)) = true) && ((List.nth comando (!indice + 1)) = "[")) then
			begin
				memoria := ((List.nth comando !indice) ^ (ejecutarCalculo (obtenerIndiceMemoriaMatricial (comando, (List.nth comando !indice)))));
				
				encontrado := true;		
				while ((List.nth comando !indice) <> "]") do
					indice := !indice + 1;
				done; (* while *)
			end (* then *)
			else encontrado := false;
			
			if (!encontrado = false) then
				comando_aux := !comando_aux @ [(List.nth comando !indice)]
			else if (!encontrado = true) then
				comando_aux := !comando_aux @ [!memoria];
				
			indice := !indice + 1;
		done; (* for *)
		
		!comando_aux
;; (* function obtenerComandoMemoriaMatricial string list -> string list*)

let rec ejecutar_comando =
(*
objectivo:
	se pasa como parametro un STRING con el modo de funcionamiento actual de la calculadora
	y otro STRING con un comando (en el formato adecuado para el parser). Se devuelve el
	resultado de ejecutar el comando en el modo de operacion indicado.
*)
	function (contenedor, comando) ->
		if (((List.length comando) = 0) || ((String.length (formar_comando comando)) = 0)) then
			"0"
		else begin
			if ((List.hd comando) = "Cls") then
			begin
				grafica_xscl := 1.0;
				grafica_yscl := 1.0;
				grafica_zoomx := 1.0;
				grafica_zoomy := 1.0;
				tipo_desplazamiento := 0; (* 1, 2, 3, 4*)

				let aux = ref "" in
				aux := limpiar_grafica (contenedor, grafica_A);
				aux := limpiar_grafica (contenedor, grafica_B);
				aux := limpiar_grafica (contenedor, grafica_C);

				!aux
			end (* then *)
			else if ((existeOperacion (comando, "->")) = true) then
			begin
				let indice = ref 0 in
				let encontrado = ref false in
				let comando_actual_aux = ref [] in
				
				while (!encontrado = false) do
					if ((List.nth comando !indice) = "->") then
						encontrado := true
					else begin
						comando_actual_aux := !comando_actual_aux @ [(List.nth comando !indice)];
						
						indice := !indice + 1;
					end (* else *)
				done; (* while *)
				
				let resultado = ejecutarCalculo !comando_actual_aux in
				if ((!indice + 1) = ((List.length comando) - 1)) && ((existeOperacion (comando, "[")) = false) then
					Funciones_comunes.guardar_operacion (resultado, (List.nth comando (!indice + 1)))
				else begin									
					comando_actual_aux := (obtenerIndiceMemoriaMatricial (comando, (List.nth comando (!indice + 1))));
				
					let memoria = ((List.nth comando (!indice + 1)) ^ (ejecutar_comando (contenedor, !comando_actual_aux))) in
					Funciones_comunes.guardar_operacion (resultado, memoria)					
				end; (* else *)
				
				resultado
			end (* else if .. then *)
			else if ((existeOperacion (comando, "[")) = true) then
				ejecutarCalculo (obtenerComandoMemoriaMatricial comando)
			else ejecutarCalculo comando
		end (* else *)
;; (* function ejecutar_comando widget * string list -> string *)

let asignar_valor_x =
(*
objectivo:
	se pasa como parametro un STRING con un comando (funcion) a representar graficamente y se sustituyen las
	ocurrencias de X por el valor FLOAT que se pasa por parametro.
*)
	function (funcion, valor_x) ->
		let indice = ref 0 in
		let aux = ref "" in

		while (!indice <= ((String.length funcion) - 1)) do
			if ((String.get funcion !indice) = 'X') then
				aux := !aux ^ valor_x
			else aux := !aux ^ (String.make 1 (String.get funcion !indice));

			indice := !indice + 1;
		done;

		!aux;
;; (* function asignar_valores_x *)

let recalcularValoresRepresentacion =
(*
objectivo:
	se trata que en funcion de los valores que introduzca el usuario, calcular los valores precisos para la correcta
	representacion de las graficas
*)
	function () ->
		grafica_xscl := ((!grafica_max /. 2.0) /. (!xmax /. !xscl));
		grafica_yscl := ((!grafica_max /. 2.0) /. (!ymax /. !yscl));
;; (* function recalcularValoresRepresentacion unit -> unit *)

let generar_grafica =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor y un STRING con la funcion a ejecutar. Se devuelve un unit.
*)
	function (contenedor, operacion) ->
		let aux = ref (String.sub operacion (String.length "Graph Y=") ((String.length operacion) - (String.length "Graph Y="))) in
		let x = ref (2.0 *. !xmin) in
		let y = ref 0.0 in
		
		recalcularValoresRepresentacion ();

		while (!x <= (2.0 *. !xmax)) (*&& ((!y >= !ymin) && (!y <= !ymax)))*) do
			let auxiliar = (ejecutar_comando (contenedor, [(asignar_valor_x ((obtener_expresion_valor !aux), (string_of_float !x)))])) in

			if (auxiliar <> "infinito") then
			begin
				y := float_of_string auxiliar;

				if (grafica_A.existe = false) then
					grafica_A.puntos <- grafica_A.puntos @ [((adaptar_valor_x !x), (adaptar_valor_y !y))]
				else if (grafica_B.existe = false) then
					grafica_B.puntos <- grafica_B.puntos @ [((adaptar_valor_x !x), (adaptar_valor_y !y))]
				else if (grafica_C.existe = false) then
					grafica_C.puntos <- grafica_C.puntos @ [((adaptar_valor_x !x), (adaptar_valor_y !y))]
				else ()
			end (* then *)
			else begin
				if (grafica_A.existe = false) then
					grafica_A.puntos <- grafica_A.puntos @ [((!grafica_max /. 2.0), 40.0)] @ [((!grafica_max /. 2.0), -10.0)]
				else if (grafica_B.existe = false) then
					grafica_B.puntos <- grafica_B.puntos @ [((!grafica_max /. 2.0), 40.0)] @ [((!grafica_max /. 2.0), -10.0)]
				else if (grafica_C.existe = false) then
					grafica_C.puntos <- grafica_C.puntos @ [((!grafica_max /. 2.0), 40.0)] @ [((!grafica_max /. 2.0), -10.0)]
				else ()
			end; (* else *)

			x := !x +. !xscl;
		done; (* while *)

		mostrarEjes contenedor;

		if ((existeGrafica grafica_A) = true) then
		begin
			grafica_A.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom grafica_A.puntos)), contenedor);
			grafica_A.existe <- true;
			grafica_A.en_pantalla <- true;
		end; (* then *)

		if ((existeGrafica grafica_B) = true) then
		begin
			grafica_B.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom grafica_B.puntos)), contenedor);
			grafica_B.existe <- true;
			grafica_B.en_pantalla <- true;
		end; (* then *)

		if ((existeGrafica grafica_C) = true) then
		begin
			grafica_C.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom grafica_C.puntos)), contenedor);
			grafica_C.existe <- true;
			grafica_C.en_pantalla <- true;
		end (* then *)
;; (* function generar_grafica widget -> unit *)

let cargarGraficaDatosEstadisticos =
(*
objectivo:
	cargar en memoria los datos almacenados previamente para la representacion de graficos de estadisticas de una sola variable
*)
	function (grafica, fichero_x, fichero_y) ->
		if ((Sys.file_exists (ruta_local ^ fichero_x ^ tipo_ficheros_datos)) && (Sys.file_exists (ruta_local ^ fichero_y ^ tipo_ficheros_datos))) then
		begin
			let id_fichero_x = open_in (ruta_local ^ fichero_x ^ tipo_ficheros_datos) in
			let id_fichero_y = open_in (ruta_local ^ fichero_y ^ tipo_ficheros_datos) in
			let seguir = ref true in

			while (!seguir = true) do
				try
					let x = input_line id_fichero_x in
					let y = input_line id_fichero_y in
					grafica.puntos <- grafica.puntos @ [((float_of_string x), (float_of_string y))];
				with End_of_file -> seguir := false;
			done; (* while *)

			close_in id_fichero_x;
			close_in id_fichero_y;
		end (* then *)
		else ()
;; (* function cargarGraficaDatosEstadisticos grafica -> unit *)

let curva_distribucion_normal =
(*
objectivo:
	se trata de mostrar la curva_distribucion_normal
*)
	function (contenedor, operacion) ->
		let aux = (String.sub operacion (String.length "Graph Y=") ((String.length operacion) - (String.length "Graph Y="))) in

		if (aux = "Line 1") then
		begin
			cargarGraficaDatosEstadisticos (grafica_barras, fichero_estadistica_una, fichero_estadistica_una_frecuencia);

			let x = ref !grafica_min in
			let indice = ref 0 in
			let ancho_barra = (!grafica_max /. (float_of_int (List.length grafica_barras.puntos))) in
			let desviacion_estandar = (Funciones_comunes.desviacion_estandar (fichero_estadistica_una, 0)) in
			let media_aritmetica = (Funciones_comunes.media_aritmetica fichero_estadistica_una) in

			let grafica_aux = {
				segmentos = [];
				puntos = [];
				existe = false;
				en_pantalla = false;
				fichero_x = "";
				fichero_y = "";
			} in

			grafica_barras.segmentos <- [];
			while ((!x <= !grafica_max) && (!indice < (List.length grafica_barras.puntos))) do
				let y = ((1.0 /. (sqrt (2.0 *. 3.1415926536)) *. desviacion_estandar) *. ((2.71828182846) ** ((((fst (List.nth grafica_barras.puntos !indice)) -. media_aritmetica) ** 2.0) /. (2.0 *. (desviacion_estandar ** 2.0))))) in
				grafica_aux.puntos <- grafica_aux.puntos @ [(!x, y)];

				indice := !indice + 1;
				x := !x +. ancho_barra;
			done;

			grafica_barras.segmentos <- dibujar_grafica (grafica_aux.puntos, contenedor);

			grafica_barras.existe <- true;
			grafica_barras.en_pantalla <- true;
		end (* then *)
		else ()
;; (* function curva_distribucion_normal widget * grafica -> unit *)

let mostrarEjesGraficaBarras =
(*
objectivo:
	se trata de mostrar los ejes de coordenadas antes de generar las graficas
*)
	function contenedor ->
		eje_x.puntos <- [(!grafica_min, !grafica_max); (!grafica_max, !grafica_max)];
		eje_y.puntos <- [(!grafica_min +. 0.5, !grafica_min); (!grafica_min +. 0.5, !grafica_max)];

		if ((existeGrafica eje_x) = true) then
		begin
			eje_x.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom eje_x.puntos)), contenedor);
			eje_x.existe <- true;
			eje_x.en_pantalla <- true;
		end; (* then *)

		if ((existeGrafica eje_y) = true) then
		begin
			eje_y.segmentos <- dibujar_grafica ((List.map aplicarDesplazamiento (List.map aplicarZoom eje_y.puntos)), contenedor);
			eje_y.existe <- true;
			eje_y.en_pantalla <- true;
		end; (* then *)
;; (* function mostrarEjesGraficaBarras widget -> unit *)

let rec dibujar_puntos_grafica =
(*
objectivo:
	se pasa como parametro una grafica a la que ya se le han generado los puntos por los que pasa
	y se representa en pantalla
*)
	function (lista_puntos, contenedor) ->
		match lista_puntos with
		  []		-> []
 		| h::[]		-> [(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters ((fst h) +. 0.5)); (Millimeters ((snd h) +. 0.5))] [])]
		| h::t::[]	-> [(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters ((fst h) +. 0.5)); (Millimeters ((snd h) +. 0.5))] []); (Canvas.create_line contenedor [(Millimeters (fst t)); (Millimeters (snd t)); (Millimeters ((fst t) +. 0.5)); (Millimeters ((snd t) +. 0.5))] [])]
		| h::m::t	-> [(Canvas.create_line contenedor [(Millimeters (fst h)); (Millimeters (snd h)); (Millimeters ((fst h) +. 0.5)); (Millimeters ((snd h) +. 0.5))] []); (Canvas.create_line contenedor [(Millimeters (fst m)); (Millimeters (snd m)); (Millimeters ((fst m) +. 0.5)); (Millimeters ((snd m) +. 0.5))] [])] @ (dibujar_puntos_grafica (t, contenedor))
;; (* function rec dibujar_puntos_grafica float * float list -> Tk.tagOrId *)

let mostrarGraficaDatosEstadisticos =
(*
objectivo:
	se trata de mostrar los datos introducidos en el modo LR2
*)
	function contenedor ->
		let grafica_aux = {
			segmentos = [];
			puntos = [];
			existe = false;
			en_pantalla = false;
			fichero_x = "";
			fichero_y = "";
		} in

		cargarGraficaDatosEstadisticos (grafica_barras, fichero_estadistica_dos_x, fichero_estadistica_dos_y);
		grafica_barras.segmentos <- [];
		for indice=0 to ((List.length grafica_barras.puntos) - 1) do
			let x = (fst (List.nth grafica_barras.puntos indice)) in
			let y = (snd (List.nth grafica_barras.puntos indice)) in
			grafica_aux.puntos <- grafica_aux.puntos @ [(adaptar_valor_x x, adaptar_valor_y y)];
		done; (* for *)

		grafica_barras.segmentos <- dibujar_puntos_grafica (grafica_aux.puntos, contenedor);
		grafica_barras.existe <- true;
		grafica_barras.en_pantalla <- true;
;; (* function mostrarGraficaDatos widget -> unit *)

let linea_regresion =
(*
objectivo:
	se trata de mostrar la curva_distribucion_normal
*)
	function (contenedor, operacion) ->
		let aux = (String.sub operacion (String.length "Graph Y=") ((String.length operacion) - (String.length "Graph Y="))) in

		if (aux = "Line 1") then
		begin
			cargarGraficaDatosEstadisticos (grafica_barras, fichero_estadistica_dos_x, fichero_estadistica_dos_y);

			let x = ref !grafica_min in
			let indice = ref 0 in
			let ancho_barra = (!grafica_max /. (float_of_int (List.length grafica_barras.puntos))) in
			let desviacion_estandar = (Funciones_comunes.desviacion_estandar (fichero_estadistica_una, 0)) in
			let media_aritmetica = (Funciones_comunes.media_aritmetica fichero_estadistica_una) in

			let grafica_aux = {
				segmentos = [];
				puntos = [];
				existe = false;
				en_pantalla = false;
				fichero_x = "";
				fichero_y = "";
			} in

			grafica_barras.segmentos <- [];
			while ((!x <= !grafica_max) && (!indice < (List.length grafica_barras.puntos))) do
				let y = ((1.0 /. (sqrt (2.0 *. 3.1415926536)) *. desviacion_estandar) *. ((2.71828182846) ** ((((fst (List.nth grafica_barras.puntos !indice)) -. media_aritmetica) ** 2.0) /. (2.0 *. (desviacion_estandar ** 2.0))))) in
				grafica_aux.puntos <- grafica_aux.puntos @ [(!x, y)];

				indice := !indice + 1;
				x := !x +. ancho_barra;
			done;

			grafica_barras.segmentos <- dibujar_grafica (grafica_aux.puntos, contenedor);

			grafica_barras.existe <- true;
			grafica_barras.en_pantalla <- true;
		end (* then *)
		else ()
;; (* function curva_distribucion_normal widget * grafica -> unit *)

let dibujar_graficaBarras =
(*
objectivo:
	se pasa como parametro una grafica a la que ya se le han generado los puntos por los que pasa
	y se representa en pantalla
*)
	function (grafica, contenedor) ->
		cargarGraficaDatosEstadisticos (grafica, fichero_estadistica_una, fichero_estadistica_una_frecuencia);

		let x = ref !grafica_min in
		let indice = ref 0 in
		let ancho_barra = (!grafica_max /. (float_of_int (List.length grafica.puntos))) in

		grafica.segmentos <- [];
		while ((!x <= !grafica_max) && (!indice < (List.length grafica.puntos))) do
			let frecuencia = (snd (List.nth grafica.puntos !indice)) in

			grafica.segmentos <- grafica.segmentos @ [(Canvas.create_line contenedor [(Millimeters !x); (Millimeters !grafica_max); (Millimeters !x); (Millimeters (!grafica_max -. frecuencia))] [])]
							@ [(Canvas.create_line contenedor [(Millimeters !x); (Millimeters (!grafica_max -. frecuencia)); (Millimeters (!x +. ancho_barra)); (Millimeters (!grafica_max -. frecuencia))] [])]
							@ [(Canvas.create_line contenedor [(Millimeters (!x +. ancho_barra)); (Millimeters (!grafica_max -. frecuencia)); (Millimeters (!x +. ancho_barra)); (Millimeters !grafica_max)] [])];

			indice := !indice + 1;
			x := !x +. ancho_barra;
		done;

		grafica.existe <- true;
		grafica.en_pantalla <- true;
;; (* dibujar_graficaBarras widget -> grafica *)

let esOperando =
(*
objectivo:
	se pasa como paramentro un STRING con el valor de la ultima tecla
	pulsada por el usuario y se devuelve un BOOL. Si la tecla pulsada
	corresponde a un posible valor (no es una operacion) se devuelve
	TRUE y en otro caso se devuelve FALSE.
*)
	function valor ->
		match valor with
		  "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "." | "¬" -> true
		| _ -> false
;; (* function esOperando string -> bool *)

let esAreaPrograma =
(*
objectivo:
	se pasa como paramentro un STRING con el valor de la ultima tecla
	pulsada por el usuario y se devuelve un BOOL. Si la tecla pulsada
	corresponde a un posible valor (no es una operacion) se devuelve
	TRUE y en otro caso se devuelve FALSE.
*)
	function valor ->
		match valor with
		  "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> true
		| _ -> false
;; (* function esAreaPrograma string -> bool *)

let inicio_raiz =
(*
objectivo: FUNCION AUXILIAR para obtener las raices dentro de un comando
	se pasa como parametro un STRING con el comando actual y se devuelve
	un INT que indica en que posicion dentro del comando comienza la
	ultima raiz introducida.
*)
	function comando ->
		let i = ref ((List.length comando) - 1) in
		let encontrado = ref false in
		while ((!i >= 0) && (!encontrado = false)) do
			if ((esOperando (List.nth comando !i)) = false) then
				encontrado := true
			else i := !i - 1;
		done; (* while *)

		if ((!encontrado = true) || (!i = -1)) then
			i := !i + 1;

		!i
;; (* function inicio_raiz string -> int *)

let obtener_raiz =
(*
objectivo:
	se pasa como parametro un STRING LIST con el comando actual y un INT
	con la posicion del comienzo de la raiz a obtener. Se devuelve un
	STRING LIST (forma en la que se representan las raices) con la raiz
	que se acaba de introducir
*)
	function (comando, inicio_raiz) ->
		let raiz_aux = ref [] in
		let aux = ref "" in
		for j=((List.length comando) - 1) downto inicio_raiz do
			if ((List.nth comando j) <> "¬") then
				aux := (List.nth comando j) ^ !aux
			else begin
				raiz_aux := !raiz_aux @ [!aux];
				aux := "";
			end; (* else *)
		done; (* for *)
		raiz_aux := !raiz_aux @ [!aux];

		if ((List.length !raiz_aux) < 3) then
			raiz_aux := ["0"] @ (List.rev !raiz_aux)
		else raiz_aux := (List.rev !raiz_aux);

		!raiz_aux
;; (* function obtener_raiz string * int -> string list *)

let crear_raiz =
(*
objectivo:
	se pasa como parametro un STRING LIST y se devuelve un STRING LIST
	con la raiz en cuestion
*)
	function comando ->
		obtener_raiz (comando, (inicio_raiz comando))
;; (* function crear_raiz string list -> float list*)


let calcular_valor_raiz =
(*
objectivo:
	se para como parametro un STRING LIST con una raiz y se devuelve un
	STRING con el valor de calcular la raiz.
*)
	function raiz ->
		let a =
			try
				float_of_string (List.nth raiz 0)
			with _ -> float_of_int (int_of_string (List.nth raiz 0))
		in
		let b =
			try
				float_of_string (List.nth raiz 1)
			with _ -> float_of_int (int_of_string (List.nth raiz 1))
		in
		let c =
			try
				float_of_string (List.nth raiz 2)
			with _ -> float_of_int (int_of_string (List.nth raiz 2))
		in
		let aux = ref 0.0 in
		aux := a +. (b /. c);

		(string_of_float !aux)
;; (* function calcular_valor_raiz string list -> string *)

let mcd =
(*
objectivo:
	se pasa como parametro un STRING LIST con los elementos de las raices
	y se devuelve un INT con el maximo comun divisor de los elementos.
*)
	function raices ->
		let resultado = ref 1 in
		if ((List.length raices) > 0) then
		begin
			for i=0 to ((List.length raices) - 1) do
				resultado := !resultado * int_of_string (List.nth (List.nth raices i) 2);
			done;
		end (* then *)
		else resultado := 1;

		!resultado
;; (* function mcd float list -> int *)

let cambiar_valor_comando =
(*
objectivo:
	se pasa como parametro un STRING LIST con el comando actual y un
	STRING con el valor de la ultima raiz y se devuelve un STRING LIST con
	el comando en el formato adecuado para el parser, es decir, sin la raiz
	y en su lugar el valor de la raiz.
*)
	function (comando, valor) ->
		let comando_aux = ref [] in
		for i=0 to ((inicio_raiz comando) - 1) do
			comando_aux := !comando_aux @ [(List.nth comando i)];
		done;
		for i=0 to ((String.length valor) - 1) do
			comando_aux := !comando_aux @ [(String.sub valor i 1)];
		done;

		!comando_aux
;; (* function cambiar_valor_comando string list * string -> string list *)

let formar_resultado_raices =
(*
objectivo:
	se pasa como parametro un STRING con el resultado de la ultima operacion
	y una STRING STRING LIST con las raices de la ultima operacion. Se devuelve
	un string en el formato de raices.
*)
	function (resultado, raices_actuales) ->
		let a = ref (parte_entera resultado) in
		let b = ref (parte_real resultado) in
		let c = ref (string_of_int (mcd raices_actuales)) in
		!a ^ (List.hd raices.widget.contenido) ^ (string_of_float ((float_of_string !b) *. (float_of_string !c))) ^ (List.hd raices.widget.contenido) ^ !c
;; (* function formar_resultado_raices string -> string *)
(*FIN	funciones de control y manejo de operaciones (A)*)



(*INI	funciones de control y manejo de comandos (B)*)
let borrar =
(*
objectivo:
	se pasa como parametro un STRING LIST con el comando actual y se
	devuelve un STRING LIST con el comando actual sin el ultimo elemento
	introducido, es decir, se hace un DEL en la calculadora
	Ej.
	["2"; "+"; "3"]	->	["2"; "+"]
*)
	function comando ->
        	List.rev (List.tl (List.rev comando))
;; (* function borrar string list -> string list *)

let calcular_longitud_comando =
	function comando ->
		let aux = ref 0 in
		for indice = 0 to (List.length comando - 1) do
			aux := !aux + (String.length (List.nth comando indice))
		done;

		!aux
;; (* function calcular_longitud_comando string list -> int *)
(*FIN	funciones de control y manejo de comandos (B)*)



(*INI	funciones de control y manejo de OBJECTOS (C)*)
let estado_objecto =
	function objecto ->
		objecto.estado
;; (* function estado_objeto objeto -> int *)

let cambio_estado =
	function (objecto, estado)->
		objecto.estado <- estado
;; (* function cambio_estado objeto * int -> unit *)
(*FIN	funciones de control y manejo de OBJECTOS *)




(*INI	Funciones de control y manejo de los distintos elementos de la calculadora *)
let cerrar_calculadora =
(*
objectivo:
	termina la ejecucion de la aplicacion
*)
	function () ->
		closeTk ();
		print_newline ();
		print_string "			Asistente Científico-Técnico Personal (A.C.T.P)";
		print_newline ();
		print_string "				  GRACIAS por su interés";
		print_newline ();
		print_newline ();
		exit (0);
		()
;; (* function cerrar_calculadora unit -> unit *)

let limpiar_linea_comandos =
(*
objectivo:
	se pasa como paramatro un WIDGET contenedor de otros widgets y otro
	WIDGET de los comandos. Se vacia el widget de los comandos.
*)
	function (contenedor, comandos) ->
		comandos.contenido <- [];
		Canvas.delete contenedor [comandos.id_widget];
		let id_widget = ref (Id 0) in
		id_widget := Canvas.create_text contenedor (Pixels 10) (Pixels 70) [Text ""; Font "Lucidatypewriter 18"; Anchor W];
		Canvas.configure_text contenedor (!id_widget) [];

		!id_widget
;; (* function limpiar_linea_comandos (objecto * objecto) -> unit *)

let eliminar_elemento_pantalla =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor de otros widgets y
	OBJECTO dentro del widget. Se elimina el OBJECTO
*)
(* como los unicos objectos que se eliminaran son los CANVAS de la pantalla no se pasa el objecto en
   si, sino tan solo su identificador dentro del objecto pANTALLA *)
	function (contenedor, objecto) ->
		cambio_estado (objecto, 0);
		Canvas.delete contenedor [objecto.id_widget]
;; (* function eliminar_elemento_pantalla objeto * objecto -> unit *)

let obtener_comando_pantalla =
(*
objectivo:
	se trata de poner en pantalla solo los elementos que quepan. Se pasa como parametro un String
	list conteniendo los distintos elementos del comando y se devuelve un string con lo que se mostrara
	en la pantalla de la calculadora
*)
	function comando ->
		let aux = ref "" in
			if (String.length comando <= longitud_maxima_comando_pantalla) then
				aux := comando
			else aux := (String.sub comando (((String.length comando) ) - longitud_maxima_comando_pantalla) longitud_maxima_comando_pantalla);

			!aux
;; (* function obtener_comando_pantalla string list -> string *)

let anadir_linea_comando =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor, un OBJECTO, la posicion
	dentro del comando y el texto a aÃ±adir. Ademas de poner en el widget de la
	pantalla el texto indicado tambien se introduce en el valor del objecto
*)
	function (contenedor, objecto, posicion, texto) ->
		objecto.contenido <- objecto.contenido @ [interpretar_comando texto];
		Canvas.configure_text contenedor (objecto.id_widget) [Text (obtener_comando_pantalla (formar_comando objecto.contenido))]
;; (* function objecto * objecto * int * string -> unit *)

let anadir_elemento_pantalla =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor, un OBJECTO a aÃ±adir al contenedor,
	unas coordenadas, un texto y el tamaÃ±o de la fuente a mostrar el texto.
*)
	function (contenedor, objecto, px, py, texto, tamano) ->
		let id_widget = ref (Id 0) in
		cambio_estado (objecto, 1);
		id_widget := Canvas.create_text contenedor (Pixels px) (Pixels py) [Text (obtener_comando_pantalla texto); Font tamano; Anchor W];
		Canvas.configure_text contenedor (!id_widget) [];

		!id_widget
;; (* function anadir_elemento_pantalla objecto * objecto * int * int * string * int -> Tk.tagOrId *)

let poner_comando =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor, un OBJECTO que es el comando
	actual y un STRING con el comando a poner. Segun este o no el OBJECTO en el WIDGET
	se aÃ±ade o se continua.
*)
	function (contenedor, comando, nuevo_comando) ->
		match (estado_objecto comando) with
	  	  0 -> begin
	  		cambio_estado (comando, 1);
	  		comando.id_widget <- anadir_elemento_pantalla (contenedor, comando, 10, 70, nuevo_comando, "Lucidatypewriter 18");
			comando.contenido <- comando.contenido @ [(interpretar_comando nuevo_comando)];

			nuevo_comando
	  	end (* 0 *)
		| _ -> begin
			anadir_linea_comando (contenedor, comando, End, nuevo_comando);
			
			nuevo_comando
		end (* _ *)
;; (* function poner_comando objecto * objecto * string -> unit *)

let es_tecla_modo =
	function tecla ->
		match (obtener_contenido tecla.widget) with
		  "." | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" | "+" | "-" | "x" | "÷" -> true
		  | _ -> false
;; (* function es_tecla_modo tecla -> bool*)

let obtener_modo =
	function modo ->
		match modo with
		  "1" | "RUN"	-> 1
		| "2" | "WRT"	-> 2
		| "3" | "PCL"	-> 3
		| "4" | "Deg"	-> 4
		| "5" | "Rad"	-> 5
		| "6" | "Gra"	-> 6
		| "7" | "Fix "	-> 7
		| "8" | "Sci "	-> 8
		| "9" | "Norm"	-> 9
		| "." | "Defm" | "10"	-> 10
		| "+" | "COMP" | "11"	-> 11
		| "-" | "BASE" | "12"	-> 12
		| "SD1"	| "13"	-> 13
		| "SD2"	| "15"	-> 15
		| "LR1"	| "14"	-> 14
		| "LR2"	| "16"	-> 16
		| _		-> 1
;; (* function obtener_modo string -> string *)

let rec anadir_comando =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor y una TECLA, en funcion de la combinacion
	de tecla pulsadas antes de la actual TECLA, se hace una cosa u otra con los comandos anteriores.
*)
	function (contenedor, tecla) ->
		match (estado_objecto shift.widget) with
		  1 -> begin
		  	eliminar_elemento_pantalla (contenedor, shift.widget);
	  		match tecla.valor with
			  "sin "
			| "cos "
			| "tan " -> begin
				match (estado_objecto hiperbola.widget) with
				  1 -> comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.shift_hiperbola)]; eliminar_elemento_pantalla (contenedor, hiperbola.widget)
				| _ -> comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.shift)]
			end (* sin cos tan *)
			| "log " -> begin
				if ((estado_objecto linea_comandos) = 1) then
					anadir_comando (contenedor, por)
				else ();

				comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.shift)];
				if ((estado_objecto hiperbola.widget) = 1) then
					eliminar_elemento_pantalla (contenedor, hiperbola.widget)
				else ();
			end (* log *)
			| "4"
			| "5"
			| "6" -> begin
				match (estado_objecto mode.widget) with
				  1 -> conversiones := 1; comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.shift_mode)]; eliminar_elemento_pantalla (contenedor, mode.widget)
				| _ -> 	if (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) ||
				    		((obtener_modo (obtener_contenido modo_funcionamiento)) = 14) ||
				    		((obtener_modo (obtener_contenido modo_funcionamiento)) = 15) ||
				    		((obtener_modo (obtener_contenido modo_funcionamiento)) = 16) ) then
						comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.funcion_base_n)]
					else comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.shift)]
			end (* 4 5 6 *)
			| "1" | "2" | "3" | "7"
			| "8" | "9" | "+" | "->" ->
			begin
				if (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) ||
				    ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14) ||
				    ((obtener_modo (obtener_contenido modo_funcionamiento)) = 15) ||
				    ((obtener_modo (obtener_contenido modo_funcionamiento)) = 16) ) then
					comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.funcion_base_n)]
				else (comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.shift)]);

				if ((estado_objecto hiperbola.widget) = 1) then
					eliminar_elemento_pantalla (contenedor, hiperbola.widget)
				else ();
			end (* 1 2 3 7 8 9 + *)
			| "x" | "÷" ->
			begin
				if (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) ||
				    ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14)) then
					comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.funcion_base_n)]
				else begin
					match tecla.valor with
					  "x" -> aumentar_zoom ()
					| "÷" -> disminuir_zoom ()
					| _ -> ()
				end; (* else *)

				if ((estado_objecto hiperbola.widget) = 1) then
					eliminar_elemento_pantalla (contenedor, hiperbola.widget)
				else ();
			end (* x Ã· *)
			| _ -> begin
				comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.shift)];

				if ((estado_objecto hiperbola.widget) = 1) then
					eliminar_elemento_pantalla (contenedor, hiperbola.widget)
				else ();
			end (* _ *)
		end (* 1 *)
		| _ ->	match (estado_objecto alpha.widget) with
			  1 -> comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.alpha)]; eliminar_elemento_pantalla (contenedor, alpha.widget)
			| _ ->
				if (((estado_objecto mode.widget) = 1) && ((es_tecla_modo tecla) = true)) then
				begin
					comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.mode)];
					eliminar_elemento_pantalla (contenedor, mode.widget);
					operacion_cambio_modo := true
				end (* then *)
				else begin
		  			match tecla.valor with
					  "sin "
					| "cos "
					| "tan " -> begin
						match (estado_objecto hiperbola.widget) with
						  1 -> comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.hiperbola)]; eliminar_elemento_pantalla (contenedor, hiperbola.widget)
						| _ -> begin
							if ((estado_objecto mode_base) = 1) then
								comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.funcion_base_n)]
							else comando := !comando @ [poner_comando (contenedor, linea_comandos, (obtener_contenido tecla.widget))];
							if ((estado_objecto hiperbola.widget) = 1) then
								eliminar_elemento_pantalla (contenedor, hiperbola.widget)
							else ();
						end (* _ *)
					end (* sin cos tan *)
					| "->" -> begin
						if ((!modo_programacion = 2) && ((estado_objecto programa) = 1)) then
						begin
							comando := !comando @ [poner_comando (contenedor, linea_comandos, tecla.valor)];

							if ((estado_objecto hiperbola.widget) = 1) then
								eliminar_elemento_pantalla (contenedor, hiperbola.widget)
							else ();
						end (* then *)
						else begin
(*
							operacion.contenido <- linea_comandos.contenido;
							resultado_aux := ejecutar_comando (contenedor, linea_comandos.contenido);
							cambio_estado (ejecutar.widget, 0);
							if (!resultado_aux <> "Error") then
							begin
								almacenar := true;
								comando := !comando @ [poner_comando (contenedor, linea_comandos, (obtener_contenido tecla.widget))];
								linea_comandos.contenido <- [];
							end 
							else begin
								almacenar := false;
								comando := !comando @ [poner_comando (contenedor, linea_comandos, (obtener_contenido tecla.widget))];
							end;
*)
							comando := !comando @ [poner_comando (contenedor, linea_comandos, (obtener_contenido tecla.widget))];
							
							if ((estado_objecto hiperbola.widget) = 1) then
								eliminar_elemento_pantalla (contenedor, hiperbola.widget)
							else ();
						end (* else *)
					end (* -> *)
		  			| _ -> begin
						comando := !comando @ [poner_comando (contenedor, linea_comandos, (obtener_contenido tecla.widget))];

						if ((estado_objecto hiperbola.widget) = 1) then
							eliminar_elemento_pantalla (contenedor, hiperbola.widget)
						else ();
					end (*_*)
				end (* else *)
;; (* function anadir_comando objecto * tecla -> unit *)

let obtener_ultimo_cadena =
	function cadena ->
		String.make 1 (String.get cadena ((String.length cadena) - 1))
;; (* function obtener_ultimo_cadena string -> string *)

let entradaDatos =
(*
objectivo:
	se trata de establecer los limites y crecimientos de los valores de las coordenadas para la representacion
	grafica
*)
	function (contenedor, tecla) ->
		if ((estaModoGrafico ()) = true) then
		begin
			ocultarGraficas (contenedor, grafica_A);
			ocultarGraficas (contenedor, grafica_B);
			ocultarGraficas (contenedor, grafica_C);

			ocultarEjes contenedor;
		end (* then *)
		else ();

		cambio_estado (tecla.widget, ((estado_objecto tecla.widget) + 1)); (* se avisa de que se esta introduciendo un rango*)

		linea_comandos.contenido <- [];
		eliminar_elemento_pantalla (contenedor, linea_comandos);

		if (!rango_funcionamiento = 0) then
		begin
			if ((estado_objecto shift.widget) = 1) then
			begin
				eliminar_elemento_pantalla (contenedor, shift.widget);
				rango_funcionamiento := 1;
			end
			else begin
				rango_funcionamiento := 2;
			end
		end (* then *)
		else if (!rango_funcionamiento = 1) && ((estado_objecto tecla.widget) = 3) then
		begin
			rango_funcionamiento := 0;
			cambio_estado (tecla.widget, 0);
		end; (* else *)

		match !rango_funcionamiento with
		  1 -> begin
			match (estado_objecto tecla.widget) with
			  1 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Xfact?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !xfact))]; cambio_estado (ejecutar.widget, 1)
			| 2 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Yfact?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !yfact))]; cambio_estado (ejecutar.widget, 1)
			| _ -> eliminar_elemento_pantalla (contenedor, rango); cambio_estado (tecla.widget, 0); rango_funcionamiento := 0
		end (* 1 *)
		| _ -> begin
			match (estado_objecto tecla.widget) with
			  1 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Xmin?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !xmin))]; cambio_estado (ejecutar.widget, 1)
			| 2 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Xmax?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !xmax))]; cambio_estado (ejecutar.widget, 1)
			| 3 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Xscl?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !xscl))]; cambio_estado (ejecutar.widget, 1)
			| 4 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Ymin?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !ymin))]; cambio_estado (ejecutar.widget, 1)
			| 5 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Ymax?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !ymax))]; cambio_estado (ejecutar.widget, 1)
			| 6 -> eliminar_elemento_pantalla (contenedor, rango); rango.id_widget <- anadir_elemento_pantalla (contenedor, rango, 10, 40, "Yscl?", "Courier 20"); comando := !comando @ [poner_comando (contenedor, linea_comandos, (string_of_float !yscl))]; cambio_estado (ejecutar.widget, 1)
			| _ -> eliminar_elemento_pantalla (contenedor, rango); cambio_estado (tecla.widget, 0); rango_funcionamiento := 0
		end
;; (* function entradaDatos widget * tecla -> unit *)

let areaProgramaDisponible =
(*
objectivo:
	se comprueba si exite o no un fichero. Si no existe se devolvera un TRUE sino un FALSE
*)
	function areaPrograma ->
		if (Sys.file_exists (ruta_local ^ areaPrograma ^ tipo_ficheros_datos)) then
			false
		else true
;; (* function areaProgramaDisponible string -> bool*)

let programasDisponibles =
(*
objetivo:
	saber que memorias para programas hay disponibles para el usuario
	P   0 1 2 3 4 5 6 7 8 9
*)
	function () ->
		let cadena_aux = ref "P  " in
		for indice=0 to (maximo_numero_programas - 1) do
			if ((areaProgramaDisponible (string_of_int indice)) = true) then
				cadena_aux := !cadena_aux ^ " " ^ (string_of_int indice)
			else cadena_aux := !cadena_aux ^ " _"
		done;

		!cadena_aux
;; (* function programasDisponibles unit -> string *)

let eliminarProgramas =
(*
objectivo:
	eliminar todos los ficheros correspondientes a programas almacenados
*)
	function () ->
		let cadena_aux = ref "P  " in
		for indice=0 to (maximo_numero_programas - 1) do
			Funciones_comunes.borrarFichero (string_of_int indice)
		done;
;; (* function eliminarProgramas unit -> unit *)

let modo_operacion =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor y un STRING con el nuevo modo de funcionamiento
	y en funcion de este modo, se cambia el estado de la calculadora.
*)
	function (contenedor, modo) ->
		let aux = ref "" in
		if ((String.length modo) > 4) then
			aux := String.sub modo 0 4
		else aux := modo;

		operacion_cambio_modo := false;

		if (((obtener_modo !aux) = 2) || ((obtener_modo !aux) = 3)) then
		begin
			modo_programacion := (obtener_modo !aux)
		end (* then *)
		else modo_funcionamiento.contenido <- [string_of_int (obtener_modo !aux)];

		if (((estado_objecto mode_base) = 1) && ((obtener_modo (obtener_contenido modo_funcionamiento)) <> 11)) then
		begin
		end (* then *)
		else begin
			match (obtener_modo !aux) with
			  1 -> begin
				eliminar_elemento_pantalla (contenedor, modo_funcionamiento);

				if ((!modo_programacion = 2) || (!modo_programacion = 3))  then
				begin
					if (((String.length (obtener_expresion_valor (formar_comando linea_comandos.contenido))) > 0) && (!modo_programacion = 2)) then
					begin
						if ((areaProgramaDisponible (obtener_contenido programa)) = false) then
							Sys.remove (ruta_local ^ (obtener_contenido programa) ^ tipo_ficheros_datos);

						for indice=0 to ((List.length linea_comandos.contenido) - 1) do
							Funciones_comunes.anadir_dato_estadistico ((List.nth linea_comandos.contenido indice), (obtener_contenido programa))
						done; (* for *)
					end; (* then *)

					programa.contenido <- [];
					modo_programacion := 0;
					eliminar_elemento_pantalla (contenedor, dos.widget);
					eliminar_elemento_pantalla (contenedor, tres.widget);
				end; (* then *)

				modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 150, 20, "D", "3")
			end (* 1 *)
			| 2 -> begin
				eliminar_elemento_pantalla (contenedor, dos.widget);
				eliminar_elemento_pantalla (contenedor, tres.widget);

				dos.widget.id_widget <- anadir_elemento_pantalla (contenedor, dos.widget, 200, 20, dos.mode, "3");
				aux := poner_comando (contenedor, linea_comandos, programasDisponibles ());
			end (* 2 *)
			| 3 -> begin
				eliminar_elemento_pantalla (contenedor, dos.widget);
				eliminar_elemento_pantalla (contenedor, tres.widget);

				tres.widget.id_widget <- anadir_elemento_pantalla (contenedor, tres.widget, 200, 20, tres.mode, "3");
				aux := poner_comando (contenedor, linea_comandos, programasDisponibles ());
			end (* 3 *)
			| 4 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 150, 20, "D", "3")
			| 5 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 165, 20, "R", "3")
			| 6 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 180, 20, "G", "3")
			| 7 -> begin
				eliminar_elemento_pantalla (contenedor, modo_funcionamiento);
				modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 195, 20, siete.mode, "3");
				try
					if ((String.length modo) > 4) then
					(* *** *)numero_decimales := (obtener_ultimo_cadena modo)
					else ();
				with _ -> numero_decimales := "8";
			end (* 7 *)
			| 8 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 210, 20, ocho.mode, "3"); numero_decimales := "8"
			| 9 -> numero_decimales := "8" (* decimales por defecto *)
			| 11-> eliminar_elemento_pantalla (contenedor, mode_base); eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 150, 20, "D", "3")
			| 12-> begin
				eliminar_elemento_pantalla (contenedor, modo_funcionamiento);
				modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 10, 20, menos.mode, "Courier 20");
				cambio_estado (mode_base, 1);
				mode_base.id_widget <- anadir_elemento_pantalla (contenedor, mode_base, 290, 30, (obtener_valor_fichero fichero_ultimo_modo_base), "Courier 15");
				mode_base.contenido <- [(obtener_valor_fichero fichero_ultimo_modo_base)];
			end (* 12 *)
			| 13 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 10, 20, por.mode, "Courier 20")
			| 14 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 10, 20, entre.mode, "Courier 20")
			| 15 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 10, 20, por.shift_mode, "Courier 20")
			| 16 -> eliminar_elemento_pantalla (contenedor, modo_funcionamiento); modo_funcionamiento.id_widget <- anadir_elemento_pantalla (contenedor, modo_funcionamiento, 10, 20, entre.shift_mode, "Courier 20")
			| _ -> ()
		end (* else *)
;; (* function modo_operacion int -> unit *)

let borrar_entrada =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor de todos los objectos, se eliminan
	todos los objectos de la pantalla y se vacian las variables de comandos.
*)
	function (contenedor) ->
	begin
		cambio_estado (ac.widget, 1);

		eliminar_elemento_pantalla (contenedor, alpha.widget);

		if ((!modo_programacion = 2) || (!modo_programacion = 3)) then
			modo_operacion (contenedor, (string_of_int !modo_programacion))
		else modo_operacion (contenedor, (obtener_contenido modo_funcionamiento));

		eliminar_elemento_pantalla (contenedor, linea_comandos);
		eliminar_elemento_pantalla (contenedor, programa);
		
		linea_comandos.contenido <- [];
		raices_comando := [];
		calcularRaices := false;
		esRaiz := false;

		cambio_estado (ac.widget, 0);
       		()
	end
;; (* function borrar_entrada unit -> unit *)

let borrarMemoriasPrograma =
(*
objectivo:
	se trata de dejar vacios los ficheros de las posibles memorias para programas
*)
	function () ->
		Funciones_comunes.borrarFichero "A";
		Funciones_comunes.borrarFichero "B";
		Funciones_comunes.borrarFichero "C";
		Funciones_comunes.borrarFichero "D";
		Funciones_comunes.borrarFichero "E";
		Funciones_comunes.borrarFichero "F";
		Funciones_comunes.borrarFichero "G";
		Funciones_comunes.borrarFichero "H";
		Funciones_comunes.borrarFichero "I";
		Funciones_comunes.borrarFichero "J";
		Funciones_comunes.borrarFichero "K";
		Funciones_comunes.borrarFichero "L";
		Funciones_comunes.borrarFichero "M";
		Funciones_comunes.borrarFichero "N";
		Funciones_comunes.borrarFichero "O";
		Funciones_comunes.borrarFichero "P";
		Funciones_comunes.borrarFichero "Q";
		Funciones_comunes.borrarFichero "R";
		Funciones_comunes.borrarFichero "S";
		Funciones_comunes.borrarFichero "T";
		Funciones_comunes.borrarFichero "U";
		Funciones_comunes.borrarFichero "V";
		Funciones_comunes.borrarFichero "W";
		Funciones_comunes.borrarFichero "X";
		Funciones_comunes.borrarFichero "Y";
		Funciones_comunes.borrarFichero "Z"
;; (* function borrarMemoriasPrograma unit -> unit *)

let rec hayPrograma = 
(*
objectivo:
	se trata de comprobar si lo que trata de ejecutar un usuario contiene o es un programa
*)
	function comando ->
		match comando with
		  []	-> false
		| h::t	-> begin
			if (h = prog.valor) then
				true
			else (hayPrograma t)
		end (* h::t *)
;; (* function hayPrograma string list -> bool *)

let cargarPrograma =
(*
objectivo:
	pasar a memoria el programa solicitado para su ejecucion
*)
	function programa ->
		if (Sys.file_exists (ruta_local ^ programa ^ tipo_ficheros_datos)) then
		begin
			let id_fichero = open_in (ruta_local ^ programa ^ tipo_ficheros_datos) in
			let programa_aux = ref [] in
			let seguir = ref true in

			while (!seguir = true) do
				try
					let valor_actual = input_line id_fichero in
						programa_aux := !programa_aux @ [valor_actual]
				with End_of_file -> seguir := false;
			done; (* while *)
			close_in id_fichero;

			!programa_aux
		end (* then *)
		else ["0"]
;; (* function cargarPrograma string -> string list *)

let obtenerPrograma =
(*
objectivo:
	se trata de obtener el numero correspondiente al programa a ejecutar
*)
	function comando ->
		let indice = ref 0 in
		let encontrado = ref false in
		
		while ((!indice < List.length comando) && (!encontrado = false)) do
			if ((List.nth comando !indice) = prog.valor) then
				encontrado := true
			else indice := !indice + 1
		done; (* while *)
		
		if (!encontrado = true) then
		begin
			if ((esAreaPrograma (List.nth comando (!indice + 1))) = true) then
				(List.nth comando (!indice + 1))
			else ""
		end (* then *)
		else ""
;; (* function obtenerPrograma string list -> string *)

let comandoReservado =
(*
objectivo:
	se trata de comprobar si el subcomando actual del programa actual es un comando de control de programa
*)
	function subcomando ->
		let indice = ref 0 in
		let encontrado = ref false in
		
		while ((!indice < (List.length subcomando)) && (!encontrado = false)) do
			match (List.nth subcomando !indice) with
			  "Lbl"
			| "?"
			| "Goto"
			| "@"
			| "=>"
			| "Isz"
			| "Dsz"
			| "Range"
			| "Graph Y="	-> encontrado := true
			| _	-> indice := !indice + 1;
		done; (* while *)

		!encontrado
;; (* function comandoReservado string list -> bool *)

let obtenerComandoReservado =
(*
objectivo:
	se trata de obtener el comando reservado del comando actual
*)
	function comando ->
		let indice = ref 0 in
		let encontrado = ref false in
		
		while ((!indice < (List.length comando)) && (!encontrado = false)) do
			match (List.nth comando !indice) with
			  "Lbl"
			| "?"
			| "Goto"
			| "@"
			| "=>"
			| "Isz"
			| "Dsz"
			| "Range"
			| "Graph Y="	-> encontrado := true
			| _	-> indice := !indice + 1;
		done; (* while *)

		if (!encontrado = true) then
			(List.nth comando !indice)
		else "NO"
;; (* function obtenerComandoReservado string list -> string *)


let encontrarElementoDesde =
(*
objectivo:
	se trata de devolver la posicion de la siguiente marca de fin de comando dentro de un programa, desde la
	posicion de la anterior marca de fin de comando.
	Las marcas de fin de programa son ':', '@', fin_de_programa
*)
	function (programa, desde) ->
		let indice = ref desde in
		let encontrado = ref false in
		
		while ((!indice < (List.length programa)) && (!encontrado = false)) do
			if ( ((List.nth programa !indice) = ":") || ((List.nth programa !indice) = "@") ) then
			     encontrado := true
			else indice := !indice + 1;
		done; (* while *)
		
		!indice
;; (* function encontrarElementoDesde string list * int -> int *)

let siguienteSeperador =
(*
objectivo:
	se trata de devolver la posicion de la siguiente marca de fin de comando dentro de un programa, desde la
	posicion de la anterior marca de fin de comando.
	Las marcas de fin de programa son ':', '@', fin_de_programa
*)
	function programa ->
		let indice = ref 0 in
		let encontrado = ref false in
		
		while ((!indice < (List.length programa)) && (!encontrado = false)) do
			if ( ((List.nth programa !indice) = ":") || ((List.nth programa !indice) = "@") ||
			     ((List.nth programa !indice) = "Goto") ) then
			     encontrado := true
			else indice := !indice + 1;
		done; (* while *)
		
		if (!indice >= (List.length programa)) then
			"fin"
		else (List.nth programa !indice)
;; (* function siguienteSeperador string list * int -> int *)

let obtenerComandoEjecutarPrograma =
(*
objectivo:
	se trata de obtener el siguiente comando a ejecutar dentro de un programa
*)
	function programa ->
		let indice = ref 0 in
		let fin_comando = ref false in
		let comando_actual_aux = ref [] in
		
		while ((!indice < (List.length programa)) && (!fin_comando = false)) do
			if ((List.nth programa !indice) = dos_puntos.valor) then
			     fin_comando := true
			else begin		
				if ( (!indice > 0) && ((List.nth programa !indice) = graph.alpha) ) then
					fin_comando := true
				else if ( (!indice = 0) && ((List.nth programa !indice) = graph.alpha) ) then
				begin
					comando_actual_aux := !comando_actual_aux @ [(List.nth programa !indice)];
					
					fin_comando := true;
				end (* else if .. then *)
				else begin
					comando_actual_aux := !comando_actual_aux @ [(List.nth programa !indice)];
					
					indice := !indice + 1;
				end; (* else *)
			end; (* else *)
		done; (* while *)
		
		if ((!fin_comando = false) && (!indice >= (List.length programa))) then
			fin_programa := 1
		else fin_programa := 0;
		
		!comando_actual_aux
;; (* function obtenerComandoEjecutarPrograma string list -> string list *)

let entradaDatosPrograma =
(*
objectivo:
	se trata de comprobar si el comando actual en ejecucion de un programa es una solicitud de datos
*)
	function comando ->
		match (obtenerComandoReservado comando) with
		  "?"	-> true
		| _	-> false	
;; (* function entradaDatosPrograma string list -> bool *)

let avanzarPrograma =
(*
objectivo:
	se trata de modificar el contenido del programa_actual en ejecucion para procesar la siguiente instruccion
	del mismo
*)
	function programa ->
		let posicion = ref 0 in 
	
		if (((siguienteSeperador programa.contenido) = "@") && ((List.hd programa.contenido) <> "@")) then
			posicion := (encontrarElementoDesde (programa.contenido, 0))
		else posicion := ((encontrarElementoDesde (programa.contenido, 0)) + 1);
		
		let programa_aux = ref [] in
		for indice=(!posicion) to ((List.length programa.contenido) - 1) do
			programa_aux := !programa_aux @ [List.nth programa.contenido indice]
		done; (* for *)
						
		!programa_aux
;; (* function avanzarPrograma objecto -> string list *)

let obtenerEtiquetaGoto =
(*
objectivo:
	se trata de encontrar la etiqueta del Goto en ejecucion
*)
	function comando ->
		let aux = ref "" in 
		for indice=1 to ((List.length comando) - 1) do
			aux := !aux ^ (List.nth comando indice)
		done; (* for *)
		
		!aux
;; (* function obtenerEtiquetaGoto string list -> string list*)

let procesarGoto =
(*
objectivo:
	se trata de realizar la accion del Goto posicionando el programa en el comando adecuado
*)
	function etiqueta ->
		programa_actual.contenido <- [];
		programa_actual.contenido <- programa.contenido;
		
		let indice = ref 0 in
		comando_actual_programa := obtenerComandoEjecutarPrograma programa_actual.contenido;
		while (((formar_comando !comando_actual_programa) <> ("Lbl" ^ etiqueta)) && (!fin_programa = 0) && (!indice < (List.length programa.contenido))) do
			programa_actual.contenido <- avanzarPrograma programa_actual;
			comando_actual_programa := obtenerComandoEjecutarPrograma programa_actual.contenido;
			
			indice := !indice + 1;
		done; (* while *)
		
		if (!indice >= (List.length programa.contenido)) then
		begin
			error_programa := 1;
			"Goto ERROR"
		end (* then *)
		else ""
;; (* function procesarGoto string -> string *)

let ejecutarComandoReservado =
(*
objectivo:
	se trata de procesar los comandos reservados de programas
*)
	function contenedor ->
		match (obtenerComandoReservado !comando_actual_programa) with
		  "?"	-> begin
			borrar_entrada contenedor;
			
			memoria_actual_programa := (List.hd (List.rev !comando_actual_programa));
			almacenando_memoria_programa := 1;
			introduciendo_datos_programa := 1;
			
			if ((List.hd !comando_actual_programa) = "?") then
				poner_comando (contenedor, linea_comandos, "?")
			else begin
				let cadena = ref "" in
				let indice = ref 0 in
				
				while ((List.nth !comando_actual_programa !indice) <> "?") do
					if ((List.nth !comando_actual_programa !indice) <> "''") then
						cadena := !cadena ^ (List.nth !comando_actual_programa !indice);
					
					indice := !indice + 1;
				done; (* while *)
				
				poner_comando (contenedor, linea_comandos, (!cadena ^ "?"))
			end (* else *)
		end (* ? *)
		| "@"	-> begin
			borrar_entrada contenedor;
									
			eliminar_elemento_pantalla (contenedor, mostrando_salida);
			mostrando_salida.id_widget <- anadir_elemento_pantalla (contenedor, mostrando_salida, 200, 40, "disp", "Courier 10");
			
			if (!mostrar_grafica_programa = 1) then
			begin
				repintarGraficas contenedor;
				""
			end (* then *)
			else begin
				let resultado = (obtener_valor_fichero fichero_resultado_programa) in
				if ((es_entero (resultado)) = true) then
					poner_comando (contenedor, linea_comandos, ((formatear_salida resultado) ^ "."))
				else poner_comando (contenedor, linea_comandos, (formatear_salida resultado));
			end
		end (* @ *)
		| "Goto"-> begin
			procesarGoto (obtenerEtiquetaGoto !comando_actual_programa);
		end (* Goto *)
		| "Lbl"	-> ""
		| "=>"	-> begin
			try
				let comando_actual_aux1 = ref [] in
				let comando_actual_aux2 = ref [] in
				let indice = ref 0 in
				let encontrado = ref false in
			
				while (!indice < (List.length !comando_actual_programa)) do
					if ((List.nth !comando_actual_programa !indice) = "=>") then
					begin
						encontrado := true;
						indice := !indice + 1;
					end; (* then *)
				
					if (!encontrado = false) then
						comando_actual_aux1 := !comando_actual_aux1 @ [(List.nth !comando_actual_programa !indice)]
					else comando_actual_aux2 := !comando_actual_aux2 @ [(List.nth !comando_actual_programa !indice)];
				
					indice := !indice + 1;
				done; (* while *)

				let condicion = ref "" in
				condicion := ejecutar_comando (contenedor, !comando_actual_aux1);
				
				if ((float_of_string !condicion) = 1.0) then (* NO SE CUMPLE LA CONDICION *)
				begin
					if (!fin_programa = 0) then
						programa_actual.contenido <- !comando_actual_aux2 @ [":"] @ programa_actual.contenido
					else programa_actual.contenido <- !comando_actual_aux2
				end (* then *)
				else begin
					if ((programa_actual.contenido <> []) && ((List.hd programa_actual.contenido) = "@") && (!fin_programa = 0)) then
						programa_actual.contenido <- avanzarPrograma programa_actual;
				end; (* else *)
				""
			with _ -> begin
				error_programa := 1;
				"ERROR condicion" 
			end
		end (* => *)
		| "Isz" -> begin
			try
				let comando_actual_aux = ref ([(List.hd (List.rev !comando_actual_programa))] @ ["+";"1";"->"] @ [(List.hd (List.rev !comando_actual_programa))]) in
				let resultado = ref (ejecutar_comando (contenedor, !comando_actual_aux)) in

				comando_actual_aux := [(List.hd (List.rev !comando_actual_programa))] @ ["=";"0"];
			
				let condicion = ref "" in
				condicion := ejecutar_comando (contenedor, !comando_actual_aux);
			
				if (float_of_string !condicion = 1.0) then 
				begin
					if (!fin_programa = 0) then
						programa_actual.contenido <- avanzarPrograma programa_actual;
				
					if (((List.hd programa_actual.contenido) = "@") && (!fin_programa = 0)) then
						programa_actual.contenido <- avanzarPrograma programa_actual;
				end; (* then *)
				""
			with _ -> begin
				error_programa := 1;
				"Isz ERROR" 
			end
		end (* Isz *)
		| "Dsz"	-> begin
			try
				let comando_actual_aux = ref ([(List.hd (List.rev !comando_actual_programa))] @ ["-";"1";"->"] @ [(List.hd (List.rev !comando_actual_programa))]) in
				let resultado = ref (ejecutar_comando (contenedor, !comando_actual_aux)) in
			
				comando_actual_aux := [(List.hd (List.rev !comando_actual_programa))] @ ["=";"0"];
			
				let condicion = ref "" in
				condicion := ejecutar_comando (contenedor, !comando_actual_aux);
			
				if (float_of_string !condicion = 1.0) then 
				begin
					if (!fin_programa = 0) then
						programa_actual.contenido <- avanzarPrograma programa_actual;
				
					if (((List.hd programa_actual.contenido) = "@") && (!fin_programa = 0)) then
						programa_actual.contenido <- avanzarPrograma programa_actual;
				end; (* then *)	
				""
			with _ -> begin
				error_programa := 1;
				"Dsz ERROR" 
			end
		end (* Dsz *)
		| "Range"-> begin
			let indice = ref 1 in
			let valores = ref [] in
			let valor_aux = ref "" in
			
			while (!indice < (List.length !comando_actual_programa)) do
				if ((List.nth !comando_actual_programa !indice) = ",") then
				begin
					valores := !valores @ [!valor_aux];
					valor_aux := "";
				end (* then *)
				else valor_aux := !valor_aux ^ (List.nth !comando_actual_programa !indice);
				
				indice := !indice + 1;
			done; (* while *)
			
			valores := !valores @ [!valor_aux];
			
			xmin := (float_of_string (List.nth !valores 0));
			xmax := (float_of_string (List.nth !valores 1));
			xscl := (float_of_string (List.nth !valores 2));			
			ymin := (float_of_string (List.nth !valores 3));
			ymax := (float_of_string (List.nth !valores 4));
			yscl := (float_of_string (List.nth !valores 5));
			
			if ((!xmin >= !xmax) || (!ymin >= !ymax)) then
			begin
				error_programa := 1;
				"Range ERROR"
			end (* then *)
			else ""
		end (* Range *)
		| "Graph Y="-> begin
      try 
  			generar_grafica (contenedor, (formar_comando !comando_actual_programa));
			
	  		if (!fin_programa = 0) then
		  	begin
			  	if ((eje_x.en_pantalla = true) || (eje_y.en_pantalla = true)) then
				  begin
  					ocultarGraficas (contenedor, grafica_A);
  					ocultarGraficas (contenedor, grafica_B);
  					ocultarGraficas (contenedor, grafica_C);

  					ocultarGraficaBarras contenedor;

  					ocultarEjes contenedor;
	  			end; (* then *)
				
		  		mostrar_grafica_programa := 1;
			  end; (* then *)
				""
			with _ -> begin
				error_programa := 1;
				"Graph ERROR" 
			end
		end (* Graph Y= *)
		| _	-> ""
;; (* function ejecutarComandoReservado string list -> string *)

let rec ejecutar_programa =
(*
objectivo:
	se trata de ejecutar un programa almacenado, que se pasa como parametro en forma de STRING LIST
*)
	function contenedor ->
		let resultado_ejecucion = ref "" in
		let seguir = ref true in
		
		while (!seguir = true) do		
			if ((comandoReservado !comando_actual_programa) = true) then
				resultado_ejecucion := ejecutarComandoReservado contenedor
			else begin		
				if (((List.hd !comando_actual_programa) = "''") && ((List.hd (List.rev !comando_actual_programa)) = "''")) then
				begin
					let indice = ref 0 in
					
					while (!indice < (List.length !comando_actual_programa)) do
						if ((List.nth !comando_actual_programa !indice) <> "''") then
							resultado_ejecucion := !resultado_ejecucion ^ (List.nth !comando_actual_programa !indice);
						
						indice := !indice + 1;
					done; (* while *)
				end (* then *)
				else resultado_ejecucion := ejecutar_comando (contenedor, !comando_actual_programa);

				Funciones_comunes.guardar_operacion (!resultado_ejecucion, fichero_resultado_programa);
			end; (* else *)
			
			if (((entradaDatosPrograma !comando_actual_programa) = false) && ((estado_objecto mostrando_salida) = 0) && (!error_programa = 0)) then
			begin
				comando_actual_programa := obtenerComandoEjecutarPrograma programa_actual.contenido;
				
				if (!fin_programa = 0) then
					programa_actual.contenido <- avanzarPrograma programa_actual
				else begin
					programa_actual.contenido <- [];
					seguir := false;
				end (* else *)
			end (* then *)
			else seguir := false
		done; (* while *)

		if ((!fin_programa = 1) && ((List.length !comando_actual_programa) > 1) && (!error_programa = 0)) then
		begin	
			if ((comandoReservado !comando_actual_programa) = true) then
			begin
				aux := ejecutarComandoReservado contenedor;

				if (programa_actual.contenido <> []) then 
					ejecutar_programa contenedor
				else !aux
			end
			else ejecutar_comando (contenedor, !comando_actual_programa);
		end (* then *)
		else !resultado_ejecucion
;; (* function ejecutar_porgrama string list -> string *)

let sustituirValorProgramaOperacion =
(*
objectivo:
	se trata de asignar el valor resultado de la ejecucion de un programa a la operacion en la que se incluyo
*)
	function (comando, valor) ->
		let indice = ref 0 in
		let comando_aux = ref [] in
		while (!indice < (List.length comando)) do
			if ((List.nth comando !indice) = "Prog ") then
			begin
				comando_aux := !comando_aux @ [valor];
				
				indice := !indice + 2;
			end (* then *)
			else begin
				comando_aux := !comando_aux @ [(List.nth comando !indice)];
				
				indice := !indice + 1;
			end; (* else *)
		done; (* for *)
		
		!comando_aux
;; (* function sustituirValorProgramaOperacion string list * string -> string list*)

let pulsar_tecla =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor y una TECLA. Se almacena el estado
	actual de las teclas y segun la TECLA pulsada se hace una cosa u otra.
*)
	function (contenedor, tecla) ->
	begin
		if ((!modo_programacion = 2) &&
		    ((estado_objecto programa) = 0) &&
		    ((areaProgramaDisponible tecla.valor) = true) &&
		    ((esAreaPrograma tecla.valor) = true) ) then
		begin
			borrar_entrada contenedor;

			programa.contenido <- [tecla.valor];
			programa.id_widget <- anadir_elemento_pantalla (contenedor, programa, 250, 40, "P" ^ tecla.valor, "Courier 10");
		end (* then *)
		else if ((!modo_programacion = 3) &&
		    ((estado_objecto programa) = 0) &&
		    ((esAreaPrograma tecla.valor) = true) ) then
		begin
			Funciones_comunes.borrarFichero tecla.valor;

			eliminar_elemento_pantalla (contenedor, mode.widget);
			borrar_entrada contenedor;

			modo_operacion (contenedor, tres.mode);

			comando := [];
		end (* else *)
		else if ((!modo_programacion = 2) &&
		    ((estado_objecto programa) = 0) &&
		    ((areaProgramaDisponible tecla.valor) = false) &&
		    ((esAreaPrograma tecla.valor) = true) ) then
		begin
			borrar_entrada contenedor;

			programa.contenido <- cargarPrograma tecla.valor;
			aux := poner_comando (contenedor, linea_comandos, (obtener_expresion_valor (formar_comando programa.contenido)));
			aux := "";
			linea_comandos.contenido <- programa.contenido;

			programa.contenido <- [];
			programa.contenido <- [tecla.valor];
			programa.id_widget <- anadir_elemento_pantalla (contenedor, programa, 250, 40, "P" ^ (obtener_contenido programa), "Courier 10");
		end (* then *)
		else if (((!modo_programacion = 2) || (!modo_programacion = 3)) &&
			((estado_objecto programa) = 0) ) then
		begin
		end (* then *)
		else begin
			if ((!ejecutando_programa = 1) && (!introduciendo_datos_programa = 1)) then
			begin
				introduciendo_datos_programa := 0;
				borrar_entrada contenedor;
			end; (* then *)
			
			if ((eje_x.en_pantalla = true) || (eje_y.en_pantalla = true)) then
			begin
				ocultarGraficas (contenedor, grafica_A);
				ocultarGraficas (contenedor, grafica_B);
				ocultarGraficas (contenedor, grafica_C);

				ocultarGraficaBarras contenedor;

				ocultarEjes contenedor;

				if ((obtener_modo (obtener_contenido modo_funcionamiento)) = 15) then
					modo_operacion (contenedor, por.shift_mode)
				else if ((obtener_modo (obtener_contenido modo_funcionamiento)) = 16) then
					modo_operacion (contenedor, entre.shift_mode)
				else ();
			end (* then *)
			else ();

			let raiz_actual = ref [] in
			cambio_estado (operacion, 0);

			if ((estado_objecto ejecutar.widget) = 1) then
			begin
				cambio_estado (ejecutar.widget, 0);
				linea_comandos.contenido <- [];
				eliminar_elemento_pantalla (contenedor, linea_comandos)
			end (* then *)
			else ();

			if (((esOperando (obtener_contenido tecla.widget)) = false) && (!esRaiz = true)) then
			begin
				esRaiz := false;
				raiz_actual := (crear_raiz !comando);
				raices_comando := !raices_comando @ [!raiz_actual];
				aux := calcular_valor_raiz !raiz_actual;
				comando := cambiar_valor_comando (!comando, !aux);
			end; (* then *)

			match (obtener_contenido tecla.widget) with
			  "x" | "÷" | "+" | "-" | "EXP" | "EXE" | "->" | "²" ->
			  begin
				if ((estado_objecto linea_comandos) = 0) then
					if ((((obtener_contenido tecla.widget) = "²") && ((estado_objecto shift.widget) = 1)) ||
				   	   (((obtener_contenido tecla.widget) = "EXP") && ((estado_objecto shift.widget) = 1)) ||
				   	   (((obtener_contenido tecla.widget) = "->") && ((estado_objecto shift.widget) = 1) && (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) || ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14) || ((obtener_modo (obtener_contenido modo_funcionamiento)) = 15) || ((obtener_modo (obtener_contenido modo_funcionamiento)) = 16)) )   ||
					   (((obtener_contenido tecla.widget) = "x") && ((estado_objecto shift.widget) = 1) && (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) || ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14)) ) ||
					   (((obtener_contenido tecla.widget) = "-") && ((estado_objecto shift.widget) = 1) && (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) || ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14)) )   ||
					   (((obtener_contenido tecla.widget) = "+") && ((estado_objecto shift.widget) = 1) && (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) || ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14)) ) ||
					   (((obtener_contenido tecla.widget) = "÷") && ((estado_objecto shift.widget) = 1)) && (((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) || ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14)) ||
					   (((obtener_contenido tecla.widget) = "÷") && ((estado_objecto shift.widget) = 1)) ||
					   (((obtener_contenido tecla.widget) = "x") && ((estado_objecto shift.widget) = 1)) ||
					   (!rango_funcionamiento > 0) ) then
					begin
					end (* then *)
					else comando := !comando @ [poner_comando (contenedor, linea_comandos, (obtener_contenido valor_anterior.widget))]
				else ();

				anadir_comando (contenedor, tecla)
		  	end (* x ï¿½ + - EXP EXE ->  *)
			| _ -> anadir_comando (contenedor, tecla)
		end (* else *)
	end
;;(* function pulsar_tecla objecto * tecla -> unit *)

let es_grafica =
(*
objectivo:
	se pasa como parametro un STRING con el comando actual y se devuelve TRUE si el comando es para dibujar una grafica
	y FALSE en otro caso
*)
	function operacion ->
		if ((String.length operacion) > (String.length "Graph Y=")) then
			if ((String.sub operacion 0 (String.length "Graph Y=")) = "Graph Y=") then
				true
			else false
		else false
;; (* function es_grafica string -> bool *)

(*FIN	Funciones de tratamiento de la pantalla y sus componentes *)



(*INI parseador y manejo de STRING's de comandos *)
let iniciarGUI =
(*
objectivo:
	se pasa como parametro un WIDGET contenedor de los distintos objectos en pantalla y
	se establece el estado inicial del A.C.T.P. en funcion del valor anterior almacenado
*)
	function contenedor ->
		Sys.chdir ruta_local;

		borrar_entrada (contenedor);
		modo_operacion (contenedor, (obtener_valor_fichero fichero_ultimo_modo));

		cargarGrafica grafica_A;
		cargarGrafica grafica_B;
		cargarGrafica grafica_C;
;; (* function iniciarGUI unit -> unit *)
(*FIN parseador y manejo de STRING's de comandos *)
