type objeto = {
	mutable contenido: string list;
	mutable id_widget: Tk.tagOrId;
	mutable estado: int (* 0 -> no en uso; 1 -> en uso *)
};; (* type objeto *)

type tecla = {
	valor: string;
	shift: string;
	alpha: string;
	mode: string;
	shift_mode: string;
	hiperbola: string;
	shift_hiperbola: string;
	funcion_base_n: string;
	valor_base_n: string;
	widget: objeto;
};; (* type tecla *)

open Tk;;

let shift = {
	valor = "S";
	shift = "";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["S"];
		id_widget = (Id 0);
		estado = 0
	}
}
and alpha = {
	valor = "A";
	shift = "A";
	alpha = "LOCK";
	mode = "";
	hiperbola = "";
	shift_mode = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["A"];
		id_widget = (Id 0);
		estado = 0
	}
}
and prog = {
	valor = "Prog ";
	shift = "Goto";
	alpha = "''";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["Prog "];
		id_widget = (Id 0);
		estado = 0
	}
}
and izq = {
	valor = (String.make 1 (Char.chr 171));
	shift = "Lbl";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = [(String.make 1 (Char.chr 171))];
		id_widget = (Id 0);
		estado = 0
	}
}
and drcha = {
	valor = (String.make 1 (Char.chr 187));
	shift = "INS";
	alpha = "Value";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = [(String.make 1 (Char.chr 187))];
		id_widget = (Id 0);
		estado = 0
	}
}
and mode = {
	valor = "M";
	shift = "";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["1"];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		2. FILA de botones *)
and graph = {
	valor = "Graph Y=";
	shift = "Zoom Org";
	alpha = "@";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["Graph Y="];
		id_widget = (Id 0);
		estado = 0
	}
}
and range = {
	valor = "Range";
	shift = "Factor";
	alpha = "~";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["Range"];
		id_widget = (Id 0);
		estado = 0
	}
}
and trace = {
	valor = "Trace";
	shift = "Plot";
	alpha = "?";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["Trace"];
		id_widget = (Id 0);
		estado = 0
	}
}
and arriba = {
	valor = "Up";
	shift = "Line ";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["Up"];
		id_widget = (Id 0);
		estado = 0
	}
}
and abajo = {
	valor = "Down";
	shift = "X-Y";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["Down"];
		id_widget = (Id 0);
		estado = 0
	}
}
and gt = {
	valor = "G<->T";
	shift = "Cls";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["G<->T"];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		3. FILA de botones *)
