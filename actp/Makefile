ejecutar:	compilar
	actp

compilar:
	ocamlc -verbose -I +camltk -c definiciones.ml
	ocamlc -verbose -c funciones_comunes.ml
	ocamllex lexer.mll
	ocamlyacc parser.mly
	ocamlc -verbose -c parser.mli
	ocamlc -verbose -c lexer.ml
	ocamlc -verbose -c parser.ml
	ocamlc -verbose -I +camltk -c funciones.ml
	ocamlc -verbose -I +camltk -c actp.ml
	ocamlc -verbose -o actp -I +camltk -custom camltk.cma lexer.cmo definiciones.cmo funciones_comunes.cmo parser.cmo funciones.cmo actp.cmo
	@echo
	@echo
	@echo "                          COMPILACION TERMINADA"
	@echo
	@echo

limpiar:
	rm -rf *.cm*
	rm -rf lexer.ml parser.ml parser.mli
	@echo
	@echo
	@echo "                          LIMPIEZA TERMINADA"
	@echo
	@echo

instalar:	compilar limpiar
	./preparar_sistema.sh
	@echo
	@echo
	@echo "                          INSTALACION TERMINADA"
	@echo
	@echo


desinstalar:	limpiar
	./desinstalar.sh
	@echo
	@echo
	@echo "                          DESINSTALACION TERMINADA"
	@echo
	@echo
