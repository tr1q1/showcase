package es.pernasferreiro.ml.navrec.jms.model;

import java.io.Serializable;
import java.util.Objects;

public class Click implements Serializable {
    private static final long serialVersionUID = 42L;

    @Override
    public String toString() {
        return "Click{" +
                "timeStamp=" + timeStamp +
                ", application='" + application + '\'' +
                ", seccion=" + seccion +
                ", ip='" + ip + '\'' +
                ", user='" + user + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Click click = (Click) o;
        return Objects.equals(getTimeStamp(), click.getTimeStamp()) &&
                Objects.equals(getApplication(), click.getApplication()) &&
                Objects.equals(getSeccion(), click.getSeccion()) &&
                Objects.equals(getIp(), click.getIp()) &&
                Objects.equals(getUser(), click.getUser());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getTimeStamp(), getApplication(), getSeccion(), getIp(), getUser());
    }

    private Long timeStamp;
    private String application;
    private Integer seccion;
    private String ip;

    public String getApplication() {
        return application;
    }

    public void setApplication(String application) {
        this.application = application;
    }

    private String user;

    public Long getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(Long timeStamp) {
        this.timeStamp = timeStamp;
    }

    public Integer getSeccion() {
        return seccion;
    }

    public void setSeccion(Integer seccion) {
        this.seccion = seccion;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
}