and dos_puntos = {
	valor = ":";
	shift = "";
	alpha = "k";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "xnor";
	widget = {
		contenido = [":"];
		id_widget = (Id 0);
		estado = 0
	}
}
and eng = {
	valor = "ENG";
	shift = "->";
	alpha = "m";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "Not";
	valor_base_n = "xor";
	widget = {
		contenido = ["ENG"];
		id_widget = (Id 0);
		estado = 0
	}
}
and raiz_cuadrada = {
	valor = "Sqrt ";
	shift = "Int ";
	alpha = (String.make 1 (Char.chr 181));
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "Dec";
	valor_base_n = "d";
	widget = {
		contenido = ["Sqrt "];
		id_widget = (Id 0);
		estado = 0
	}
}
and cuadrado = {
	valor = "²";
	shift = "Frac ";
	alpha = "n";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "Hex";
	valor_base_n = "h";
	widget = {
		contenido = ["²"];
		id_widget = (Id 0);
		estado = 0
	}
}
and log = {
	valor = "log ";
	shift = "IO";
	alpha = "p";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "Bin";
	valor_base_n = "b";
	widget = {
		contenido = ["log "];
		id_widget = (Id 0);
		estado = 0
	}
}
and ln = {
	valor = "ln ";
	shift = "e";
	alpha = "f";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "Oct";
	valor_base_n = "o";
	widget = {
		contenido = ["ln "];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		4. FILA de botones *)
and inversa = {
	valor = "x-¹";
	shift = "!";
	alpha = "A";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "/A";
	valor_base_n = "";
	widget = {
		contenido = ["-¹"];
		id_widget = (Id 0);
		estado = 0
	}
}
and grados = {
	valor = "o , ,,";
	shift = "<-";
	alpha = "B";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "|B";
	valor_base_n = "";
	widget = {
		contenido = ["o , ,,"];
		id_widget = (Id 0);
		estado = 0
	}
}
and hiperbola = {
	valor = "hyp";
	shift = "";
	alpha = "C";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = (String.make 1 (Char.chr 162));
	valor_base_n = "";
	widget = {
		contenido = ["hyp"];
		id_widget = (Id 0);
		estado = 0
	}
}
and seno = {
	valor = "sin ";
	shift = "sin-¹ ";
	alpha = "D";
	mode = "";
	shift_mode = "";
	hiperbola = "sinh ";
	shift_hiperbola = "sinh-¹ ";
	funcion_base_n = "|D";
	valor_base_n = "";
	widget = {
		contenido = ["sin "];
		id_widget = (Id 0);
		estado = 0
	}
}
and coseno = {
	valor = "cos ";
	shift = "cos-¹ ";
	alpha = "E";
	mode = "";
	shift_mode = "";
	hiperbola = "cosh ";
	shift_hiperbola = "cosh-¹ ";
	funcion_base_n = "|E";
	valor_base_n = "";
	widget = {
		contenido = ["cos "];
		id_widget = (Id 0);
		estado = 0
	}
}
and tangente = {
	valor = "tan ";
	shift = "tan-¹ ";
	alpha = "F";
	mode = "";
	shift_mode = "";
	hiperbola = "tanh ";
	shift_hiperbola = "tanh-¹ ";
	funcion_base_n = "|F";
	valor_base_n = "";
	widget = {
		contenido = ["tan "];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		5. FILA de botones *)
and raices = {
	valor = "a b/c";
	shift = ""; (* "d/c" *)
	alpha = "G";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "Neg";
	valor_base_n = "";
	widget = {
		contenido = ["Â¬"];
		id_widget = (Id 0);
		estado = 0
	}
}
and desplazamiento_drch = {
	valor = "->";
	shift = "";
	alpha = "H";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "Scl";
	valor_base_n = "";
	widget = {
		contenido = ["->"];
		id_widget = (Id 0);
		estado = 0
	}
}
and parentesis_izq = {
	valor = "(";
	shift = ",";
	alpha = "I";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = ",";
	valor_base_n = "";
	widget = {
		contenido = ["("];
		id_widget = (Id 0);
		estado = 0
	}
}
and parentesis_drch = {
	valor = ")";
	shift = ";";
	alpha = "J";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = [")"];
		id_widget = (Id 0);
		estado = 0
	}
}
and potencia_y = {
	valor = "x^y";
	shift = "Abs ";
	alpha = "K";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "and";
	valor_base_n = "CL";
	widget = {
		contenido = ["x^y"];
		id_widget = (Id 0);
		estado = 0
	}
}
and raiz_x = {
	valor = "Sqrt(x) ";
	shift = "Sqrt(3) ";
	alpha = "L";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "or";
	valor_base_n = "DT";
	widget = {
		contenido = ["Sqrt(x) "];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		6. FILA de botones *)
and siete = {
	valor = "7";
	shift = "=>";
	alpha = "M";
	mode = "Fix ";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "A.";
	valor_base_n = "";
	widget = {
		contenido = ["7"];
		id_widget = (Id 0);
		estado = 0
	}
}
and ocho = {
	valor = "8";
	shift = "=";
	alpha = "N";
	mode = "Sci ";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "B.";
	valor_base_n = "";
	widget = {
		contenido = ["8"];
		id_widget = (Id 0);
		estado = 0
	}
}
and nueve = {
	valor = "9";
	shift = "<>";
	alpha = "O";
	mode = "Norm";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "r.";
	valor_base_n = "";
	widget = {
		contenido = ["9"];
		id_widget = (Id 0);
		estado = 0
	}
}
and delete = {
	valor = "DEL";
	shift = "Mcl";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["DEL"];
		id_widget = (Id 0);
		estado = 0
	}
}
and ac = {
	valor = "AC";
	shift = "OFF";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["AC"];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		7. FILA de botones *)
and cuatro = {
	valor = "4";
	shift = "Isz";
	alpha = "P";
	mode = "Deg";
	shift_mode = "o";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "/y";
	valor_base_n = "";
	widget = {
		contenido = ["4"];
		id_widget = (Id 0);
		estado = 0
	}
}
and cinco = {
	valor = "5";
	shift = ">=";
	alpha = "Q";
	mode = "Rad";
	shift_mode = "r";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = ("yøn");
	valor_base_n = "";
	widget = {
		contenido = ["5"];
		id_widget = (Id 0);
		estado = 0
	}
}
and seis = {
	valor = "6";
	shift = "=<";
	alpha = "R";
	mode = "Gra";
	shift_mode = "g";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = ("yøn-¹");
	valor_base_n = "";
	widget = {
		contenido = ["6"];
		id_widget = (Id 0);
		estado = 0
	}
}
and por = {
	valor = "x";
	shift = "ZoomXf";
	alpha = "S";
	mode = "SD1";
	shift_mode = "SD2";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "^x";
	valor_base_n = "";
	widget = {
		contenido = ["x"];
		id_widget = (Id 0);
		estado = 0
	}
}
and entre = {
	valor = "÷";
	shift = "ZoomX1/f";
	alpha = "T";
	mode = "LR1";
	shift_mode = "LR2";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "^y";
	valor_base_n = "";
	widget = {
		contenido = ["÷"];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		8. FILA de botones *)
and uno = {
	valor = "1";
	shift = "Dsz";
	alpha = "U";
	mode = "RUN";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "/x";
	valor_base_n = "";
	widget = {
		contenido = ["1"];
		id_widget = (Id 0);
		estado = 0
	}
}
and dos = {
	valor = "2";
	shift = ">";
	alpha = "V";
	mode = "WRT";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "xøn";
	valor_base_n = "";
	widget = {
		contenido = ["2"];
		id_widget = (Id 0);
		estado = 0
	}
}
and tres = {
	valor = "3";
	shift = "<";
	alpha = "W";
	mode = "PCL";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = ("xøn-¹");
	valor_base_n = "";
	widget = {
		contenido = ["3"];
		id_widget = (Id 0);
		estado = 0
	}
}
and mas = {
	valor = "+";
	shift = "Pol(";
	alpha = "X";
	mode = "COMP";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["+"];
		id_widget = (Id 0);
		estado = 0
	}
}
and menos = {
	valor = "-";
	shift = "Rec(";
	alpha = "Y";
	mode = "BASE-N";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["-"];
		id_widget = (Id 0);
		estado = 0
	}
}
(*		9. FILA de botones *)
and cero = {
	valor = "0";
	shift = "Rnd";
	alpha = "Z";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["0"];
		id_widget = (Id 0);
		estado = 0
	}
}
and punto = {
	valor = ".";
	shift = "Ran#";
	alpha = "[";
	mode = "Defm ";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["."];
		id_widget = (Id 0);
		estado = 0
	}
}
and exponente = {
	valor = "EXP";
	shift = "n";
	alpha = "]";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["EXP"];
		id_widget = (Id 0);
		estado = 0
	}
}
and valor_anterior = {
	valor = "Ans";
	shift = "-";
	alpha = " ";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["Ans"];
		id_widget = (Id 0);
		estado = 0
	}
}
and ejecutar = {
	valor = "EXE";
	shift = "";
	alpha = "";
	mode = "";
	shift_mode = "";
	hiperbola = "";
	shift_hiperbola = "";
	funcion_base_n = "";
	valor_base_n = "";
	widget = {
		contenido = ["EXE"];
		id_widget = (Id 0);
		estado = 0
	}
};;

