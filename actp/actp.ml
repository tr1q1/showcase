open Tk;;
open Definiciones;;
open Funciones_comunes;;
open Funciones;;

(*		GUI de la calculadora, asi como las operaciones directamente aplicables *)
let main () =
(*  --	Definicion de la Form donde se representara la calculadora *)
	let form_principal = openTk () in

(*  --	Definicion de la pantalla de la calculadora *)
	let marco_pantalla_principal = Frame.create form_principal [Background Black] in
		let marco_pantalla = Frame.create form_principal [Width (Pixels 315); Height (Pixels 100); BorderWidth (Pixels 5); Background Black] in
			let pantalla = Canvas.create form_principal [Width (Pixels 313); Height (Pixels 98); Relief Raised] in

		let marco_informacion = Frame.create form_principal [Width (Pixels 300); Height (Pixels 40); Background Black; BorderWidth (Pixels 5)] in
			let frame_mode = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
				let lmode = Label.create form_principal [Text "MODE "; Font "15"; Width (Pixels 17); Height (Pixels 5); Background Black; Foreground White; Relief Raised] in

				let linea_informacion1 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 1)] in
					let run = Label.create form_principal [Text "  1 RUN "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let wrt = Label.create form_principal [Text "  2 WRT "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let pcl = Label.create form_principal [Text "  3 PCL "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let deg = Label.create form_principal [Text "  4 Deg "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let rad = Label.create form_principal [Text "  5 Rad "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in

				let linea_informacion2 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 1)] in

					let gra = Label.create form_principal [Text  "  6 Gra "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let fix = Label.create form_principal [Text  "  7 Fix "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let sci = Label.create form_principal [Text  "  8 Sci "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let norm = Label.create form_principal [Text "  9 Norm"; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let comp = Label.create form_principal [Text "  + COMP"; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in

				let linea_informacion3 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 1)] in
					let base_n = Label.create form_principal [Text "- BASE-N"; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let sd1 = Label.create form_principal [Text    "  X SD1 "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let lr1 = Label.create form_principal [Text    "  % LR1 "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let defm = Label.create form_principal [Text   "   Defm"; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
					let cont = Label.create form_principal [Text   "  = CONT"; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in

			let linea_informacion4 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
				let shift_mode = Label.create form_principal [Text "SHIFT  MODE  "; Font "5"; Width (Pixels 17); Background Black; Foreground White; Relief Raised] in
				let lgrados = Label.create form_principal [Text   "   4 o  "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let lr = Label.create form_principal [Text        "   5 r  "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let lg = Label.create form_principal [Text        "   6 g  "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let sd2 = Label.create form_principal [Text       "  X SD2 "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let lr2 = Label.create form_principal [Text       "  % LR2 "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in

			let linea_informacion5 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
				let alpha_run = Label.create form_principal [Text "ALPHA "; Font "10"; Width (Pixels 8); Background Black; Foreground White; Relief Raised] in
				let sumatorio_cuadrados_x = Label.create form_principal [Text "  1 Ex "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let sumatorio_x = Label.create form_principal [Text           "  2 Ex  "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let ln_f = Label.create form_principal [Text                    "   3 n  "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let sumatorio_cuadrados_y = Label.create form_principal [Text "  4 Ey "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let sumatorio_y = Label.create form_principal [Text           "  5 Ey  "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in
				let sumatorio_xy = Label.create form_principal [Text          "  6 Exy "; Font "5"; Width (Pixels 0); Background Black; Foreground White; Relief Raised] in

(*  --	Definicion de las distintas areas de botones de la calculadora *)
	let marco_BOTONES = Frame.create form_principal [Background Black] in
		let marcoLineaSuperiorEtiquetas1 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let lAlpha = Label.create form_principal [Text "A"; Font "10"; Relief Groove; Background Black; Foreground Yellow] in
			let lock = Label.create form_principal [Text "LOCK"; Font "10"; Width (Pixels 6); Background Black; Foreground Yellow] in
			let goto = Label.create form_principal [Text "Goto"; Font "10"; Width (Pixels 11); Background Black; Foreground Yellow] in
			let lbl = Label.create form_principal [Text "Lbl"; Font "10"; Width (Pixels 4); Background Black; Foreground Yellow] in
			let replay = Label.create form_principal [Text "REPLAY"; Font "3"; Width (Pixels 7); Background Black; Foreground Blue] in
			let ins = Label.create form_principal [Text "INS"; Font "10"; Width (Pixels 4); Background Black; Foreground Yellow] in
		let marco_Linea_Botones1 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bShift = Button.create form_principal [Text "SHIFT"; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Yellow; Foreground White;
			Command (function () ->
			begin
				if ((estado_objecto alpha.widget) = 1) then
					(eliminar_elemento_pantalla (pantalla, alpha.widget))
				else ();

				match (estado_objecto shift.widget) with
				  0 -> shift.widget.id_widget <- anadir_elemento_pantalla (pantalla, shift.widget, 150, 10, shift.valor, "3")
				| _ -> eliminar_elemento_pantalla (pantalla, shift.widget)
			end
			)] in (* shift Command *)
			let bAlpha = Button.create form_principal [Text "ALPHA"; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Red; Foreground White;
			Command (function () ->
			begin
				if ((estado_objecto shift.widget) = 1) then
					eliminar_elemento_pantalla (pantalla, shift.widget)
				else ();

				if ((estado_objecto mode.widget) = 1) then
					eliminar_elemento_pantalla (pantalla, mode.widget)
				else ();

				if ((estado_objecto hiperbola.widget) = 1) then
					eliminar_elemento_pantalla (pantalla, hiperbola.widget)
				else ();

				match (estado_objecto alpha.widget) with
		  		  0 -> alpha.widget.id_widget <- anadir_elemento_pantalla (pantalla, alpha.widget, 180, 10, alpha.valor, "3")
				| _ -> eliminar_elemento_pantalla (pantalla, alpha.widget)
			end
			)] in (* alpha Command *)
			let bProg = Button.create form_principal [Text prog.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, prog))]
			in (* Prog Command *)
			let bIzq = Button.create form_principal [Text izq.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
			begin
				if ((estado_objecto shift.widget) = 1) then
					pulsar_tecla (pantalla, izq)
				else begin
					if ((estaModoGrafico ()) = false) then
					begin
						cambio_estado (ac.widget, 0);

						eliminar_elemento_pantalla (pantalla, alpha.widget);
						eliminar_elemento_pantalla (pantalla, mode.widget);
						eliminar_elemento_pantalla (pantalla, linea_comandos);

						cambio_estado (ejecutar.widget, 0);
						aux := poner_comando (pantalla, linea_comandos, (obtener_valor_fichero "comando"));
						()
					end (* then*)
					else begin
						ocultarGraficas (pantalla, grafica_A);
						ocultarGraficas (pantalla, grafica_B);
						ocultarGraficas (pantalla, grafica_C);

						ocultarEjes pantalla;

						tipo_desplazamiento := 4;

						repintarGraficas pantalla;
					end (* else *)
				end (* else*)
			end
			)] in (* izq Command *)
			let bDrch = Button.create form_principal [Text drcha.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
			begin
				if ((estado_objecto shift.widget) = 1) then
					pulsar_tecla (pantalla, drcha)
				else begin
					if ((estaModoGrafico ()) = false) then
					begin
						cambio_estado (ac.widget, 0);

						eliminar_elemento_pantalla (pantalla, alpha.widget);
						eliminar_elemento_pantalla (pantalla, mode.widget);
						eliminar_elemento_pantalla (pantalla, linea_comandos);

						cambio_estado (ejecutar.widget, 0);
						aux := poner_comando (pantalla, linea_comandos, (obtener_valor_fichero "comando"));
						()
					end (* then*)
					else begin
						ocultarGraficas (pantalla, grafica_A);
						ocultarGraficas (pantalla, grafica_B);
						ocultarGraficas (pantalla, grafica_C);

						ocultarEjes pantalla;

						tipo_desplazamiento := 3;

						repintarGraficas pantalla;
					end (* else *)
				end (* else*)
			end
			)] in (* drcha Command *)
			let bMode = Button.create form_principal [Text "MODE"; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
			begin
				if ((estado_objecto alpha.widget) = 1) then
					eliminar_elemento_pantalla (pantalla, alpha.widget)
				else ();

				if ((estado_objecto hiperbola.widget) = 1) then
					eliminar_elemento_pantalla (pantalla, hiperbola.widget)
				else ();

				match (estado_objecto mode.widget) with
				  0 -> mode.widget.id_widget <- anadir_elemento_pantalla (pantalla, mode.widget, 165, 10, mode.valor, "3")
				| _ -> eliminar_elemento_pantalla (pantalla, mode.widget)
			end
			)] in (* mode Command *)
		let marcoLineaInferiorEtiquetas1 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let comillas = Label.create form_principal [Text "''"; Font "10"; Width (Pixels 0); Background Black; Foreground Red] in
			let valor = Label.create form_principal [Text "Value"; Font "5"; Width (Pixels 32); Background Black; Foreground Yellow] in

		let marcoLineaSuperiorEtiquetas2 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let zoom_org = Label.create form_principal [Text "Zoom Org"; Font "5"; Width (Pixels 10); Background Black; Foreground Yellow] in
			let factor = Label.create form_principal [Text "Factor"; Font "5"; Width (Pixels 11); Background Black; Foreground Yellow] in
			let plot = Label.create form_principal [Text "Plot"; Font "5"; Width (Pixels 7); Background Black; Foreground Yellow] in
			let line = Label.create form_principal [Text "Line"; Font "5"; Width (Pixels 11); Background Black; Foreground Yellow] in
			let x_y = Label.create form_principal [Text "X-Y"; Font "5"; Width (Pixels 7); Background Black; Foreground Yellow] in
			let cls = Label.create form_principal [Text "Cls"; Font "5"; Width (Pixels 10); Background Black; Foreground Yellow] in
		let marco_Linea_Botones2 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bGraph = Button.create form_principal [Text "Graph"; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> 
			begin
				if ((estado_objecto shift.widget) = 1) then
				begin
					grafica_xscl := 1.0;
					grafica_yscl := 1.0;
					grafica_zoomx := 1.0;
					grafica_zoomy := 1.0;
					tipo_desplazamiento := 0; (* 1, 2, 3, 4*)				
				end (* then *)
				else pulsar_tecla (pantalla, graph)
			end
			)] in (* graph Command *)
			let bRange = Button.create form_principal [Text range.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> 
			begin
				if (!modo_programacion = 2) then
					pulsar_tecla (pantalla, range)
				else entradaDatos (pantalla, range)
			end
			)] in (* range Command *)
			let bTrace = Button.create form_principal [Text "Trace"; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, trace))] in
			let bArriba = Button.create form_principal [Text arriba.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
				if ((estado_objecto shift.widget) = 1) then
					pulsar_tecla (pantalla, arriba)
				else begin
					if ((estaModoGrafico ()) = false) then
					begin
					end (* then*)
					else begin
						ocultarGraficas (pantalla, grafica_A);
						ocultarGraficas (pantalla, grafica_B);
						ocultarGraficas (pantalla, grafica_C);

						ocultarEjes pantalla;

						tipo_desplazamiento := 2;

						repintarGraficas pantalla;
					end (* else *)
				end (* else*)
			)] in (* arriba Command *)
			let bAbajo = Button.create form_principal [Text abajo.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
				if ((estado_objecto shift.widget) = 1) then
					pulsar_tecla (pantalla, abajo)
				else begin
					if ((estaModoGrafico ()) = false) then
					begin
					end (* then*)
					else begin
						ocultarGraficas (pantalla, grafica_A);
						ocultarGraficas (pantalla, grafica_B);
						ocultarGraficas (pantalla, grafica_C);

						ocultarEjes pantalla;

						tipo_desplazamiento := 1;

						repintarGraficas pantalla;
					end (* else *)
				end (* else*)
			)] in (* abajo Command *)
			let bGt = Button.create form_principal [Text gt.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
			begin
				if ((estado_objecto shift.widget) = 1) then
					pulsar_tecla (pantalla, gt)
				else begin
					cambio_estado (ac.widget, 0);

					eliminar_elemento_pantalla (pantalla, alpha.widget);
					eliminar_elemento_pantalla (pantalla, mode.widget);
					eliminar_elemento_pantalla (pantalla, linea_comandos);

					cambio_estado (ejecutar.widget, 0);

					if ((estaModoGrafico ()) = false) then
					begin
						if ((obtener_modo (obtener_contenido modo_funcionamiento)) <> 15) then
						begin
							borrar_entrada pantalla;

							repintarGraficas pantalla
						end (* then *)
						else begin
							borrar_entrada pantalla;
							eliminar_elemento_pantalla (pantalla, modo_funcionamiento);

							mostrarEjesGraficaBarras pantalla;
							dibujar_graficaBarras (grafica_barras, pantalla);
						end (* else *)
					end (* then *)
					else begin
						ocultarGraficas (pantalla, grafica_A);
						ocultarGraficas (pantalla, grafica_B);
						ocultarGraficas (pantalla, grafica_C);

						ocultarGraficaBarras pantalla;

						ocultarEjes pantalla;
					end;
				end
			end
			)] in (* gt Command *)
		let marcoLineaInferiorEtiquetas2 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let resultados_anteriores = Label.create form_principal [Text "@"; Font "10"; Width (Pixels 19); Background Black; Foreground Red] in
			let mismo_valor = Label.create form_principal [Text "~"; Font "10"; Width (Pixels 0); Background Black; Foreground Red] in
			let datos = Label.create form_principal [Text "?"; Font "10"; Width (Pixels 17); Background Black; Foreground Red] in

		let marcoLineaSuperiorEtiquetas3 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let desplz_izq = Label.create form_principal [Text "<-"; Font "10"; Width (Pixels 8); Background Black; Foreground Yellow] in
			let int = Label.create form_principal [Text "Int"; Font "5"; Width (Pixels 10); Background Black; Foreground Yellow] in
			let frac = Label.create form_principal [Text "Frac"; Font "5"; Width (Pixels 9); Background Black; Foreground Yellow] in
			let l10_x = Label.create form_principal [Text "10^x"; Font "5"; Width (Pixels 9); Background Black; Foreground Yellow] in
			let le_x = Label.create form_principal [Text "e^x"; Font "10"; Width (Pixels 9); Background Black; Foreground Yellow] in
		let marco_Linea_Botones3 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bDos_puntos = Button.create form_principal [Text dos_puntos.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, dos_puntos))]
			in (* dos_puntos Command *)
			let bEng = Button.create form_principal [Text "ENG"; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White] in
			let bRaiz_cuadrada = Button.create form_principal [Text raiz_cuadrada.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, raiz_cuadrada))]
			in (* raiz_cuadrada Command *)
			let bCuadrado = Button.create form_principal [Text ("x" ^ (String.make 1 (Char.chr 178))); Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, cuadrado))]
			in (* cuadrado Command *)
			let bLog = Button.create form_principal [Text (obtener_contenido log.widget); Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, log))]
			in (* log Command *)
			let bLn = Button.create form_principal [Text (obtener_contenido ln.widget); Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, ln))]
			in (* ln Command *)
		let marcoLineaInferiorEtiquetas3 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let xnor = Label.create form_principal [Text "xnor"; Font "5"; Width (Pixels 8); Background Black; Foreground Yellow] in
			let lk = Label.create form_principal [Text "k"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let not = Label.create form_principal [Text "Not"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let xor = Label.create form_principal [Text "xor"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let lm = Label.create form_principal [Text "m"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let dec = Label.create form_principal [Text "Dec"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let ld = Label.create form_principal [Text "d"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let lmu = Label.create form_principal [Text ""; Font "5"; Width (Pixels 3); Background Black; Foreground Red] in
			let hex = Label.create form_principal [Text "Hex"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let lh = Label.create form_principal [Text "h"; Font "5"; Width (Pixels 2); Background Black; Foreground Yellow] in
			let l_n = Label.create form_principal [Text "n"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let bin = Label.create form_principal [Text "Bin"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let lb = Label.create form_principal [Text "b"; Font "5"; Width (Pixels 2); Background Black; Foreground Yellow] in
			let lpiro = Label.create form_principal [Text ""; Font "5"; Width (Pixels 2); Background Black; Foreground Red] in
			let oct = Label.create form_principal [Text "Oct"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let lo = Label.create form_principal [Text "o"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let lf = Label.create form_principal [Text "f"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in

		let marcoLineaSuperiorEtiquetas4 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let x_fact = Label.create form_principal [Text "X!"; Font "10"; Width (Pixels 10); Background Black; Foreground Yellow] in
			let desplz_izq2 = Label.create form_principal [Text "<-"; Font "10"; Width (Pixels 6); Background Black; Foreground Yellow] in
			let sin_inv = Label.create form_principal [Text "sin-"; Font "5"; Width (Pixels 20); Anchor E; Background Black; Foreground Yellow] in
			let cos_inv = Label.create form_principal [Text "cos-"; Font "5"; Width (Pixels 9); Anchor E; Background Black; Foreground Yellow] in
			let tan_inv = Label.create form_principal [Text "tan-"; Font "5"; Width (Pixels 9); Anchor E; Background Black; Foreground Yellow] in
		let marco_Linea_Botones4 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bInversa = Button.create form_principal [Text inversa.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, inversa))]
			in (* inversa Command *)
			let bGrados = Button.create form_principal [Text grados.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, grados))]
			in (* grados Command *)
			let bHiperbola = Button.create form_principal [Text hiperbola.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
			begin
				if ((estado_objecto mode.widget) = 1) then
					eliminar_elemento_pantalla (pantalla, mode.widget)
				else ();

				match (estado_objecto hiperbola.widget) with
		  		  0 -> begin
					if ((estado_objecto alpha.widget) = 1) then
					begin
						anadir_comando (pantalla, hiperbola);
						eliminar_elemento_pantalla (pantalla, alpha.widget);
					end (* then *)
					else hiperbola.widget.id_widget <- anadir_elemento_pantalla (pantalla, hiperbola.widget, 250, 10, hiperbola.valor, "3")
				end (* 0  *)
				| _ -> eliminar_elemento_pantalla (pantalla, hiperbola.widget)
			end
			)] in (* hiperbola Command*)
			let bSeno = Button.create form_principal [Text seno.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, seno))]
			in (* seno Command *)
			let bCoseno = Button.create form_principal [Text coseno.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, coseno))]
			in (* coseno Command *)
			let bTangente = Button.create form_principal [Text tangente.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, tangente))]
			in (* tangente Command *)
		let marcoLineaInferiorEtiquetas4 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let l_A = Label.create form_principal [Text "A"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let espacio_vacio1 = Label.create form_principal [Text ""; Font "5"; Width (Pixels 4); Background Black] in
			let lA = Label.create form_principal [Text "A"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let l_B = Label.create form_principal [Text "B"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let espacio_vacio2 = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black] in
			let lB = Label.create form_principal [Text "B"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let l_C = Label.create form_principal [Text "C"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let espacio_vacio3 = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black] in
			let lC = Label.create form_principal [Text "C"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let l_D = Label.create form_principal [Text "D"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let espacio_vacio4 = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black] in
			let lD = Label.create form_principal [Text "D"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let l_E = Label.create form_principal [Text "E"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let espacio_vacio5 = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black] in
			let lE = Label.create form_principal [Text "E"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let l_F = Label.create form_principal [Text "F"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let espacio_vacio6 = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black] in
			let lF = Label.create form_principal [Text "F"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in

		let marcoLineaSuperiorEtiquetas5 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let d_c = Label.create form_principal [Text "d/c"; Font "5"; Width (Pixels 10); Background Black; Foreground Yellow] in
			let coma = Label.create form_principal [Text ","; Font "10"; Width (Pixels 14); Anchor E; Background Black; Foreground Yellow] in
			let punto_coma = Label.create form_principal [Text ";"; Font "10"; Width (Pixels 9); Anchor E; Background Black; Foreground Yellow] in
			let abs = Label.create form_principal [Text potencia_y.shift; Font "5"; Width (Pixels 10); Anchor E; Background Black; Foreground Yellow] in
			let raiz_cubica = Label.create form_principal [Text raiz_x.shift; Font "5"; Width (Pixels 11); Anchor E; Background Black; Foreground Yellow] in
		let marco_Linea_Botones5 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bRaices = Button.create form_principal [Text "a b/c"; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
			begin
				if (((estado_objecto shift.widget) = 0) && ((estado_objecto alpha.widget) = 0)) then
				begin
					esRaiz := true;
					calcularRaices := true;
				end; (* then *)

				pulsar_tecla (pantalla, raices);
			end
			)] in (* raices Command *)
			let bDesplazamiento_drch = Button.create form_principal [Text desplazamiento_drch.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, desplazamiento_drch))]
			in (* deplazamiento_drch Command *)
			let bParentesis_izq = Button.create form_principal [Text parentesis_izq.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, parentesis_izq))]
			in (* parentesis_izq Command *)
			let bParentesis_drch = Button.create form_principal [Text parentesis_drch.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, parentesis_drch))]
			in (* parentesis_drch Command *)
			let bPotencia_y = Button.create form_principal [Text potencia_y.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () -> pulsar_tecla (pantalla, potencia_y))]
			in (* potencia_y *)
			let bRaiz_x = Button.create form_principal [Text raiz_x.valor; Justify Justify_Center; Font "10"; Width (Pixels 5); Background Black; Foreground White;
			Command (function () ->
				if ((obtener_modo (obtener_contenido modo_funcionamiento)) = 13) then (* modo SD1 *)
				begin
					operacion.contenido <- linea_comandos.contenido;

					let comando_actual = (formar_comando operacion.contenido) in
					let dato = ref "" in
					let cantidad = ref "" in

					if ((String.contains comando_actual ';') = true) then
					begin
						dato := (String.sub comando_actual 0 (String.index comando_actual ';'));
						cantidad := ((String.sub comando_actual ((String.index comando_actual ';') + 1) ((String.length comando_actual) - ((String.length !dato) + 1)) ));
					end (* then *)
					else begin
						dato := comando_actual;
						cantidad := "0";
					end; (* else *)

					borrar_entrada (pantalla);
					linea_comandos.contenido <- [] @ [ejecutar_comando (pantalla, [(obtener_expresion_valor (!dato))])];

					if ((es_entero (obtener_contenido linea_comandos)) = true) then
						aux := poner_comando (pantalla, linea_comandos, ((formatear_salida ((obtener_contenido linea_comandos))) ^ "."))
					else aux := poner_comando (pantalla, linea_comandos, (formatear_salida ((obtener_contenido linea_comandos))));

					if ((int_of_string !cantidad) > 0) then
					begin
						for indice=1 to (int_of_string !cantidad) do
							Funciones_comunes.anadir_dato_estadistico ((obtener_contenido linea_comandos), fichero_desviacion_estandar);
						done; (* for *)
					end (* then *)
					else Funciones_comunes.anadir_dato_estadistico ((obtener_contenido linea_comandos), fichero_desviacion_estandar);
					aux := "";

					operacion.contenido <- [];
					comando := [];

					linea_comandos.contenido <- [];
					cambio_estado (operacion, 1);
					raices_comando := [];
					calcularRaices := false;
					esRaiz := false;
					()
				end (* then *)
				else if ((obtener_modo (obtener_contenido modo_funcionamiento)) = 15) then (* modo SD2 *)
				begin
					operacion.contenido <- linea_comandos.contenido;

					let comando_actual = (formar_comando operacion.contenido) in
					let dato = ref "" in
					let cantidad = ref "" in

					if ((String.contains comando_actual ';') = true) then
					begin
						dato := (String.sub comando_actual 0 (String.index comando_actual ';'));
						cantidad := ((String.sub comando_actual ((String.index comando_actual ';') + 1) ((String.length comando_actual) - ((String.length !dato) + 1)) ));
					end (* then *)
					else begin
						dato := comando_actual;
						cantidad := "1";
					end; (* else *)

					borrar_entrada (pantalla);
					linea_comandos.contenido <- [] @ [ejecutar_comando (pantalla, [(obtener_expresion_valor (!dato))])];

					if ((es_entero (obtener_contenido linea_comandos)) = true) then
						aux := poner_comando (pantalla, linea_comandos, ((formatear_salida ((obtener_contenido linea_comandos))) ^ "."))
					else aux := poner_comando (pantalla, linea_comandos, (formatear_salida ((obtener_contenido linea_comandos))));

					Funciones_comunes.anadir_dato_estadistico ((obtener_contenido linea_comandos), fichero_estadistica_una);
					Funciones_comunes.anadir_dato_estadistico (!cantidad, fichero_estadistica_una_frecuencia);

					aux := "";
					operacion.contenido <- [];
					comando := [];
					linea_comandos.contenido <- [];
					cambio_estado (operacion, 1);
					raices_comando := [];
					calcularRaices := false;
					esRaiz := false;
					()
				end
				else if (((obtener_modo (obtener_contenido modo_funcionamiento)) = 14) ||
					 ((obtener_modo (obtener_contenido modo_funcionamiento)) = 16) ) then (* modo LR1 - LR2 *)
				begin
					operacion.contenido <- linea_comandos.contenido;
					borrar_entrada (pantalla);

					let comando_actual = ref (obtener_expresion_valor (formar_comando operacion.contenido)) in
					let cantidad = ref "" in
					let dato = ref "" in
					let componente_x = ref "" in
					let componente_y = ref "" in
					if ((String.contains !comando_actual ';') = true) then
					begin
						dato := (String.sub !comando_actual 0 (String.index !comando_actual ';'));
						cantidad := ((String.sub !comando_actual ((String.index !comando_actual ';') + 1) ((String.length !comando_actual) - ((String.length !dato) + 1)) ));

						componente_x := ((String.sub !comando_actual 0 (String.index !comando_actual ',')));
						componente_y := ((String.sub !comando_actual ((String.index !comando_actual ',') + 1) (((String.length !comando_actual) - ((String.length !cantidad) + 1)) - ((String.length !componente_x) + 1)) ));
					end (* then *)
					else begin
						dato := !comando_actual;
						cantidad := "1";

						componente_x := ((String.sub !comando_actual 0 (String.index !comando_actual ',')));
						componente_y := ((String.sub !comando_actual ((String.index !comando_actual ',') + 1) ((String.length !comando_actual) - ((String.length !componente_x) + 1)) ));
					end; (* else *)

					componente_x := ejecutar_comando (pantalla, [!componente_x]);
					componente_y := ejecutar_comando (pantalla, [!componente_y]);

					if ((obtener_modo (obtener_contenido modo_funcionamiento)) = 14) then (* LR1 *)
					begin
						linea_comandos.contenido <- [] @ [!componente_x];

						if ((es_entero (obtener_contenido linea_comandos)) = true) then
							aux := poner_comando (pantalla, linea_comandos, ((formatear_salida ((obtener_contenido linea_comandos))) ^ "."))
						else aux := poner_comando (pantalla, linea_comandos, (formatear_salida ((obtener_contenido linea_comandos))));

						for indice=1 to (int_of_string !cantidad) do
							Funciones_comunes.anadir_dato_estadistico (!componente_x, fichero_regresion_x);
							Funciones_comunes.anadir_dato_estadistico (!componente_y, fichero_regresion_y);
						done; (* for *)
					end (* then *)
					else begin (* LR2 *)
						for indice=1 to (int_of_string !cantidad) do
							Funciones_comunes.anadir_dato_estadistico (!componente_x, fichero_estadistica_dos_x);
							Funciones_comunes.anadir_dato_estadistico (!componente_y, fichero_estadistica_dos_y);
						done; (* for *)

						eliminar_elemento_pantalla (pantalla, modo_funcionamiento);

						mostrarEjes pantalla;
						mostrarGraficaDatosEstadisticos pantalla;
					end; (* else if .. then *)

					aux := "";
					operacion.contenido <- [];
					comando := [];
					linea_comandos.contenido <- [];
					cambio_estado (operacion, 1);
					raices_comando := [];
					calcularRaices := false;
					esRaiz := false;
					()
				end (* then *)
				else pulsar_tecla (pantalla, raiz_x)
			)] in (* raiz_x Command *)
		let marcoLineaInferiorEtiquetas5 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let neg = Label.create form_principal [Text "Neg"; Font "5"; Width (Pixels 8); Background Black; Foreground Green] in
			let lG = Label.create form_principal [Text "G"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let scl = Label.create form_principal [Text "Scl"; Font "5"; Width (Pixels 5); Background Black; Foreground Yellow] in
			let lH = Label.create form_principal [Text "H"; Font "5"; Width (Pixels 3); Background Black; Foreground Red] in
			let lI = Label.create form_principal [Text "I"; Font "5"; Width (Pixels 17); Background Black; Foreground Red] in
			let lJ = Label.create form_principal [Text "J"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let lAnd = Label.create form_principal [Text "and"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let cl = Label.create form_principal [Text "CL"; Font "5"; Width (Pixels 3); Background Black; Foreground Blue] in
			let lK = Label.create form_principal [Text "K"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let lOr = Label.create form_principal [Text "or"; Font "5"; Width (Pixels 0); Background Black; Foreground Green] in
			let dt = Label.create form_principal [Text "DT"; Font "5"; Width (Pixels 3); Background Black; Foreground Blue] in
			let lL = Label.create form_principal [Text "L"; Font "5"; Width (Pixels 2); Background Black; Foreground Red] in

		let marcoLineaSuperiorEtiquetas6 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let implica = Label.create form_principal [Text "=>"; Font "10"; Width (Pixels 17); Background Black; Foreground Yellow] in
			let igual = Label.create form_principal [Text "="; Font "10"; Width (Pixels 3); Background Black; Foreground Yellow] in
			let distinto = Label.create form_principal [Text "<>"; Font "10"; Width (Pixels 17); Background Black; Foreground Yellow] in
			let mcl = Label.create form_principal [Text "Mcl"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let off = Label.create form_principal [Text "OFF"; Font "5"; Width (Pixels 17); Background Black; Foreground Yellow] in
		let marco_Linea_Botones6 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bSiete = Button.create form_principal [Text siete.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, siete))]
			in (* siete Command *)
			let bOcho = Button.create form_principal [Text ocho.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, ocho))]
			in (* ocho Command *)
			let bNueve = Button.create form_principal [Text nueve.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, nueve))]
			in (* nueve Command *)
			let bDelete = Button.create form_principal [Text delete.valor; Justify Justify_Center; Font "16"; Width (Pixels 6); Background (NamedColor "Grey");
			Command (function () ->
			begin
				if ((!modo_programacion = 2) && ((estado_objecto programa) = 0) ) then
				begin
				end (* then *)
				else if ((!modo_programacion = 3) && ((estado_objecto shift.widget) = 1)) then
				begin
					eliminarProgramas ();

					eliminar_elemento_pantalla (pantalla, shift.widget);
					borrar_entrada pantalla;

					modo_operacion (pantalla, tres.mode);

					comando := [];
				end (* then *)
				else begin
					let comando_aux = ref [] in
					comando_aux := borrar linea_comandos.contenido;
					linea_comandos.id_widget <- limpiar_linea_comandos (pantalla, linea_comandos);
(*
					comando := borrar !comando;
*)
					aux := poner_comando (pantalla, linea_comandos, (formar_comando !comando_aux));
					linea_comandos.contenido <- !comando_aux;
				end (* else *)
			end
			)] in
			let bAc = Button.create form_principal [Text ac.valor; Justify Justify_Center; Font "16"; Width (Pixels 6); Background (NamedColor "Grey");
			Command (function () ->
			begin
				if ((!modo_programacion = 2) || (!modo_programacion = 3)) then
				begin
				end (* then *)
				else begin
					if ((estado_objecto operacion) = 1) then
						linea_comandos.contenido <- [] @ [obtener_valor_fichero fichero_ultimo_resultado]
					else ();

					ocultarGraficas (pantalla, grafica_A);
					almacenarGrafica grafica_A;
					ocultarGraficas (pantalla, grafica_B);
					almacenarGrafica grafica_B;
					ocultarGraficas (pantalla, grafica_C);
					almacenarGrafica grafica_C;

					ocultarGraficaBarras pantalla;

					ocultarEjes pantalla;
					
					if ((estado_objecto mostrando_salida) = 1) then
						eliminar_elemento_pantalla (pantalla, mostrando_salida);
					ejecutando_programa := 0;
					fin_programa := 0;
					error_programa := 0;
					mostrar_grafica_programa := 0;

					Funciones_comunes.guardar_operacion ((obtener_contenido linea_comandos) , fichero_ultimo_resultado);
					comando := [];

					mode.widget.contenido <- [obtener_contenido modo_funcionamiento];

					Funciones_comunes.guardar_operacion ((obtener_contenido mode.widget), fichero_ultimo_modo);
					if ((obtener_contenido mode_base) = "") then
						Funciones_comunes.guardar_operacion ("d", fichero_ultimo_modo_base)
					else Funciones_comunes.guardar_operacion ((obtener_contenido mode_base), fichero_ultimo_modo_base);

					match (estado_objecto shift.widget) with
			  		  1 -> cerrar_calculadora ();
					| _ -> borrar_entrada pantalla;
				end (* else *)
			end
			)] in (* ac Command *)
		let marcoLineaInferiorEtiquetas6 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let lAa = Label.create form_principal [Text "A"; Font "5"; Width (Pixels 9); Background Black; Foreground Yellow] in
			let lM = Label.create form_principal [Text "M"; Font "5"; Width (Pixels 4); Background Black; Foreground Red] in
			let lBa = Label.create form_principal [Text "B"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let espacio_vacio1a = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black;] in
			let lN = Label.create form_principal [Text "N"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let lra = Label.create form_principal [Text "r"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let lO = Label.create form_principal [Text "O"; Font "5"; Width (Pixels 16); Background Black; Foreground Red] in
			let lON = Label.create form_principal [Text "ON"; Font "5"; Width (Pixels 16); Background Black; Foreground Blue] in

		let marcoLineaSuperiorEtiquetas7 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let lsz = Label.create form_principal [Text "lsz"; Font "5"; Width (Pixels 17); Background Black; Foreground Yellow] in
			let igual_mayor = Label.create form_principal [Text ">="; Font "10"; Width (Pixels 3); Background Black; Foreground Yellow] in
			let igual_menor = Label.create form_principal [Text "=<"; Font "10"; Width (Pixels 16); Background Black; Foreground Yellow] in
			let zoom_xf = Label.create form_principal [Text "Zoom Xf"; Font "5"; Width (Pixels 6); Background Black; Foreground Yellow] in
			let zoom_x_inv_f = Label.create form_principal [Text "Zoom X1/f"; Font "5"; Width (Pixels 15); Background Black; Foreground Yellow] in
		let marco_Linea_Botones7 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bCuatro = Button.create form_principal [Text cuatro.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, cuatro))]
			in (* cuatro Command *)
			let bCinco = Button.create form_principal [Text cinco.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, cinco))]
			in (* cinco Command *)
			let bSeis = Button.create form_principal [Text seis.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, seis))]
			in (* seis Command *)
			let bPor = Button.create form_principal [Text por.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () ->
				if ((estado_objecto shift.widget) = 1) then
				begin
					if ((estado_objecto mode.widget) = 1) then
					begin
						eliminar_elemento_pantalla (pantalla, mode.widget);
						eliminar_elemento_pantalla (pantalla, shift.widget);

						modo_operacion (pantalla, por.shift_mode);

						borrar_entrada (pantalla);
						comando := [];
					end (* then *)
					else pulsar_tecla (pantalla, por)
				end (* then *)
				else begin
					if ((estado_objecto mode.widget) = 1) then
					begin
						eliminar_elemento_pantalla (pantalla, mode.widget);

						modo_operacion (pantalla, por.mode);

						borrar_entrada (pantalla);
						comando := [];
					end (* then *)
					else pulsar_tecla (pantalla, por)
				end
			)] in (* por Command *)
			let bEntre = Button.create form_principal [Text entre.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () ->
				if ((estado_objecto shift.widget) = 1) then
				begin
					if ((estado_objecto mode.widget) = 1) then
					begin
						eliminar_elemento_pantalla (pantalla, mode.widget);
						eliminar_elemento_pantalla (pantalla, shift.widget);

						modo_operacion (pantalla, entre.shift_mode);

						borrar_entrada (pantalla);
						comando := [];
					end (* then *)
					else pulsar_tecla (pantalla, entre)
				end (* then *)
				else begin
					if ((estado_objecto mode.widget) = 1) then
					begin
						eliminar_elemento_pantalla (pantalla, mode.widget);

						modo_operacion (pantalla, entre.mode);

						borrar_entrada (pantalla);
						comando := [];
					end (* then *)
					else pulsar_tecla (pantalla, entre)
				end
			)] in (* entre Command *)

		let marcoLineaInferiorEtiquetas7 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let media_y = Label.create form_principal [Text "/y"; Font "5"; Width (Pixels 9); Background Black; Foreground Yellow] in
			let espacio_vacio1b = Label.create form_principal [Text ""; Font "5"; Width (Pixels 1); Background Black] in
			let lP = Label.create form_principal [Text "P"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let espacio_vacio2b = Label.create form_principal [Text ""; Font "5"; Width (Pixels 3); Background Black] in
			let varianza_y = Label.create form_principal [Text "yn"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let lQ = Label.create form_principal [Text "Q"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let inv_varianza_y = Label.create form_principal [Text "yn-1"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let espacio_vacio3b = Label.create form_principal [Text ""; Font "5"; Width (Pixels 2); Background Black] in
			let lR = Label.create form_principal [Text "R"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let regresion_logaritmica_x = Label.create form_principal [Text "^x"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let espacio_vacio4b = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black] in
			let lS = Label.create form_principal [Text "S"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let regresion_logaritmica_y = Label.create form_principal [Text "^y"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let espacio_vacio5b = Label.create form_principal [Text ""; Font "5"; Width (Pixels 5); Background Black] in
			let lT = Label.create form_principal [Text "T"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in

		let marcoLineaSuperiorEtiquetas8 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let dsz = Label.create form_principal [Text "Dsz"; Font "5"; Width (Pixels 17); Background Black; Foreground Yellow] in
			let mayor = Label.create form_principal [Text ">"; Font "10"; Width (Pixels 3); Background Black; Foreground Yellow] in
			let menor = Label.create form_principal [Text "<"; Font "10"; Width (Pixels 16); Background Black; Foreground Yellow] in
			let pol = Label.create form_principal [Text "Pol ("; Font "5"; Width (Pixels 6); Background Black; Foreground Yellow] in
			let lrec = Label.create form_principal [Text "Rec ("; Font "5"; Width (Pixels 13); Background Black; Foreground Yellow] in
		let marco_Linea_Botones8 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bUno = Button.create form_principal [Text uno.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () ->
			begin
				if ((estado_objecto mode.widget) = 1) then
				begin
					eliminar_elemento_pantalla (pantalla, mode.widget);

					modo_operacion (pantalla, uno.mode);

					borrar_entrada (pantalla);
					comando := [];
				end (* then *)
				else pulsar_tecla (pantalla, uno)
			end
			)] in (* uno Command *)
			let bDos = Button.create form_principal [Text dos.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () ->
			begin
				if ((estado_objecto mode.widget) = 1) then
				begin
					eliminar_elemento_pantalla (pantalla, mode.widget);

					borrar_entrada (pantalla);

					modo_operacion (pantalla, dos.mode);

					comando := [];
				end (* then *)
				else pulsar_tecla (pantalla, dos)
			end
			)] in (* dos Command *)
			let bTres = Button.create form_principal [Text tres.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () ->
			begin
				if ((estado_objecto mode.widget) = 1) then
				begin
					eliminar_elemento_pantalla (pantalla, mode.widget);
					
					borrar_entrada (pantalla);

					modo_operacion (pantalla, tres.mode);

					comando := [];
				end (* then *)
				else pulsar_tecla (pantalla, tres)
			end
			)] in (* tres Command *)
			let bMas = Button.create form_principal [Text mas.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () ->
				if ((estado_objecto mode.widget) = 1) then
				begin
					eliminar_elemento_pantalla (pantalla, mode.widget);

					modo_operacion (pantalla, mas.mode);

					borrar_entrada (pantalla);
					comando := [];
				end (* then *)
				else pulsar_tecla (pantalla, mas)
			)] in (* mas Command *)
			let bMenos = Button.create form_principal [Text menos.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () ->
				if ((estado_objecto mode.widget) = 1) then
				begin
					eliminar_elemento_pantalla (pantalla, mode.widget);

					modo_operacion (pantalla, menos.mode);

					borrar_entrada (pantalla);
					comando := [];
				end (* then *)
				else pulsar_tecla (pantalla, menos)
			)] in (* menos Command *)

		let marcoLineaInferiorEtiquetas8 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let media_x = Label.create form_principal [Text "/x"; Font "5"; Width (Pixels 9); Background Black; Foreground Yellow] in
			let espacio_vacio1c = Label.create form_principal [Text ""; Font "5"; Width (Pixels 1); Background Black] in
			let lU = Label.create form_principal [Text "U"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let varianza_x = Label.create form_principal [Text "xn"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let espacio_vacio2c = Label.create form_principal [Text ""; Font "5"; Width (Pixels 4); Background Black] in
			let lV = Label.create form_principal [Text "V"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let inv_varianza_x = Label.create form_principal [Text "xn-1"; Font "5"; Width (Pixels 0); Background Black; Foreground Yellow] in
			let espacio_vacio3c = Label.create form_principal [Text ""; Font "5"; Width (Pixels 1); Background Black] in
			let lW = Label.create form_principal [Text "W"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let espacio_vacio4c = Label.create form_principal [Text ""; Font "5"; Width (Pixels 8); Background Black] in
			let lX = Label.create form_principal [Text "X"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let espacio_vacio5c = Label.create form_principal [Text ""; Font "5"; Width (Pixels 8); Background Black] in
			let lY = Label.create form_principal [Text "Y"; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in

		let marcoLineaSuperiorEtiquetas9 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let rnd = Label.create form_principal [Text "Rnd"; Font "5"; Width (Pixels 17); Background Black; Foreground Yellow] in
			let ran = Label.create form_principal [Text "Ran#"; Font "5"; Width (Pixels 3); Background Black; Foreground Yellow] in
			let pi = Label.create form_principal [Text "n"; Font "10"; Width (Pixels 16); Background Black; Foreground Yellow] in
			let opuesto = Label.create form_principal [Text "(-)"; Font "5"; Width (Pixels 6); Background Black; Foreground Yellow] in
		let marco_Linea_Botones9 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let bCero = Button.create form_principal [Text cero.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, cero))]
			in (* cero Command *)
			let bPunto = Button.create form_principal [Text punto.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, punto))]
			in (* punto Command *)
			let bExponente = Button.create form_principal [Text exponente.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, exponente))]
			in (* exponente Command *)
			let bValor_anterior = Button.create form_principal [Text valor_anterior.valor; Justify Justify_Center; Font "16"; Width (Pixels 6);
			Command (function () -> pulsar_tecla (pantalla, valor_anterior))]
			in (* valor_anterior Command *)
			let bEjecutar = Button.create form_principal [Text ejecutar.valor; Justify Justify_Center; Font "16"; Width (Pixels 6); Background Blue; Foreground White;
			Command (function () ->
			begin
				if (!rango_funcionamiento > 0) then
				begin
					match !rango_funcionamiento with
					  1 -> begin
						match (estado_objecto range.widget) with
						  1 -> xfact := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range)
						| 2 -> yfact := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range); rango_funcionamiento := 0
						| _ -> aux := poner_comando (pantalla, linea_comandos, "Error de rango"); rango_funcionamiento := 0
					end (* 1 *)
					| _ -> begin
						match (estado_objecto range.widget) with
						  1 -> xmin := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range)
						| 2 -> xmax := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range)
						| 3 -> xscl := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range)
						| 4 -> ymin := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range)
						| 5 -> ymax := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range)
						| 6 -> yscl := float_of_string (ejecutar_comando (pantalla, linea_comandos.contenido)); entradaDatos (pantalla, range); rango_funcionamiento := 0
						| _ -> aux := poner_comando (pantalla, linea_comandos, "Error de rango"); rango_funcionamiento := 0
					end
				end (* then *)
				else if (((obtener_modo (obtener_contenido modo_funcionamiento)) = 15) && ((formar_comando linea_comandos.contenido) = graph.valor)) then
				begin
					borrar_entrada pantalla;
					eliminar_elemento_pantalla (pantalla, modo_funcionamiento);

					mostrarEjesGraficaBarras pantalla;
					dibujar_graficaBarras (grafica_barras, pantalla);
				end (* else if .. then *)
				else if (((obtener_modo (obtener_contenido modo_funcionamiento)) = 16) && ((formar_comando linea_comandos.contenido) = graph.valor)) then
				begin
					borrar_entrada pantalla;
					eliminar_elemento_pantalla (pantalla, modo_funcionamiento);

					mostrarEjes pantalla;
					mostrarGraficaDatosEstadisticos pantalla;
				end (* else if .. then *)
				else if (!operacion_cambio_modo = true) then
				begin
					eliminar_elemento_pantalla (pantalla, mode.widget);

					modo_operacion (pantalla, (formar_comando linea_comandos.contenido));

					borrar_entrada pantalla;
					comando := [];
				end (* then *)
				else begin
					if (!esRaiz = true) then
					begin
						esRaiz := false;
						raiz_actual := (crear_raiz !comando);
						raices_comando := !raices_comando @ [!raiz_actual];
						aux := calcular_valor_raiz !raiz_actual;
						comando := cambiar_valor_comando (!comando, !aux);
					end (* then *)
					else ();

					cambio_estado (ejecutar.widget, 1);
					if ((estado_objecto valor_anterior.widget) = 0) then
					begin
