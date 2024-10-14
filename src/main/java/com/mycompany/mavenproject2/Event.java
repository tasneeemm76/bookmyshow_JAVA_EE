package com.mycompany.mavenproject2;

public class Event {
    private final String eventName;
    private final String description;
    private final String dateTime;
    private final String location;
    private final int categoryId;

    public Event(String eventName, String description, String dateTime, String location, int categoryId) {
        this.eventName = eventName;
        this.description = description;
        this.dateTime = dateTime;
        this.location = location;
        this.categoryId = categoryId;
    }

    // Getters
    public String getEventName() {
        return eventName;
    }

    public String getDescription() {
        return description;
    }

    public String getDateTime() {
        return dateTime;
    }

    public String getLocation() {
        return location;
    }

    public int getCategoryId() {
        return categoryId;
    }
}
