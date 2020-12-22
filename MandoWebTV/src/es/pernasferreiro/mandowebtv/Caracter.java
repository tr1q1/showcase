package es.pernasferreiro.mandowebtv;


public final class Caracter
{
    private int pulsaciones;
    private String tecla;
    
    public Caracter(String s, int i)
    {
        tecla = s;
        pulsaciones = i;
    }

    public final int getPulsaciones()
    {
        return pulsaciones;
    }

    public final String getTecla()
    {
        return tecla;
    }

    public final void setPulsaciones(int i)
    {
        pulsaciones = i;
    }

    public final void setTecla(String s)
    {
        tecla = s;
    }
} // class