(*	entrada de datos a la calculadora *)
let linea_comandos = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
(*	almacenamiento en memorias auxiliares *)
and almacenar = ref false
and resultado_aux = ref ""
(*	almacenar el ultimo comando ejecutado *)
and comando = ref [""]
and operacion = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
(*	manejar el modo de funcionamiento *)
and modo_funcionamiento = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
and mode_base = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
and operacion_cambio_modo = ref false (* indica si se esta realizando un cambio de modo *)
and numero_decimales = ref "8" (* decimales por defecto *)
(*	para controlar la escritura en pantalla *)
and posicion_pantalla = ref 1 (* numero de caracteres escritos en pantalla *)
and longitud_maxima_comando_pantalla = 26 (* el numero maximo de elementos a presentar en la pantalla *)
(*	variable auxiliar para corregir Warnings *)
and aux = ref ""
(*	variables para el calculo con raices *)
and esRaiz = ref false
and calcularRaices = ref false
and raices_comando = ref [[""]]
and raiz_actual = ref [""]
and conversiones = ref 0
(*	ruta del los ficheros de configuracion *)
and ruta_local = "/tmp/.actp/"
and tipo_ficheros_datos = ".actp"
(* ficheros de uso interno *)
and fichero_ultimo_resultado = "last"
and fichero_ultimo_modo = "mode"
and fichero_ultimo_modo_base = "mode_base"
and fichero_ultima_operacion = "operacion"
and fichero_ultimo_comando = "comando"
and fichero_desviacion_estandar = "desviacion_estandar"
and fichero_regresion_x = "regresion_x"
and fichero_regresion_y = "regresion_y"
and fichero_estadistica_una = "estadisticas_una"
and fichero_estadistica_una_frecuencia = "estadisticas_una_frecuencia"
and fichero_estadistica_dos_x = "estadisticas_dos_x"
and fichero_estadistica_dos_y = "estadisticas_dos_y"
;;

