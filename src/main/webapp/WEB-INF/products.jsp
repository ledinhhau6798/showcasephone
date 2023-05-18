<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 5/12/2023
  Time: 8:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.7.0.slim.js"
            integrity="sha256-7GO+jepT9gJe9LB4XFf8snVOjX3iYNb0FHYr5LI1N5c=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/css/bootstrap.min.css"
          integrity="sha512-rt/SrQ4UNIaGfDyEXZtNcyWvQeOq0QLygHluFQcSjaGB04IxWhal71tKuzP6K8eYXYB6vJV4pHkXcmFGGQ1/0w=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"
            integrity="sha512-7rusk8kGPFynZWu26OKbTeI+QPoYchtxsmPeBqkHIEXJxeun4yJ4ISYe7C6sz9wdxeE1Gk3VxsIWgCZTc+vX3g=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
          integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.5/sweetalert2.all.min.js"
            integrity="sha512-2JsZvEefv9GpLmJNnSW3w/hYlXEdvCCfDc+Rv7ExMFHV9JNlJ2jaM+uVVlCI1MAQMkUG8K83LhsHYx1Fr2+MuA=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>


    <title>Show</title>
</head>
<style>


    .card {
        box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
    }

    .price {
        color: #263238;
        font-size: 24px;
    }

    .card-title {
        color: #263238
    }


    .logout {
        display: flex;
        justify-content: end;
    }

    .text-center {
        display: flex;
        justify-content: space-between;
    }

    .href {
        display: flex;
        justify-content: space-around;
    }

</style>
<body>

<!-- carousel -->

<!-- carousel -->
<div id="carouselExampleCaptions" class="carousel slide carousel-fade" data-mdb-ride="carousel">
    <jsp:include page="/WEB-INF/layout/css_head.jsp"></jsp:include>
</div>

