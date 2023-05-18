<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 5/12/2023
  Time: 12:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/css/bootstrap.min.css" integrity="sha512-rt/SrQ4UNIaGfDyEXZtNcyWvQeOq0QLygHluFQcSjaGB04IxWhal71tKuzP6K8eYXYB6vJV4pHkXcmFGGQ1/0w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js" integrity="sha512-7rusk8kGPFynZWu26OKbTeI+QPoYchtxsmPeBqkHIEXJxeun4yJ4ISYe7C6sz9wdxeE1Gk3VxsIWgCZTc+vX3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.5/sweetalert2.all.min.js" integrity="sha512-2JsZvEefv9GpLmJNnSW3w/hYlXEdvCCfDc+Rv7ExMFHV9JNlJ2jaM+uVVlCI1MAQMkUG8K83LhsHYx1Fr2+MuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>

<jsp:include page="/WEB-INF/layout/css_head.jsp"></jsp:include>
<div style="text-align: center; color: red">
    <c:if test="${requestScope.error != null}">
       <h1> ${error} </h1>
    </c:if>
</div>
<div class="container mt-5">
    <div class="row justify-content-center">

        <div class="col-6">
            <c:if test="${requestScope.errors!=null}">
                <div class="alert alert-danger" role="alert">
                    <ul>
                        <c:forEach items="${requestScope.errors}" var="e">
                            <li>${e}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <form method="post">
                <div class="row mb-2">
                    <label class="col-4">Name</label>
                    <input name="name" class="col-8 form-control" value="${requestScope.product.getName()}"/>
                </div>
                <div class="row mb-2">
                    <label class="col-4">Image</label>
                    <input name="image" class="col-8 form-control" value="${requestScope.product.getImage()}"/>
                </div>
                <div class="row mb-2">
                    <label class="col-4">Price</label>
                    <input name="price" class="col-8 form-control" value="${requestScope.product.getPrice()}"/>
                </div>
                <div class="row mb-2">
                    <label class="col-4">The Firm</label>
                    <select name="idPhone" class="form-control col-8">
                        <c:forEach items="${requestScope.productTypes}" var="pt">
                            <option value="${pt.getId()}"
                                    <c:if test="${pt.getId() == requestScope.product.getIdPhone()}">
                                        selected
                                    </c:if>
                            >${pt.getName()}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="row" style="display: flex;justify-content: end;" >
                    <div >
                    <input type="submit" class="col-8 offset-4 btn btn-primary" style="    width: 450px; margin-right: 20px;"/></div>
                    <div><a href="/product">
                        <button type="button" class="mybutton btn btn-dark" style="margin-left: 10px;">Back</button>
                    </a></div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/layout/css_food.jsp"></jsp:include>

</body>
</html>
