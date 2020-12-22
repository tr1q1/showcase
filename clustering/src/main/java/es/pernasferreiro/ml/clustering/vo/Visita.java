package es.pernasferreiro.ml.clustering.vo;

import java.io.Serializable;
import java.util.Objects;

public final class Visita implements Serializable {
    private String UserID;
    private String VenueID;
    private String VenueCategoryID;
    private String VenueCategoryName;
    private String Latitude;
    private String Longitude;
    private String Timezone;
    private String UTCTime;

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String userID) {
        UserID = userID;
    }

    public String getVenueID() {
        return VenueID;
    }

    public void setVenueID(String venueID) {
        VenueID = venueID;
    }

    public String getVenueCategoryID() {
        return VenueCategoryID;
    }

    public void setVenueCategoryID(String venueCategoryID) {
        VenueCategoryID = venueCategoryID;
    }

    public String getVenueCategoryName() {
        return VenueCategoryName;
    }

    public void setVenueCategoryName(String venueCategoryName) {
        VenueCategoryName = venueCategoryName;
    }

    public String getLatitude() {
        return Latitude;
    }

    public void setLatitude(String latitude) {
        Latitude = latitude;
    }

    public String getLongitude() {
        return Longitude;
    }

    public void setLongitude(String longitude) {
        Longitude = longitude;
    }

    public String getTimezone() {
        return Timezone;
    }

    public void setTimezone(String timezone) {
        Timezone = timezone;
    }

    public String getUTCTime() {
        return UTCTime;
    }

    public void setUTCTime(String UTCTime) {
        this.UTCTime = UTCTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Visita visita = (Visita) o;
        return Objects.equals(UserID, visita.UserID) &&
                Objects.equals(VenueID, visita.VenueID) &&
                Objects.equals(VenueCategoryID, visita.VenueCategoryID) &&
                Objects.equals(VenueCategoryName, visita.VenueCategoryName) &&
                Objects.equals(Latitude, visita.Latitude) &&
                Objects.equals(Longitude, visita.Longitude) &&
                Objects.equals(Timezone, visita.Timezone) &&
                Objects.equals(UTCTime, visita.UTCTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(UserID, VenueID, VenueCategoryID, VenueCategoryName, Latitude, Longitude, Timezone, UTCTime);
    }

    @Override
    public String toString() {
        return "Visita{" +
                "UserID='" + UserID + '\'' +
                ", VenueID='" + VenueID + '\'' +
                ", VenueCategoryID='" + VenueCategoryID + '\'' +
                ", VenueCategoryName='" + VenueCategoryName + '\'' +
                ", Latitude='" + Latitude + '\'' +
                ", Longitude='" + Longitude + '\'' +
                ", Timezone='" + Timezone + '\'' +
                ", UTCTime='" + UTCTime + '\'' +
                '}';
    }
}
