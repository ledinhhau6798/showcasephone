package com.example.showcasephone.model;

public class Product {
    private long id;
    private String name;
    private String image;
    private float price;
    private long idPhone;

    public Product(long id, String name, String image, float price, long idPhone) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.idPhone = idPhone;
    }

    public Product() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public long getIdPhone() {
        return idPhone;
    }

    public void setIdPhone(long idPhone) {
        this.idPhone = idPhone;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", image='" + image + '\'' +
                ", price=" + price +
                ", idPhone=" + idPhone +
                '}';
    }
}
