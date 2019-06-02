<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="com.esliceu.bbdd.DAO" %>
<%@ page import="com.esliceu.bbdd.House" %>
<%@ page import="com.esliceu.bbdd.HouseDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 28/05/19
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    DAO<House> dao = new HouseDAO();
    Integer casaModificarId = null;
    String nombreCasaNew = null;
    House casaModificar = null;
%>


<%
    casaModificarId = Integer.parseInt(request.getParameter("casaModificar"));
    nombreCasaNew = request.getParameter("newNameHouse");
    casaModificar = new House(casaModificarId, nombreCasaNew);
    dao.update(casaModificar);
%>
<html>
<head>
    <title>Titulo</title>
</head>
<body>


<script>
    location.href = "llistatCasas.jsp";
</script>

</body>
</html>
