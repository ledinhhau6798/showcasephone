package com.example.showcasephone.service;

import com.example.showcasephone.model.ProductType;

import java.util.List;

public interface IProductTypeService {
    List<ProductType> findAllProductType();
    ProductType findProductTypeById(long id);
}
