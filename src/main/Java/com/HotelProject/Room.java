package com.HotelProject;

public class Room {
    private int roomNumber;
    private String[] issues;
    private String scenery;
    private boolean isExtendable;
    private float price;
    private String[] amenities;
    private int capacity;
    private int hotelID;
    private String hotelChainName;
    //predetermined data so no need to multi constructors

    public Room(int roomNumber, String[] issues, String scenery, boolean isExtendable, float price, String[] amenities, int capacity, int hotelID) {
        this.roomNumber = roomNumber;
        this.issues = issues;
        this.scenery = scenery;
        this.isExtendable = isExtendable;
        this.price = price;
        this.amenities = amenities;
        this.capacity = capacity;
        this.hotelID = hotelID;
    }


    public int getRoomNumber() {
        return roomNumber;
    }

    public String getIssues() {
        String issue = "no issues";
        try {
            issue = issues[0];
            for (int i = 1; i < issues.length; i++) {
                issue += ", " + issues[i];
            }
        }
        catch (Exception e){
            return issue;
        }
        return issue;
    }

    public String getscenery() {
        return scenery;
    }

    public boolean isExtendable() {
        return isExtendable;
    }

    public float getPrice() {
        return price;
    }

    public String getAmenities() {
        String amen = "no amenities";
        try {
            amen = amenities[0];
            for (int i = 1; i < amenities.length; i++) {
                amen += ", " + amenities[i];
            }
        }
        catch (Exception e){
            return amen;
        }
        return amen;
    }

    public int getCapacity() {
        return capacity;
    }

    public int getHotelID() {
        return hotelID;
    }

    public String getHotelChainName() {
        return hotelChainName;
    }

    @Override
    public String toString() {
        //amenities and issues are naturally not nullable so this won't fail
        String amenitiesStr = amenities[0];
        for (int i = 0 ; i < amenities.length; i++){
            amenitiesStr += " " + amenities[i];
        }
        String issuesStr = issues[0];
        for (int i = 0 ; i < issues.length; i++){
            issuesStr += " " + issues[i];
        }
        return "<ul>"
                + "<li>room number= " + roomNumber + "</li>"
                + "<li>hotel id= " + hotelID + "</li>"
                + "<li>issues with room= " + issuesStr + "</li>"
                + "<li>amenities included= " + amenitiesStr + "</li>"
                + "<li>price= " + price + "</li>"
                + "<li>capacity= " + capacity + "</li>";
    }
}
