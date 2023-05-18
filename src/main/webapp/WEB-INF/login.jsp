<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 5/12/2023
  Time: 8:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.0.slim.js" integrity="sha256-7GO+jepT9gJe9LB4XFf8snVOjX3iYNb0FHYr5LI1N5c=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/css/bootstrap.min.css" integrity="sha512-rt/SrQ4UNIaGfDyEXZtNcyWvQeOq0QLygHluFQcSjaGB04IxWhal71tKuzP6K8eYXYB6vJV4pHkXcmFGGQ1/0w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js" integrity="sha512-7rusk8kGPFynZWu26OKbTeI+QPoYchtxsmPeBqkHIEXJxeun4yJ4ISYe7C6sz9wdxeE1Gk3VxsIWgCZTc+vX3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.5/sweetalert2.all.min.js" integrity="sha512-2JsZvEefv9GpLmJNnSW3w/hYlXEdvCCfDc+Rv7ExMFHV9JNlJ2jaM+uVVlCI1MAQMkUG8K83LhsHYx1Fr2+MuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<html>
<head>
    <title>Log In</title>
    <style>
        .carousel-item {
            height: 50vh;
        }
        .card {
            box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
        }

        .price {
            color: #263238;
            font-size: 24px;
        }

        .card-title {
            color:#263238
        }

        .sale {
            color: #E53935
        }

        .sale-badge {
            background-color: #E53935
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/layout/css_head.jsp"></jsp:include>
<div style="text-align: center; color: red;">
    <c:if test="${requestScope.error  != null && !error.isEmpty()}">
        ${error}
    </c:if>
</div>
<div class="container">
    <div class="col-lg-6 offset-3 ">
        <div class="account_form">
            <h1 style="text-align: center">LOG IN</h1>
            <div style="text-align: center" >
                <form action="/login" method="post">
                    <div >
                       <div> <label>Username or email <span>*</span></label></div>
                    <div><input type="text" name="username"></div>
                    </div>
                    <div>
                        <div> <label>Passwords <span>*</span></label></div>
                        <div> <input type="password" name="password"></div>
                    </div>
                    <div class="login_submit">
                        <button type="submit" style="    margin: 10px;width: 190px;background: dodgerblue;color: white;">Enter</button>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/layout/css_food.jsp"></jsp:include>

</body>
</html>