<!--Main layout-->
<main>
    <div class="container">

        <div class="notification">
            <c:if test="${requestScope.message != null}">
                <script>
                    let message = '<%= request.getAttribute("message")%>';

                    let action = message.substring(0, 3);
                    console.log(action);

                    let titleAction = "";

                    switch (action) {
                        case 'add':
                            titleAction = "Add";
                            history.pushState({}, null, 'product');
                            break;
                        case 'edi':
                            titleAction = "Update";
                            history.pushState({}, null, 'product');
                            break;
                    }
                    window.onload = function () {
                        Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: titleAction + " success",
                            showConfirmButton: false,
                            timer: 1500
                        })
                    };
                </script>
            </c:if>
        </div>
        <!-- Navbar -->
        <div style="display: flex; justify-content: end">
            <c:if test="${sessionScope.user != null}">
                <a href="/logout" class="logout btn btn-primary" style="width: 80px; text-align: right">Logout</a>
            </c:if>
        </div>
        <nav class="navbar navbar-expand-lg navbar-dark mt-3 mb-5 shadow p-2" style="background-color: #607D8B">
            <!-- Container wrapper -->
            <div class="container-fluid">


                <div class="row head-search">
                    <div class="col-4">
                        <c:if test="${sessionScope.user != null && sessionScope.user.getRoleid() == 1}">
                            <a href="/product?action=add">
                                <button class="mybtn" style="height: 40px"><i class="fa-solid fa-square-plus"> Add</i>
                                </button>
                            </a>
                        </c:if>
                    </div>
                    <form class="col-8 d-flex" action="/product" method="get">
                        <input name="kw" type="text" class="form-control mysearch " style="width: 800px; margin: 0 5px"
                               value="${requestScope.kw}">
                        <select name="idPhone" class="form-control mybutton" style="width: 200px">
                            <option value="-1">ALL</option>
                            <c:forEach items="${requestScope.productTypes}" var="c">
                                <option value="${c.getId()}"
                                        <c:if test="${requestScope.idPhone == c.getId()}">selected</c:if>
                                >${c.getName()}</option>
                            </c:forEach>
                        </select>
                        <button class="btn btn-primary mybutton">Search</button>
                    </form>
                </div>
            </div>
        </nav>

        <!-- Products -->
        <section>
            <div>
                <form action="/product?action=delete" method="post" id="frmDelete">
                    <input id="txtDeleteId" type="hidden" name="id">
                </form>
                <div class="row text-center">
                    <c:forEach items="${requestScope.products}" var="p">
                        <div class="col-lg-3 col-md-6 mb-4">
                            <div class="card">
                                <div class="bg-image hover-zoom ripple ripple-surface ripple-surface-light"
                                     data-mdb-ripple-color="light">
                                    <img src="${p.getImage()}" style="height: 200px;"
                                         class="w-100"/>
                                    <div class="hover-overlay">
                                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title mb-2">${p.getName()}</h5>
                                    <p>$${p.getPrice()}đ</p>
                                    <h6 class="mb-3 price"><c:forEach items="${requestScope.productTypes}" var="pt">
                                        <c:if test="${pt.getId() == p.getIdPhone()}">
                                            ${pt.getName()}
                                        </c:if>
                                    </c:forEach></h6>
                                </div>
                                <div class="href" style="padding: 12px">
                                    <c:if test="${sessionScope.user != null && sessionScope.user.getRoleid() == 1}">
                                        <div><a href="/product?action=edit&id=${p.getId()}"><i
                                                class="fa-solid fa-pen-to-square"></i></a></div>
                                        <div><a href="javascript:;"
                                                onclick="handleDelete(${p.getId()}, '${p.getName()}')"><i
                                                class="fa-solid fa-trash"></i></a></div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <%--            phân trang--%>
        </section>
        <nav aria-label="Page navigation example" class="d-flex justify-content-center mt-3">
            <ul class="pagination justify-content-end">
                <c:if test="${requestScope.currentPage != 1}">
                    <li class="page-item"><a class="page-link"
                                             href="/product?kw=${requestScope.kw}&page=1&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">To
                        The Top</a>

                    </li>
                    <li class="page-item"><a class="page-link"
                                             href="/product?kw=${requestScope.kw}&page=${requestScope.currentPage-1}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">Previous</a>
                    </li>
                </c:if>


                <%--                <c:choose>--%>
                <%--                    <c:when test="${requestScope.noOfPages < 5}">--%>
                <%--                        <c:forEach var="i" begin="${1}" end="${requestScope.noOfPages}">--%>
                <%--                            <c:when test="${i == requestScope.currentPage}">--%>
                <%--                                <li class="page-item active"><a class="page-link"--%>
                <%--                                                                href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                </li>--%>
                <%--                            </c:when>--%>
                <%--                            <c:otherwise>--%>
                <%--                                <li class="page-item"><a class="page-link"--%>
                <%--                                                         href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                </li>--%>
                <%--                            </c:otherwise>--%>
                <%--                        </c:forEach>--%>
                <%--                    </c:when>--%>
                <%--                    <c:otherwise>--%>
                <%--                        <c:choose>--%>
                <%--                            <c:when test="${requestScope.currentPage < 3}">--%>
                <%--                                <c:forEach var="i" begin="${1}" end="${5}">--%>
                <%--                                    <c:choose>--%>
                <%--                                        <c:when test="${i == requestScope.currentPage}">--%>
                <%--                                            <li class="page-item active"><a class="page-link"--%>
                <%--                                                                            href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                            </li>--%>
                <%--                                        </c:when>--%>
                <%--                                        <c:otherwise>--%>
                <%--                                            <li class="page-item"><a class="page-link"--%>
                <%--                                                                     href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                            </li>--%>
                <%--                                        </c:otherwise>--%>
                <%--                                    </c:choose>--%>
                <%--                                </c:forEach>--%>
                <%--                            </c:when>--%>
                <%--                            <c:when test="${requestScope.currentPage >= requestScope.noOfPages - 1}">--%>
                <%--                                <c:forEach var="i" begin="${requestScope.noOfPages - 4}"--%>
                <%--                                           end="${requestScope.noOfPages}">--%>
                <%--                                    <c:choose>--%>
                <%--                                        <c:when test="${i == requestScope.currentPage}">--%>
                <%--                                            <li class="page-item active"><a class="page-link"--%>
                <%--                                                                            href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                            </li>--%>
                <%--                                        </c:when>--%>
                <%--                                        <c:otherwise>--%>
                <%--                                            <li class="page-item"><a class="page-link"--%>
                <%--                                                                     href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                            </li>--%>
                <%--                                        </c:otherwise>--%>
                <%--                                    </c:choose>--%>
                <%--                                </c:forEach>--%>
                <%--                            </c:when>--%>
                <%--                            <c:otherwise>--%>
                <%--                                <c:forEach var="i" begin="${requestScope.currentPage - 2}"--%>
                <%--                                           end="${requestScope.currentPage + 2}">--%>
                <%--                                    <c:choose>--%>
                <%--                                        <c:when test="${i == requestScope.currentPage}">--%>
                <%--                                            <li class="page-item active"><a class="page-link"--%>
                <%--                                                                            href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                            </li>--%>
                <%--                                        </c:when>--%>
                <%--                                        <c:otherwise>--%>
                <%--                                            <li class="page-item"><a class="page-link"--%>
                <%--                                                                     href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>--%>
                <%--                                            </li>--%>
                <%--                                        </c:otherwise>--%>
                <%--                                    </c:choose>--%>
                <%--                                </c:forEach>--%>
                <%--                            </c:otherwise>--%>
                <%--                        </c:choose>--%>
                <%--                    </c:otherwise>--%>
                <%--                </c:choose>--%>


                <c:choose>
                    <c:when test="${requestScope.currentPage < 3}">
                        <c:if test="${requestScope.noOfPages < 5}">
                            <c:set var="endLoop" value="${requestScope.noOfPages}"/>
                        </c:if>
                        <c:if test="${requestScope.noOfPages >=5}">
                            <c:set var="endLoop" value="5"/>
                        </c:if>

                        <c:forEach var="i" begin="${1}" end="${endLoop}">
                            <c:choose>
                                <c:when test="${i == requestScope.currentPage}">
                                    <li class="page-item active"><a class="page-link"
                                                                    href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link"
                                                             href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:when>
                    <c:when test="${requestScope.currentPage >= requestScope.noOfPages - 1}">
                        <c:set var="number" value="${requestScope.noOfPages - 4}"/>
                        <c:set var="numberAbs" value="${Math.abs(number)}"/>
                        <c:if test="${numberAbs <= 0}">
                            <c:set var="startLoop" value="1"/>
                        </c:if>
                        <c:if test="${numberAbs > 0}">
                            <c:set var="startLoop" value="${numberAbs}"/>
                        </c:if>
                        <c:forEach var="i" begin="${startLoop}" end="${requestScope.noOfPages}">
                            <c:choose>
                                <c:when test="${i == requestScope.currentPage}">
                                    <li class="page-item active"><a class="page-link"
                                                                    href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link"
                                                             href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="i" begin="${requestScope.currentPage - 2}"
                                   end="${requestScope.currentPage + 2}">
                            <c:choose>
                                <c:when test="${i == requestScope.currentPage}">
                                    <li class="page-item active"><a class="page-link"
                                                                    href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link"
                                                             href="/product?kw=${requestScope.kw}&page=${i}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">${i}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>


                <c:if test="${requestScope.currentPage < requestScope.noOfPages}">
                    <li class="page-item"><a class="page-link"
                                             href="/product?kw=${requestScope.kw}&page=${requestScope.currentPage+1}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">Next</a>
                    </li>
                    <li class="page-item"><a class="page-link"
                                             href="/product?kw=${requestScope.kw}&page=${requestScope.noOfPages}&idPhone=${requestScope.idPhone}&limit=${requestScope.limit}">Final</a>
                    </li>
                </c:if>
            </ul>
        </nav>

    </div>
</main>
<!--Main layout-->
<jsp:include page="/WEB-INF/layout/css_food.jsp"></jsp:include>
</body>
<script>
    function handleDelete(id, title) {
        document.getElementById("txtDeleteId").value = id;
        Swal.fire({
            title: 'Bạn có muốn xóa?',
            text: title,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes!'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("frmDelete").submit();
            }
        })

    }
</script>
</html>