/* Archivo parser.mly */
%token <float> FLOAT
%token	LOG10
	LOGN 
	CUADRADO
	RAIZ
	INVERSA
	SENO
	COSENO
	TANGENTE
	SENOI
	COSENOI
	TANGENTEI
	EXPONENCIACION
	RAIZ_CUBICA
	RAIZ_X
	VALOR_ABSOLUTO
	SENOH
	COSENOH
	TANGENTEH 
	SENOHI
	COSENOHI
	TANGENTEHI
	E
	IO
	FACTORIAL
	PARTE_ENTERA
	PARTE_REAL
	RANDOM
	DESVIACION_ESTANDAR_TODOS
	DESVIACION_ESTANDAR_MUESTRA
	MEDIA_ARITMETICA
	VACIAR_DATOS_ESTADISTICOS
	REGRESION_X
	REGRESION_Y
	CONSTANTE_REGRESION
	COEFICIENTE_REGRESION
	COEFICIENTE_CORRELACION
	PI
	HA
	HB
	HC
	HD
	HE
	HF
	DR
	RR
	GR
	DD
	RD
	GD
	DG
	RG
	GG
	PLUS
	MINUS
	TIMES
	DIV
	IGUAL
	MAYOR_IGUAL
	MENOR_IGUAL
	DISTINTO
	MENOR
	MAYOR
%token LPAREN RPAREN
%token EOL
%left	PLUS
	MINUS					/* lowest precedence */
	IGUAL
	MAYOR_IGUAL
	MENOR_IGUAL
	DISTINTO
	MENOR
	MAYOR	
%left	PI
	RAIZ
	INVERSA
	SENO
	COSENO
	TANGENTE
	SENOI
	COSENOI
	TANGENTEI
	RAIZ_CUBICA
	RAIZ_X
	VALOR_ABSOLUTO
	SENOH
	COSENOH
	TANGENTEH
	SENOHI 
	COSENOHI
	TANGENTEHI
	DESVIACION_ESTANDAR_TODOS
	DESVIACION_ESTANDAR_MUESTRA
	MEDIA_ARITMETICA
	VACIAR_DATOS_ESTADISTICOS
	REGRESION_X
	REGRESION_Y
	CONSTANTE_REGRESION
	COEFICIENTE_REGRESION
	COEFICIENTE_CORRELACION
	E
	IO
	HA
	HB
	HC
	HD
	HE
	HF
	DR
	RR
	GR
	DD
	RD
	GD
	DG
	RG
	GG
	FACTORIAL
	RANDOM
	PARTE_ENTERA
	PARTE_REAL
	LOG10
	LOGN
	TIMES
	DIV	 			/* medium precedence */
%nonassoc UMINUS			/* highest precedence */
	EXPONENCIACION
	CUADRADO			
%start main				/* the entry point */
%type <float> main
%%
main:
	expr EOL				{ $1 }
