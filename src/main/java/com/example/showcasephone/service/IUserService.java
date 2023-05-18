package com.example.showcasephone.service;

import com.example.showcasephone.model.User;

public interface IUserService {
    User checkUserNamePassword(String username, String password);
}
