open Definiciones;;

(*INI funciones utiles *)
let salida_por_pantalla =
	function cadena ->
		print_newline ();
		print_string ("-" ^ cadena ^ "-");
		print_newline ();
;;
(*FIN funciones utiles *)

(*INI modulo Funciones_estadisticas *)
let media_aritmetica =
(*
OBJETIVO:
	se realiza el calculo de la media aritmetica para una serie de datos especificados con anterioridad
*)
	function fichero_datos_estadisticos ->
		if (Sys.file_exists (ruta_local ^ fichero_datos_estadisticos ^ tipo_ficheros_datos)) then
		begin
			let id_fichero = open_in (ruta_local ^ fichero_datos_estadisticos ^ tipo_ficheros_datos) in
			let resultado = ref 0.0 in
			let contador = ref 0.0 in
			let seguir = ref true in

			while (!seguir = true) do
				try
					let valor_actual = input_line id_fichero in
						resultado := !resultado +. (float_of_string valor_actual);
					contador := !contador +. 1.0;
				with End_of_file -> seguir := false;
			done; (* while *)

			close_in id_fichero;
			resultado := !resultado /. !contador;

			!resultado
		end (* then *)
		else nan
;; (* media_aritmetica string -> float *)


let desviacion_estandar  =
(*
OBJETIVO:
	se realiza el calculo de la desviacion estandar para una serie de datos especificados con anterioridad
*)
	function (fichero_datos_estadisticos, tipo_desviacion) ->
		let media = (media_aritmetica fichero_datos_estadisticos) in
		if (media <> nan) then
		begin
			let id_fichero = open_in (ruta_local ^ fichero_datos_estadisticos ^ tipo_ficheros_datos) in
			let resultado = ref 0.0 in
			let contador = ref 0.0 in
			let seguir = ref true in
			while (!seguir = true) do
				try
					let valor_actual = input_line id_fichero in
						resultado := !resultado +. (((float_of_string valor_actual) -. media) ** 2.0);
					contador := !contador +. 1.0;
				with End_of_file -> seguir := false;
			done; (* while *)

			close_in id_fichero;
			if (tipo_desviacion = 0) then
				resultado := sqrt (!resultado /. !contador)
			else resultado := sqrt (!resultado /. (!contador -. 1.0));

			!resultado
		end
		else nan
;; (* desviacion_estandar_todos string -> float *)


let vaciar_datos =
(*
OBJETIVO:
	realizar la operacion de limpieza de memorias de tabulacion, es decir,
	en los modos SD1 y LR1 hacer una operacion de Scl
*)
	function fichero_datos_estadisticos ->
		if (Sys.file_exists (ruta_local ^ fichero_datos_estadisticos ^ tipo_ficheros_datos)) then
			Sys.remove (ruta_local ^ fichero_datos_estadisticos ^ tipo_ficheros_datos)
		else ();
		let id_fichero = open_out (ruta_local ^ fichero_datos_estadisticos ^ tipo_ficheros_datos) in
			flush id_fichero;
			close_out id_fichero;
			0.0
;; (* vaciar_datos string -> string *)

let datos_regresion_correctos =
(*
OBJETIVO:
	comprueba los datos para el calculo de regresiones y devuelve el numero de datos a tratar
*)
	function (fichero_regresion_x, fichero_regresion_y) ->
		let aux = ref 0 in
		let numero_datos = ref 0 in
		if ((Sys.file_exists (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos)) &&  (Sys.file_exists (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos))) then
		begin
			let id_fichero = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in
				let seguir = ref true in
				while (!seguir = true) do
					try
						let valor_actual = input_line id_fichero in
						aux := !aux + 1;
					with End_of_file -> seguir := false;
				done; (* while *)
				numero_datos := !aux;
				close_in id_fichero;
			aux := 0;
			let id_fichero = open_in (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos) in
				let seguir = ref true in
				while (!seguir = true) do
					try
						let valor_actual = input_line id_fichero in
						aux := !aux + 1;
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero;
			if (!numero_datos = !aux) then
				float_of_int !numero_datos
			else 0.0
		end (* then *)
		else 0.0