(*						if ((!almacenar) = true) then
						begin
							borrar_entrada (pantalla);
							Funciones_comunes.guardar_operacion (!resultado_aux, (formar_comando linea_comandos.contenido));
							linea_comandos.contenido <- [!resultado_aux];
							resultado_aux := "";
							almacenar := false;
						end
						else begin *)
							if ((estado_objecto operacion) = 1) then
								linea_comandos.contenido <- [] @ [obtener_valor_fichero fichero_ultimo_resultado]
							else ();

							if (!calcularRaices = true) then
							begin
								linea_comandos.contenido <- !comando;
(*								aux := (ejecutar_comando ("1 - " ^ (obtener_contenido mode.widget), ((formar_comando linea_comandos.contenido))));*)
								aux := (ejecutar_comando (pantalla, linea_comandos.contenido));
								linea_comandos.contenido <- [] @ [(formar_resultado_raices (!aux, !raices_comando))];
								borrar_entrada (pantalla);
							end (* then *)
							else begin
								operacion.contenido <- linea_comandos.contenido;

								borrar_entrada (pantalla);
								if ((es_grafica (formar_comando operacion.contenido)) = true) then
								begin
									if ((obtener_modo (obtener_contenido modo_funcionamiento)) = 15) then
									begin
										eliminar_elemento_pantalla (pantalla, modo_funcionamiento);

										mostrarEjesGraficaBarras pantalla;
										curva_distribucion_normal (pantalla, (formar_comando operacion.contenido))
									end (* then *)
									else if ((obtener_modo (obtener_contenido modo_funcionamiento)) = 16) then
									begin
										eliminar_elemento_pantalla (pantalla, modo_funcionamiento);

										mostrarEjes pantalla;
										linea_regresion (pantalla, (formar_comando operacion.contenido))
									end (* then *)
									else generar_grafica (pantalla, (formar_comando operacion.contenido))
								end (* then *)
								else begin
									if ( (((hayPrograma operacion.contenido) = true) && (!ejecutando_programa = 0)) ||
									     (((existeOperacion (operacion.contenido, ":")) = true) || ((existeOperacion (operacion.contenido, "@")) = true)) ) then
									begin
										borrarMemoriasPrograma ();
										if ((((existeOperacion (operacion.contenido, ":")) = true) || ((existeOperacion (operacion.contenido, "@")) = true)) && ((hayPrograma operacion.contenido) = false)) then
											programa.contenido <- operacion.contenido
										else programa.contenido <- cargarPrograma (obtenerPrograma operacion.contenido);
										comando_ejecucion := [];
										comando_ejecucion := operacion.contenido;
										
										ejecutando_programa := 1;
										fin_programa := 0;
										comando_actual_programa := [];
										programa_actual.contenido <- programa.contenido;
										
										comando_actual_programa := obtenerComandoEjecutarPrograma programa_actual.contenido;
										programa_actual.contenido <- avanzarPrograma programa_actual;
									end; (* then *)
																
									if (!ejecutando_programa = 1) then
									begin
										if (!almacenando_memoria_programa = 1) then
										begin
											Funciones_comunes.guardar_operacion (ejecutar_comando (pantalla, operacion.contenido), !memoria_actual_programa);
										
											almacenando_memoria_programa := 0;
											memoria_actual_programa := "";
											
											comando_actual_programa := obtenerComandoEjecutarPrograma programa_actual.contenido;
											programa_actual.contenido <- avanzarPrograma programa_actual;
										end; (* then *)
													
										if ((estado_objecto mostrando_salida) = 1) then
										begin									
											comando_actual_programa := obtenerComandoEjecutarPrograma programa_actual.contenido;
											programa_actual.contenido <- avanzarPrograma programa_actual;
											
											eliminar_elemento_pantalla (pantalla, mostrando_salida);
										end; (* then *)
										
										resultado_programa := ejecutar_programa pantalla;
										
										if ((!fin_programa = 1) || (!error_programa = 1)) then
										begin
											ejecutando_programa := 0;
											fin_programa := 0;
											error_programa := 0;
											
											if (!mostrar_grafica_programa = 0) then
											begin
												borrar_entrada pantalla;
												if ((hayPrograma operacion.contenido) = true) then 
													comando_ejecucion := sustituirValorProgramaOperacion (!comando_ejecucion, !resultado_programa)
												else comando_ejecucion := [!resultado_programa];
												
												linea_comandos.contenido <- [] @ [ejecutar_comando (pantalla, !comando_ejecucion)];
											end (* then *)
											else begin
												borrar_entrada pantalla;
												mostrar_grafica_programa := 0;
												
												repintarGraficas pantalla;
											end; (* else *)
										end; (* then *)
									end (* else *)
									else begin
										linea_comandos.contenido <- [] @ [ejecutar_comando (pantalla, operacion.contenido)];
										
										if (!conversiones = 1) then
											conversiones := 0;
									end; (*else *)
								end (* else *)
							end; (* else *)
