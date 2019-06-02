<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="com.esliceu.bbdd.DAO" %>
<%@ page import="com.esliceu.bbdd.House" %>
<%@ page import="com.esliceu.bbdd.HouseDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 25/05/19
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%!
    String nameCasa = "";
    DAO<House> daoCasa = new HouseDAO();
    House casa = null;
%>

<%
        nameCasa = request.getParameter("house-name");
    casa = new House(nameCasa);
    daoCasa.create(casa);
%>


<html>
<head>
    <title>Title</title>
</head>
<body>

<script>

    location.href = "llistatCasas.jsp";

</script>


</body>
</html>