;; (* function datos_regresion_correctos unit -> int *)

let coeficiente_regresion =
(*
OBJETIVO:
	se realiza el calculo del coeficiente de regresion de la formula de regresion
*)
	function (fichero_regresion_x, fichero_regresion_y) ->
		let n = (datos_regresion_correctos (fichero_regresion_x, fichero_regresion_y)) in
		if (n > 0.0) then
		begin
			let sumatorio_producto = ref 0.0 in
				let id_fichero_x = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in
				let id_fichero_y = open_in (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let x = input_line id_fichero_x in
						let y = input_line id_fichero_y in
							sumatorio_producto := !sumatorio_producto +. ((float_of_string x) *. (float_of_string y));
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;
				close_in id_fichero_y;
			let sumatorio_x = ref 0.0 in
				let id_fichero_x = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let x = input_line id_fichero_x in
							sumatorio_x := !sumatorio_x +. (float_of_string x);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;
			let cuadrado_sumatorio_x = (!sumatorio_x ** 2.0) in
			let sumatorio_y = ref 0.0 in
				let id_fichero_y = open_in (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let y = input_line id_fichero_y in
							sumatorio_y := !sumatorio_y +. (float_of_string y);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_y;
			let sumatorio_cuadrados_x = ref 0.0 in
				let id_fichero_x = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let x = input_line id_fichero_x in
							sumatorio_cuadrados_x := !sumatorio_cuadrados_x +. ((float_of_string x) ** 2.0);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;

			((n *. !sumatorio_producto) -. (!sumatorio_x *. !sumatorio_y)) /. ((n *. !sumatorio_cuadrados_x) -. cuadrado_sumatorio_x)
		end (* then *)
		else nan
;; (* function coeficiente_regresion string * string -> float *)

let termino_constante_regresion =
(*
OBJETIVO:
	se realiza el calculo del termino constante de regresion de la formula de regresion
*)
	function (fichero_regresion_x, fichero_regresion_y) ->
		let n = (datos_regresion_correctos (fichero_regresion_x, fichero_regresion_y)) in
		if (n > 0.0) then
		begin
			let sumatorio_x = ref 0.0 in
				let id_fichero_x = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let x = input_line id_fichero_x in
							sumatorio_x := !sumatorio_x +. (float_of_string x);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;
			let sumatorio_y = ref 0.0 in
				let id_fichero_y = open_in (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let y = input_line id_fichero_y in
							sumatorio_y := !sumatorio_y +. (float_of_string y);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_y;
			let coeficiente_B = (coeficiente_regresion (fichero_regresion_x, fichero_regresion_y)) in

			((!sumatorio_y -. (coeficiente_B *. !sumatorio_x)) /. n)
		end (* then *)
		else nan
;; (* function termino_constante_regresion string * string -> float*)

let coeficiente_correlacion =
(*
OBJETIVO:
	se realiza el calculo del coeficiente de correlacion de regresion de la formula de regresion
*)
	function (fichero_regresion_x, fichero_regresion_y) ->
		let n = (datos_regresion_correctos (fichero_regresion_x, fichero_regresion_y)) in
		if (n > 0.0) then
		begin
			let sumatorio_producto = ref 0.0 in
				let id_fichero_x = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in
				let id_fichero_y = open_in (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let x = input_line id_fichero_x in
						let y = input_line id_fichero_y in
							sumatorio_producto := !sumatorio_producto +. ((float_of_string x) *. (float_of_string y));
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;
				close_in id_fichero_y;
			let sumatorio_x = ref 0.0 in
				let id_fichero_x = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let x = input_line id_fichero_x in
							sumatorio_x := !sumatorio_x +. (float_of_string x);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;
			let cuadrado_sumatorio_x = (!sumatorio_x ** 2.0) in
			let sumatorio_y = ref 0.0 in
				let id_fichero_y = open_in (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let y = input_line id_fichero_y in
							sumatorio_y := !sumatorio_y +. (float_of_string y);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_y;
			let cuadrado_sumatorio_y = (!sumatorio_y ** 2.0) in
			let sumatorio_cuadrados_x = ref 0.0 in
				let id_fichero_x = open_in (ruta_local ^ fichero_regresion_x ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let x = input_line id_fichero_x in
							sumatorio_cuadrados_x := !sumatorio_cuadrados_x +. ((float_of_string x) ** 2.0);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_x;
			let sumatorio_cuadrados_y = ref 0.0 in
				let id_fichero_y = open_in (ruta_local ^ fichero_regresion_y ^ tipo_ficheros_datos) in

				let seguir = ref true in
				while (!seguir = true) do
					try
						let y = input_line id_fichero_y in
							sumatorio_cuadrados_y := !sumatorio_cuadrados_y +. ((float_of_string y) ** 2.0);
					with End_of_file -> seguir := false;
				done; (* while *)
				close_in id_fichero_y;

			((n *. !sumatorio_producto) -. (!sumatorio_x *. !sumatorio_y)) /. (sqrt (((n *. !sumatorio_cuadrados_x) -. cuadrado_sumatorio_x) *. ((n *. !sumatorio_cuadrados_y) -. cuadrado_sumatorio_y)))
		end (* then *)
		else nan
;; (* function coeficiente_correlacion string * string -> float *)
(*FIN modulo Funciones_estadisticas *)

(*INI funciones comunes *)
let borrarFichero =
(*
objectivo:
	eliminar un fichero de los de memorias
*)
	function fichero ->
		if (Sys.file_exists (ruta_local ^ fichero ^ tipo_ficheros_datos)) then
			Sys.remove (ruta_local ^ fichero ^ tipo_ficheros_datos)
		else ();
;; (* function borrarFichero string -> unit *)

let guardar_operacion =
(* solo se guardara el resultado de la ultima operacion, cualquier otra anterior se elimina *)
(*
objectivo:
	se pasa como parametro un STRING con texto (comando, resultado, valor) y otro
	STRING con un nombre de fichero, con lo que se almacena el texto en el fichero indicado.
	Si ya existia el fichero antes, se elimina antes para almacenar solo el texto.
*)
	function (cadena, fichero) ->
		if (Sys.file_exists (ruta_local ^ fichero ^ tipo_ficheros_datos)) then
			Sys.remove (ruta_local ^ fichero ^ tipo_ficheros_datos)
		else ();
		let id_fichero = open_out (ruta_local ^ fichero ^ tipo_ficheros_datos) in
			output_string id_fichero cadena;
			flush id_fichero;
			close_out id_fichero;
;; (* guardar_operacion cadena *)

let anadir_dato_estadistico =
(*
objectivo:
	almacenar en fichero para proximas utilizaciones los datos estadisticos que se van introduciendo
*)
	function (cadena, fichero) ->
		if (Sys.file_exists (ruta_local ^ fichero ^ tipo_ficheros_datos)) then
		begin
			let id_fichero = open_out_gen [Open_wronly; Open_append] 700 (ruta_local ^ fichero ^ tipo_ficheros_datos) in
				output_string id_fichero (cadena ^ "\n");
				flush id_fichero;
				close_out id_fichero;
		end (* then *)
		else begin
			let id_fichero = open_out (ruta_local ^ fichero ^ tipo_ficheros_datos) in
				output_string id_fichero (cadena ^ "\n");
				flush id_fichero;
				close_out id_fichero;
		end; (* else *)
;; (* anadir_dato_estadistico string * string -> unit *)

let obtener_valor_memoria =
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
					anterior;
			with End_of_file -> "0"
		else fichero
;; (* function obtener_valor_memoria string -> string *)
(*FIN funciones comunes *)