(*						end;*)

						if (((es_grafica (formar_comando operacion.contenido)) = false) && (!ejecutando_programa = 0) && (eje_x.en_pantalla = false)) then
						begin
							if ((es_entero (obtener_contenido linea_comandos)) = true) then
								aux := poner_comando (pantalla, linea_comandos, ((formatear_salida ((obtener_contenido linea_comandos))) ^ "."))
							else aux := poner_comando (pantalla, linea_comandos, (formatear_salida (obtener_contenido linea_comandos)));
						end
						else ();
						aux := "";
						()
					end (* then *)
					else ();

					if ((estado_objecto operacion) = 0) then
					begin
						Funciones_comunes.guardar_operacion ((formar_comando operacion.contenido), fichero_ultima_operacion);
						operacion.contenido <- [];
						Funciones_comunes.guardar_operacion ((formar_comando !comando), fichero_ultimo_comando);
						comando := [];
						Funciones_comunes.guardar_operacion ((obtener_contenido linea_comandos), fichero_ultimo_resultado);
						Funciones_comunes.guardar_operacion ((obtener_contenido mode.widget), fichero_ultimo_modo);
						if ((obtener_contenido mode_base) = "") then
							Funciones_comunes.guardar_operacion ("d", fichero_ultimo_modo_base)
						else Funciones_comunes.guardar_operacion ((obtener_contenido mode_base), fichero_ultimo_modo_base);
					end (* then *)
					else ();

					linea_comandos.contenido <- [];
