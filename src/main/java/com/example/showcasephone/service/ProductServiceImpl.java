package com.example.showcasephone.service;

import com.example.showcasephone.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductServiceImpl extends DBContest implements IProductService{
    private static final String FIND_ALL_PRODUCTSS = "SELECT * FROM product";
    private static final String INSER_INTO_PRODUCT = "INSERT INTO `product` (`name`, `image`, `price`, `idPhone`) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT = "UPDATE `product` SET `name` = ?, `image` = ?, `price` = ?, `idPhone` = ? WHERE (`id` = ?)";
    private static final String DELETE_PRODUCTSS = "DELETE FROM `product` WHERE (`id` = ?)";
    private static final String FIND_PRODUCT_BY_ID = "SELECT * FROM product where id = ?";
    private static final String SELECT_PRODUCTS_PAGGING = "SELECT SQL_CALC_FOUND_ROWS * FROM product where `name` like ? limit ?, ?";
    private static final String SELECT_PRODUCTS_CATEGORY_PAGGING = "SELECT SQL_CALC_FOUND_ROWS * FROM product where `name` like ? and idPhone = ? limit ?, ?;";

    @Override
    public List<Product> findAllProducts() {
        List<Product> products = new ArrayList<>();
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(FIND_ALL_PRODUCTSS);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                long id = rs.getLong("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                float price = rs.getFloat("price");
                long idPhone = rs.getLong("idPhone");

                Product p = new Product(id, name, image, price, idPhone);
                products.add(p);
            }
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
        return products;
    }

    @Override
    public void addProduct(Product product) {
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(INSER_INTO_PRODUCT);
            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getImage());
            preparedStatement.setFloat(3, product.getPrice());
            preparedStatement.setLong(4, product.getIdPhone());
            preparedStatement.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }

    }

    @Override
    public void updateProduct(long idProduct, Product product) {
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT);
            preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getImage());
            preparedStatement.setFloat(3, product.getPrice());
            preparedStatement.setLong(4, product.getIdPhone());
            preparedStatement.setLong(5, idProduct);

            System.out.println("updateProduct: " + preparedStatement);
            preparedStatement.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public void deleteProduct(long idProduct) {
        Connection connection = getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCTSS);
            preparedStatement.setLong(1, idProduct);
            preparedStatement.executeUpdate();
            connection.close();
        } catch (SQLException e) {
            printSQLException(e);
        }

    }

    @Override
    public Product finAllId(long id) {
        Connection connection = getConnection();
        try {

            PreparedStatement preparedStatement = connection.prepareStatement(FIND_PRODUCT_BY_ID);
            preparedStatement.setLong(1,id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()){
                long ids = rs.getLong("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                float price = rs.getFloat("price");
                long idPhone = rs.getLong("idPhone");

                Product product = new Product(ids, name, image, price, idPhone);

                return product;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    @Override
    public List<Product> findAllProductsPagging(String kw, long idCategory, int offset, int limit) {
        List<Product> products = new ArrayList<>();
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement;
            if (idCategory == -1) {

                preparedStatement = connection.prepareStatement(SELECT_PRODUCTS_PAGGING);
                preparedStatement.setString(1, "%" + kw + "%");
                preparedStatement.setInt(2, offset);
                preparedStatement.setInt(3, limit);
            }else{

                preparedStatement = connection.prepareStatement(SELECT_PRODUCTS_CATEGORY_PAGGING);
                preparedStatement.setString(1, "%" + kw + "%");
                preparedStatement.setLong(2, idCategory);
                preparedStatement.setInt(3, offset);
                preparedStatement.setInt(4, limit);
            }
            System.out.println("findAllProductsPagging: " + preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Product p = getProductInfo(rs);
                products.add(p);
            }
            rs = preparedStatement.executeQuery("select FOUND_ROWS()");
            while (rs.next()) {
                noOfRecords = rs.getInt(1);
            }
        } catch (SQLException sqlException) {
            printSQLException(sqlException);
        }
        return products;
    }

    private Product getProductInfo(ResultSet rs) throws SQLException {
        long idProduct = rs.getLong("id");
        String nameProduct = rs.getString("name");
        String imageProduct = rs.getString("image");
        float priceProduct = rs.getFloat("price");
        long idPhoneProduct = rs.getLong("idPhone");
        Product product = new Product(idProduct,nameProduct,imageProduct,priceProduct,idPhoneProduct);
        return product;
    }

    private int noOfRecords;
    @Override
    public int getNoOfRecords() {
        return this.noOfRecords;
    }
}
