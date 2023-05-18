package com.example.showcasephone.service;

import com.example.showcasephone.model.ProductType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductTypeServiceImpl extends DBContest implements IProductTypeService{
    private static final String FIND_ALL_PRODUCTTYPE = "SELECT * FROM producttype";
    private static final String FIND_BY_ID = "SELECT * FROM producttype where id = ?";

    @Override
    public List<ProductType> findAllProductType() {
        List<ProductType> productTypes = new ArrayList<>();
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_ALL_PRODUCTTYPE);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                long id = rs.getLong("id");
                String name = rs.getString("name");

                ProductType productType = new ProductType(id,name);
                productTypes.add(productType);
            }
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
        return productTypes;
    }

    @Override
    public ProductType findProductTypeById(long id) {
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_BY_ID);
            preparedStatement.setLong(1,id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                long ids = rs.getLong("id");
                String names = rs.getString("name");

                ProductType productType = new ProductType(ids,names);
                return productType;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }
}