(*
	se pone esta marca para saber que se realizo una operacion y mientras siga valiendo 1
	no se realizo un nueva operacion, es decir, simplemente se pulso EXE
*)
					cambio_estado (operacion, 1);
					raices_comando := [];
					calcularRaices := false;
					esRaiz := false;
					()
				end; (* else *)
			end
			)] in (* ejecutar Command *)
		let marcoLineaInferiorEtiquetas9 = Frame.create form_principal [Width (Pixels 250); Height (Pixels 5); BorderWidth (Pixels 0)] in
			let espacio_vacio1d = Label.create form_principal [Text ""; Font "5"; Width (Pixels 9); Background Black] in
			let lZ = Label.create form_principal [Text "Z"; Font "5"; Width (Pixels 5); Background Black; Foreground Red] in
			let espacio_vacio2d = Label.create form_principal [Text ""; Font "5"; Width (Pixels 7); Background Black] in
			let corchete_izq = Label.create form_principal [Text "["; Font "5"; Width (Pixels 0); Background Black; Foreground Red] in
			let espacio_vacio3d = Label.create form_principal [Text ""; Font "5"; Width (Pixels 4); Background Black] in
			let corchete_drch = Label.create form_principal [Text "]"; Font "5"; Width (Pixels 9); Background Black; Foreground Red] in
			let espacio = Label.create form_principal [Text "SPACE"; Font "5"; Width (Pixels 5); Background Black; Foreground Red] in


(* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- *)

(*  --	Colocacion de los distintos elementos de la calculadora (botones, pantalla) en la Form *)
	(*  --	Seccion de PANTALLA *)
	pack [marco_pantalla_principal] [Anchor Center; Side Side_Top; In form_principal];
		pack [marco_pantalla] [Anchor Center; Side Side_Top; In marco_pantalla_principal];
			pack [pantalla] [Anchor Center; Side Side_Top; In marco_pantalla];
		pack [marco_informacion] [Anchor Center; Side Side_Top; In marco_pantalla_principal; After marco_pantalla];
			pack [frame_mode] [Anchor W; Side Side_Top; In marco_informacion];
				pack [lmode] [Anchor W; Side Side_Left; In frame_mode];

				pack [linea_informacion1] [Anchor W; Side Side_Top; In frame_mode; After lmode];
					pack [run; wrt; pcl; deg; rad] [Anchor W; Side Side_Left; In linea_informacion1];

				pack [linea_informacion2] [Anchor W; Side Side_Top; In frame_mode; After linea_informacion1];
					pack [gra; fix; sci; norm; comp] [Anchor W; Side Side_Left; In linea_informacion2];

				pack [linea_informacion3] [Anchor W; Side Side_Top; In frame_mode; After linea_informacion2];
					pack [base_n; sd1; lr1; defm; cont] [Anchor W; Side Side_Left; In linea_informacion3];

			pack [linea_informacion4] [Anchor W; Side Side_Top; In marco_informacion; After frame_mode];
				pack [shift_mode; lgrados; lr; lg; sd2; lr2] [Anchor W; Side Side_Left; In linea_informacion4];

			pack [linea_informacion5] [Anchor W; Side Side_Top; In marco_informacion; After linea_informacion4];
				pack [alpha_run; sumatorio_cuadrados_x; sumatorio_x; ln_f; sumatorio_cuadrados_y; sumatorio_y; sumatorio_xy] [Anchor W; Side Side_Left; In linea_informacion5];

	(*  --	Seccion de BOTONES *)
	pack [marco_BOTONES] [Anchor Center; Side Side_Top; In form_principal; After marco_pantalla_principal];
		pack [marcoLineaSuperiorEtiquetas1] [Anchor Center; Side Side_Top; In marco_BOTONES];
			pack [lAlpha; lock; goto; lbl; replay; ins] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas1];
		pack [marco_Linea_Botones1] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas1];
			pack [bShift; bAlpha; bProg; bIzq; bDrch; bMode] [Anchor N; Side Side_Left; In marco_Linea_Botones1];
		pack [marcoLineaInferiorEtiquetas1] [Anchor E; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones1];
			pack [comillas; valor] [Anchor N; Side Side_Left; In marcoLineaInferiorEtiquetas1];

		pack [marcoLineaSuperiorEtiquetas2] [Anchor W; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas1];
			pack [zoom_org; factor; plot; line; x_y; cls] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas2];
		pack [marco_Linea_Botones2] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas2];
			pack [bGraph; bRange; bTrace; bArriba; bAbajo; bGt] [Anchor N; Side Side_Left; In marco_Linea_Botones2];
		pack [marcoLineaInferiorEtiquetas2] [Anchor W; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones2];
			pack [resultados_anteriores; mismo_valor; datos] [Anchor N; Side Side_Left; In marcoLineaInferiorEtiquetas2];

		pack [marcoLineaSuperiorEtiquetas3] [Anchor E; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas2];
			pack [desplz_izq; int; frac; l10_x; le_x] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas3];
		pack [marco_Linea_Botones3] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas3];
			pack [bDos_puntos; bEng; bRaiz_cuadrada; bCuadrado; bLog; bLn] [Anchor N; Side Side_Left; In marco_Linea_Botones3];
		pack [marcoLineaInferiorEtiquetas3] [Anchor W; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones3];
			pack [xnor; lk; not; xor; lm; dec; ld; lmu; hex; lh; l_n; bin; lb; lpiro; oct; lo; lf] [Anchor N; Side Side_Left; In marcoLineaInferiorEtiquetas3];

		pack [marcoLineaSuperiorEtiquetas4] [Anchor W; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas3];
			pack [x_fact; desplz_izq2; sin_inv; cos_inv; tan_inv] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas4];
		pack [marco_Linea_Botones4] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas4];
			pack [bInversa; bGrados; bHiperbola; bSeno; bCoseno; bTangente] [Anchor N; Side Side_Left; In marco_Linea_Botones4];
		pack [marcoLineaInferiorEtiquetas4] [Anchor E; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones4];
			pack [l_A] [Anchor W; Side Side_Left; In marcoLineaInferiorEtiquetas4];
			pack [espacio_vacio1] [Side Side_Left; In marcoLineaInferiorEtiquetas4; After l_A];
			pack [lA] [Anchor E; Side Side_Left; In marcoLineaInferiorEtiquetas4; After espacio_vacio1];
			pack [l_B] [Anchor W; Side Side_Left; In marcoLineaInferiorEtiquetas4; After lA];
			pack [espacio_vacio2] [Side Side_Left; In marcoLineaInferiorEtiquetas4; After l_B];
			pack [lB] [Anchor E; Side Side_Left; In marcoLineaInferiorEtiquetas4; After espacio_vacio2];
			pack [l_C] [Anchor W; Side Side_Left; In marcoLineaInferiorEtiquetas4; After lB];
			pack [espacio_vacio3] [Side Side_Left; In marcoLineaInferiorEtiquetas4; After l_C];
			pack [lC] [Anchor E; Side Side_Left; In marcoLineaInferiorEtiquetas4; After espacio_vacio3];
			pack [l_D] [Anchor W; Side Side_Left; In marcoLineaInferiorEtiquetas4; After lC];
			pack [espacio_vacio4] [Side Side_Left; In marcoLineaInferiorEtiquetas4; After l_D];
			pack [lD] [Anchor E; Side Side_Left; In marcoLineaInferiorEtiquetas4; After espacio_vacio4];
			pack [l_E] [Anchor W; Side Side_Left; In marcoLineaInferiorEtiquetas4; After lD];
			pack [espacio_vacio5] [Side Side_Left; In marcoLineaInferiorEtiquetas4; After l_E];
			pack [lE] [Anchor E; Side Side_Left; In marcoLineaInferiorEtiquetas4; After espacio_vacio5];
			pack [l_F] [Anchor W; Side Side_Left; In marcoLineaInferiorEtiquetas4; After lE];
			pack [espacio_vacio6] [Side Side_Left; In marcoLineaInferiorEtiquetas4; After l_F];
			pack [lF] [Anchor E; Side Side_Left; In marcoLineaInferiorEtiquetas4; After espacio_vacio6];

		pack [marcoLineaSuperiorEtiquetas5] [Anchor W; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas4];
			pack [d_c; coma; punto_coma; abs; raiz_cubica] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas5];
		pack [marco_Linea_Botones5] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas5];
			pack [bRaices; bDesplazamiento_drch; bParentesis_izq; bParentesis_drch; bPotencia_y; bRaiz_x] [Anchor N; Side Side_Left; In marco_Linea_Botones5];
		pack [marcoLineaInferiorEtiquetas5] [Anchor E; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones5];
			pack [neg; lG; scl; lH; lI; lJ; lAnd; cl; lK; lOr; dt; lL] [Anchor N; Side Side_Left; In marcoLineaInferiorEtiquetas5];

		pack [marcoLineaSuperiorEtiquetas6] [Anchor W; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas5];
			pack [implica; igual; distinto; mcl; off] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas6];
		pack [marco_Linea_Botones6] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas6];
			pack [bSiete; bOcho; bNueve; bDelete; bAc] [Anchor N; Side Side_Left; In marco_Linea_Botones6];
		pack [marcoLineaInferiorEtiquetas6] [Anchor W; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones6];
			pack [lAa; lM; lBa; espacio_vacio1a; lN; lra; lO; lON] [Anchor W; Side Side_Left; In marcoLineaInferiorEtiquetas6];

		pack [marcoLineaSuperiorEtiquetas7] [Anchor W; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas6];
			pack [lsz; igual_mayor; igual_menor; zoom_xf; zoom_x_inv_f] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas7];
		pack [marco_Linea_Botones7] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas7];
			pack [bCuatro; bCinco; bSeis; bPor; bEntre] [Anchor N; Side Side_Left; In marco_Linea_Botones7];
		pack [marcoLineaInferiorEtiquetas7] [Anchor W; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones7];
			pack [media_y; espacio_vacio1b; lP; varianza_y; espacio_vacio2b; lQ; inv_varianza_y; espacio_vacio3b; lR; regresion_logaritmica_x; espacio_vacio4b; lS; regresion_logaritmica_y; espacio_vacio5b; lT] [Anchor N; Side Side_Left; In marcoLineaInferiorEtiquetas7];

		pack [marcoLineaSuperiorEtiquetas8] [Anchor W; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas7];
			pack [dsz; mayor; menor; pol; lrec] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas8];
		pack [marco_Linea_Botones8] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas8];
			pack [bUno; bDos; bTres; bMas; bMenos] [Anchor N; Side Side_Left; In marco_Linea_Botones8];
		pack [marcoLineaInferiorEtiquetas8] [Anchor W; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones8];
			pack [media_x; espacio_vacio1c; lU; varianza_x; espacio_vacio2c; lV; inv_varianza_x; espacio_vacio3c; lW; espacio_vacio4c; lX; espacio_vacio5c; lY] [Anchor N; Side Side_Left; In marcoLineaInferiorEtiquetas8];

		pack [marcoLineaSuperiorEtiquetas9] [Anchor W; Side Side_Top; In marco_BOTONES; After marcoLineaInferiorEtiquetas8];
			pack [rnd; ran; pi; opuesto] [Anchor N; Side Side_Left; In marcoLineaSuperiorEtiquetas9];
		pack [marco_Linea_Botones9] [Anchor Center; Side Side_Top; In marco_BOTONES; After marcoLineaSuperiorEtiquetas9];
			pack [bCero; bPunto; bExponente; bValor_anterior; bEjecutar] [Anchor N; Side Side_Left; In marco_Linea_Botones9];
		pack [marcoLineaInferiorEtiquetas9] [Anchor W; Side Side_Top; In marco_BOTONES; After marco_Linea_Botones9];
			pack [espacio_vacio1d; lZ; espacio_vacio2d; corchete_izq; espacio_vacio3d; corchete_drch; espacio] [Anchor N; Side Side_Left; In marcoLineaInferiorEtiquetas9];

	Wm.title_set form_principal "A.C.T.P. - CASIO fx-6300G";
	Wm.resizable_set form_principal false false;
	Wm.positionfrom_set form_principal FromProgram;
	Tk.update_idletasks ();
	Focus.set form_principal;
	iniciarGUI pantalla;
	mainLoop ()
;;

Printexc.catch main ();;
