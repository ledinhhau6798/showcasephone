package com.example.showcasephone.service;

import com.example.showcasephone.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAllProducts();
    void addProduct(Product product);
    void updateProduct(long idProduct, Product product);

    void deleteProduct(long idProduct);
    Product finAllId(long id);
    List<Product> findAllProductsPagging(String kw, long idCategory, int offset, int limit);

    int getNoOfRecords();
}
