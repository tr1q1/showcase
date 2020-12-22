package general;

public class Log {
	
	public static int INFO_MESSAGE = 0;
	public static int WARNING_MESSAGE = 1;
	public static int ERROR_MESSAGE = 2;
	
	public static void message(String mensaje, int tipo){
		
		switch(tipo){
		case 0:
			break;
		case 1:
			break;
		case 2:
			break;
		default:
			Log.message("El tipo de mensaje de Log no existe", Log.ERROR_MESSAGE);			
		}
		
		System.out.println(mensaje);
	}

}
