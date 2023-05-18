package com.example.showcasephone.controller;

import com.example.showcasephone.model.User;
import com.example.showcasephone.service.IUserService;
import com.example.showcasephone.service.UserServiceImlp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    private IUserService IUserService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        IUserService = new UserServiceImlp();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(request.getSession().getId());
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = IUserService.checkUserNamePassword(username, password);
        if(password.length() < 6) {
            request.setAttribute("error","Password không được dưới 6 kí tự");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
            requestDispatcher.forward(request,response);
        }
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("/product");
        } else {
            request.setAttribute("error","Wrong account or password, please login again");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
            requestDispatcher.forward(request,response);
        }
    }
}
