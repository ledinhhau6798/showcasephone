package com.example.showcasephone.controller;

import com.example.showcasephone.model.Product;
import com.example.showcasephone.model.ProductType;
import com.example.showcasephone.service.ProductServiceImpl;
import com.example.showcasephone.service.ProductTypeServiceImpl;
import com.example.showcasephone.uitils.ValidateProduct;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    private ProductServiceImpl productService;
    private ProductTypeServiceImpl productTypeService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        productService = new ProductServiceImpl();
        productTypeService = new ProductTypeServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }
        switch (action) {
            case "add":
                showAddProduct(request, response);
                break;
            case "edit":
                ShowEditProduct(request, response);
                break;
            default:
                showProducts(request, response);
        }
    }

    private void ShowEditProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long idProduct = Long.parseLong(request.getParameter("id"));

        Product product = productService.finAllId(idProduct);
        if (product == null) {
            request.setAttribute("error","Invalid Id");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/edit.jsp");
            requestDispatcher.forward(request,response);
        }else{
            request.setAttribute("product", product);
            request.setAttribute("productTypes", productTypeService.findAllProductType());
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/edit.jsp");
            requestDispatcher.forward(request, response);
        }
    }

    private void showAddProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ProductType> productTypes = productTypeService.findAllProductType();
        request.setAttribute("productTypes", productTypes);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/add.jsp");
        requestDispatcher.forward(request, response);
    }

    private void showProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String kw = "";
        if (request.getParameter("kw") != null) {
            kw = request.getParameter("kw");
        }
        long idPhone = -1;
        if (request.getParameter("idPhone") != null) {
            idPhone = Long.parseLong(request.getParameter("idPhone"));
        }
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int limit = 3;
        if (request.getParameter("limit") != null) {
            limit = Integer.parseInt(request.getParameter("limit"));
        }


        List<Product> products = productService.findAllProductsPagging(kw, idPhone, (page - 1) * limit, limit);
        List<ProductType> productTypes = productTypeService.findAllProductType();


        int noOfRecords = productService.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / limit);

        request.setAttribute("products", products);
        request.setAttribute("productTypes", productTypes);

        request.setAttribute("kw", kw);
        request.setAttribute("idPhone", idPhone);
        request.setAttribute("currentPage", page);
        request.setAttribute("limit", limit);
        request.setAttribute("noOfPages", noOfPages);
        String message = null;
        if (request.getParameter("message") != null) {
            message = request.getParameter("message");
        }

        request.setAttribute("message", message);


        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/products.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        if (request.getSession().getAttribute("user") == null) {
            response.sendRedirect("/login");
            return;
        }
        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "edit":
                editProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        long idProduct = Long.parseLong(request.getParameter("id"));
        productService.deleteProduct(idProduct);
        response.sendRedirect("/product");
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<String> errors = new ArrayList<>();
        Product product = new Product();
        long idProduct = Long.parseLong(request.getParameter("id"));
        validateName(request, errors, product);
        product.setImage(request.getParameter("image"));
        validatePrice(request, errors, product);
        validateIdPhone(request, errors, product);

        if (errors.isEmpty()) {
            productService.updateProduct(idProduct, product);
            response.sendRedirect("/product?message=editsuccess");

        } else {
            request.setAttribute("errors", errors);
            request.setAttribute("product", product);
            request.setAttribute("productTypes", productTypeService.findAllProductType());
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/edit.jsp");
            requestDispatcher.forward(request, response);
        }

    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        Product product = new Product();

        validateName(request, errors, product);
        product.setImage(request.getParameter("image"));
        validatePrice(request, errors, product);
        validateIdPhone(request, errors, product);

        if (!errors.isEmpty()) {
            request.setAttribute("product", product);
            request.setAttribute("errors", errors);
            request.setAttribute("productTypes", productTypeService.findAllProductType());
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/add.jsp");
            requestDispatcher.forward(request, response);
        } else {
            productService.addProduct(product);

            response.sendRedirect("/product?message=addsuccess");
        }
    }


    private void validateIdPhone(HttpServletRequest request, List<String> errors, Product product) {
        long idPhone = 0;
        try {
            idPhone = Long.parseLong(request.getParameter("idPhone"));
        } catch (NumberFormatException numberFormatException) {
            errors.add("Invalid format");
        }
        product.setIdPhone(idPhone);
    }

    private void validatePrice(HttpServletRequest request, List<String> errors, Product product) {
        float price = 0;
        try {
            price = Float.parseFloat(request.getParameter("price"));
            if (price < 0) {
                errors.add("Price must be greater than none");
            } else {
                product.setPrice(price);
            }
        } catch (NumberFormatException numberFormatException) {
            errors.add("Invalid price format");
        }
        product.setPrice(price);
    }

    private void validateName(HttpServletRequest request, List<String> errors, Product product) {
        String name = request.getParameter("name");
        if (!ValidateProduct.isName(name)) {
            errors.add("Invalid name. The name does not contain numbers and special characters");
        }
        product.setName(name);
    }

}