;
expr:
	  FLOAT					{ $1 }
	| LPAREN expr RPAREN			{ $2 }
	| LOG10 expr				{ log10 $2 }
	| LOGN expr				{ log $2 }
	| expr CUADRADO				{ $1 ** 2.0 }
	| RAIZ expr				{ sqrt $2 }
	| expr INVERSA				{ 1.0 /. $1 }
	| SENO expr				{ sin $2 }
	| COSENO expr				{ cos $2 }
	| TANGENTE expr				{ tan $2 }
	| SENOI expr				{ asin $2 }
	| COSENOI expr				{ acos $2 }
	| TANGENTEI expr			{ atan $2 }
	| SENOH expr				{ sinh $2 }
	| COSENOH expr				{ cosh $2 }
	| TANGENTEH expr			{ tanh $2 }
	| SENOHI expr				{ 1.0 /. (sinh $2) }
	| COSENOHI expr				{ 1.0 /. (cosh $2) }
	| TANGENTEHI expr			{ 1.0 /. (tanh $2) }
	| E expr				{ 2.718281828459045235360287471352662497757247093699959574966967627724076630353547594571382178525166427 ** $2 }
	| PI					{ 3.1415926535897932384626433832795 }
	| expr DR				{ ($1 *. 180.0) /. 3.1415926535897932384626433832795 }
	| expr GR				{ ($1 *. 0.9) /. (180.0 /. 3.1415926535897932384626433832795) }
	| expr RD				{ ($1 *. 3.1415926535897932384626433832795) /. 180.0 }
	| expr GD				{ $1 *. 0.9 }
	| expr RR				{ $1 }
	| expr DD				{ $1 }
	| expr GG				{ $1 }
	| expr DG				{ $1 /. 0.9 }
	| expr RG				{ (($1 *. 3.1415926535897932384626433832795) /. 180.0) /. 0.9 }
	| HA					{ 10.0 }	
	| HB					{ 11.0 }
	| HC					{ 12.0 }	
	| HD					{ 13.0 }	
	| HE					{ 14.0 }	
	| HF					{ 15.0 }	
	| DESVIACION_ESTANDAR_TODOS		{ Funciones_comunes.desviacion_estandar ("desviacion_estandar", 0) }
	| DESVIACION_ESTANDAR_MUESTRA		{ Funciones_comunes.desviacion_estandar ("desviacion_estandar", 1) }
	| MEDIA_ARITMETICA			{ Funciones_comunes.media_aritmetica "desviacion_estandar" }
	| VACIAR_DATOS_ESTADISTICOS		{ Funciones_comunes.vaciar_datos "desviacion_estandar" +. Funciones_comunes.vaciar_datos "regresion_x" +. Funciones_comunes.vaciar_datos "regresion_y" +. Funciones_comunes.vaciar_datos "estadisticas_una" +. Funciones_comunes.vaciar_datos "estadisticas_una_frecuencia" +. Funciones_comunes.vaciar_datos "estadisticas_dos_x" +. Funciones_comunes.vaciar_datos "estadisticas_dos_y" }
	| expr REGRESION_X			{ ($1 -. (Funciones_comunes.termino_constante_regresion ("regresion_x", "regresion_y"))) /. (Funciones_comunes.coeficiente_regresion ("regresion_x", "regresion_y")) }
	| expr REGRESION_Y			{ (Funciones_comunes.termino_constante_regresion ("regresion_x", "regresion_y")) +. ((Funciones_comunes.coeficiente_regresion ("regresion_x", "regresion_y")) *. $1) }
	| CONSTANTE_REGRESION			{ Funciones_comunes.termino_constante_regresion ("regresion_x", "regresion_y") }
	| COEFICIENTE_REGRESION			{ Funciones_comunes.coeficiente_regresion ("regresion_x", "regresion_y") }
	| COEFICIENTE_CORRELACION		{ Funciones_comunes.coeficiente_correlacion ("regresion_x", "regresion_y") }
	| IO expr				{ 10.0 ** $2 }
	| expr FACTORIAL			{ let rec factorial = function valor -> if (valor = 0.0) then 1.0 else valor *. (factorial (valor -. 1.0)) in factorial $1 }
	| expr EXPONENCIACION expr		{ $1 ** $3 }
	| RAIZ_CUBICA expr			{ $2 ** (1.0 /. 3.0) }
	| expr RAIZ_X expr			{ $3 ** (1.0 /. $1) }
	| VALOR_ABSOLUTO expr			{ abs_float ($2) }
	| RANDOM				{ let randomize = function () -> Random.self_init (); let aux = ref 0.0 in aux := Random.float 1.0; !aux in randomize () }
	| PARTE_ENTERA expr			{ floor $2 }
	| PARTE_REAL expr			{ let parte_real = function valor -> (valor -. (floor valor)) in parte_real $2 }
	| expr PLUS expr			{ $1 +. $3 }
	| expr MINUS expr			{ $1 -. $3 }
	| expr TIMES expr			{ $1 *. $3 }
	| expr DIV expr				{ $1 /. $3 }
	| MINUS expr %prec UMINUS		{ -. $2 }
	| expr IGUAL expr			{ if ($1 = $3) then 1.0 else 0.0 }
	| expr MAYOR_IGUAL expr			{ if ($1 >= $3) then 1.0 else 0.0 }	
	| expr MENOR_IGUAL expr			{ if ($1 <= $3) then 1.0 else 0.0 }	
	| expr DISTINTO expr			{ if ($1 <> $3) then 1.0 else 0.0 }		
	| expr MENOR expr			{ if ($1 < $3) then 1.0 else 0.0 }
	| expr MAYOR expr			{ if ($1 > $3) then 1.0 else 0.0 }
;
