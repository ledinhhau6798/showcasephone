package com.example.showcasephone.service;

import com.example.showcasephone.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

public class UserServiceImlp extends DBContest implements IUserService{
    @Override
    public User checkUserNamePassword(String username, String password) {
        Connection connection = getConnection();
        try{
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM c0123k1_product.user where email = ? and password = ?");
            preparedStatement.setString(1,username);
            preparedStatement.setString(2,password);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()){
                long idrs = rs.getLong("id");
                String namers = rs.getString("email");
                String passwordrs = rs.getString("password");
                int roleid = rs.getInt("roleid");
                User user = new User(idrs,namers,passwordrs,roleid);
                return user;
            }
        }catch (SQLException e){

        }
        return null;
    }
}
