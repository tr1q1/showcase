package es.pernasferreiro.ml.navrec.es.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;

import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

@Document(indexName = "mla_nav", type = "clicks")
public class Click implements Serializable {
    private static final long serialVersionUID = 43L;

    @Id
    private String id;
    private Long timeStamp;
    private String application;
    private Integer seccion;
    private String ip;
    private String user;

    public Click() {
    }

    public Click(String id, Long timeStamp, String application, Integer seccion, String ip, String user) {
        this.id = id;
        this.timeStamp = timeStamp;
        this.application = application;
        this.seccion = seccion;
        this.ip = ip;
        this.user = user;
    }

    public Click(es.pernasferreiro.ml.navrec.jms.model.Click clickMessage) {
        UUID uuid = UUID.randomUUID();
        this.id = uuid.toString();

        this.timeStamp = clickMessage.getTimeStamp();
        this.application = clickMessage.getApplication();
        this.seccion = clickMessage.getSeccion();
        this.ip = clickMessage.getIp();
        this.user = clickMessage.getUser();
    }

    @Override
    public String toString() {
        return "Click{" +
                "id='" + id + '\'' +
                ", timeStamp=" + timeStamp +
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
        return Objects.equals(getId(), click.getId()) &&
                Objects.equals(getTimeStamp(), click.getTimeStamp()) &&
                Objects.equals(getApplication(), click.getApplication()) &&
                Objects.equals(getSeccion(), click.getSeccion()) &&
                Objects.equals(getIp(), click.getIp()) &&
                Objects.equals(getUser(), click.getUser());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getTimeStamp(), getApplication(), getSeccion(), getIp(), getUser());
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getApplication() {
        return application;
    }

    public void setApplication(String application) {
        this.application = application;
    }

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
