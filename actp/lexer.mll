(* Archivo lexer.mll *)
{
open Parser	(* El tipo de token esta definido en parser.mly *)
exception Eof
}
rule token = parse
  [' ' '\t']		{ token lexbuf }	(* se eliminan los espacios en blanco *)
| ['\n']		{ EOL }
| ['0'-'9' '.']+	{ FLOAT(float_of_string (Lexing.lexeme lexbuf)) }
| '+'			{ PLUS }
| '-'			{ MINUS }
| 'x'			{ TIMES }
| "="			{ IGUAL }
| ">="			{ MAYOR_IGUAL }
| "<="			{ MENOR_IGUAL }
| "<>"			{ DISTINTO }
| "<"			{ MENOR }
| ">"			{ MAYOR }
| "Scl"			{ VACIAR_DATOS_ESTADISTICOS }
| "x�n"			{ DESVIACION_ESTANDAR_TODOS } 
| "x�n-�"		{ DESVIACION_ESTANDAR_MUESTRA }
| "/x"			{ MEDIA_ARITMETICA }
| "^x"			{ REGRESION_X }
| "^y"			{ REGRESION_Y }
| "r."			{ COEFICIENTE_CORRELACION }
| "A."			{ CONSTANTE_REGRESION }
| "B."			{ COEFICIENTE_REGRESION }
| "|A"			{ HA }
| "|B"			{ HB }
| "|C"			{ HC }
| "|D"			{ HD }
| "|E"			{ HE }
| "|F"			{ HF }
| "dr"			{ DR }
| "rr"			{ RR }
| "gr"			{ GR }
| "dd"			{ DD }
| "rd"			{ RD }
| "gd"			{ GD }
| "dg"			{ DG }
| "rg"			{ RG }
| "gg"			{ GG }
| "�"			{ DIV }
| "log "		{ LOG10 }
| "ln "			{ LOGN }
| "�"			{ CUADRADO }
| "Sqrt "		{ RAIZ }
| "-�"			{ INVERSA }
| "sin "		{ SENO }
| "cos "		{ COSENO }
| "tan "		{ TANGENTE }
| "sin-� "		{ SENOI }
| "cos-� "		{ COSENOI }
| "tan-� "		{ TANGENTEI }
| "sinh "		{ SENOH }
| "cosh "		{ COSENOH }
| "tanh "		{ TANGENTEH }
| "sinh-� "		{ SENOHI }
| "cosh-� "		{ COSENOHI }
| "tanh-� "		{ TANGENTEH }
| "x^y"			{ EXPONENCIACION }
| "Sqrt(x) "		{ RAIZ_X }
| "Sqrt(3) "		{ RAIZ_CUBICA }
| "Abs "		{ VALOR_ABSOLUTO }
| 'e'			{ E }
| "IO"			{ IO }
| '!'			{ FACTORIAL }
| "Ran#"		{ RANDOM }
| "Int "		{ PARTE_ENTERA }
| "Frac "		{ PARTE_REAL }
| 'n'			{ PI }
| '('			{ LPAREN }
| ')'			{ RPAREN }
| eof			{ raise Eof }