type grafica = {
	mutable segmentos: Tk.tagOrId list;
	mutable puntos: (float * float) list;
	mutable existe: bool;
	mutable en_pantalla: bool;
	fichero_x: string;
	fichero_y: string;
};; (* type grafica *)

let grafica_A = {
	segmentos = [];
	puntos = [];
	existe = false;
	en_pantalla = false;
	fichero_x = "graficaax";
	fichero_y = "graficaay";
}
and grafica_B = {
	segmentos = [];
	puntos = [];
	existe = false;
	en_pantalla = false;
	fichero_x = "graficabx";
	fichero_y = "graficaby";
}
and grafica_C = {
	segmentos = [];
	puntos = [];
	existe = false;
	en_pantalla = false;
	fichero_x = "graficacx";
	fichero_y = "graficacy";
}
and eje_x = {
	segmentos = [];
	puntos = [];
	existe = false;
	en_pantalla = false;
	fichero_x = "ejexx";
	fichero_y = "ejexy";
}
and eje_y = {
	segmentos = [];
	puntos = [];
	existe = false;
	en_pantalla = false;
	fichero_x = "ejeyx";
	fichero_y = "ejeyx";
}
and grafica_barras = {
	segmentos = [];
	puntos = [];
	existe = false;
	en_pantalla = false;
	fichero_x = "graficabarrasx";
	fichero_y = "graficabarrasy";
}
;;

let xscl = ref (1.0)
and xmin = ref (-5.0)
and xmax = ref (5.0)
and ymin = ref (-5.0)
and ymax = ref (5.0)
and yscl = ref (1.0)
and xfact = ref (1.0)
and yfact = ref (1.0)
and rango = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
and rango_funcionamiento = ref 0
and grafica_max = ref (30.0)
and grafica_min = ref (0.0)
and grafica_xscl = ref (1.0)
and grafica_yscl = ref (1.0)
and grafica_zoomx = ref (1.0)
and grafica_zoomy = ref (1.0)
and tipo_desplazamiento = ref 0 (* 1, 2, 3, 4*)
and longitud_desplazamiento = 20.0 (* un desplazamiento de 20 Millimeters *)
and infinito = (0.0 ** (-1.0))
and maximo_numero_programas = 10
and modo_programacion = ref 0
and programa = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
and programa_actual = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
and ejecutando_programa = ref 0
and fin_programa = ref 0
and memoria_actual_programa = ref ""
and almacenando_memoria_programa = ref 0
and introduciendo_datos_programa = ref 0
and resultado_programa = ref ""
and comando_actual_programa = ref [""]
and fichero_resultado_programa = "resultado_programa"
and mostrar_grafica_programa = ref 0
and error_programa = ref 0
and mostrando_salida = {
	contenido = [];
	id_widget = (Id 0);
	estado = 0
}
and comando_ejecucion = ref [""]
;;
(* modulo de tipos y teclas *)
