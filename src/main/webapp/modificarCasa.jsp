<%@ page import="com.esliceu.bbdd.DAO" %>
<%@ page import="com.esliceu.bbdd.House" %>
<%@ page import="com.esliceu.bbdd.HouseDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 29/05/19
  Time: 9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    Integer idCasa = null;
    DAO<House> dao = new HouseDAO();
    House casa = null;
%>

<%
    idCasa = Integer.parseInt(request.getParameter("modificar"));
    casa = dao.findById(idCasa);
%>


<html>
<head>
    <title>Modificar <%=casa.getName()%>
    </title>
</head>
<body>

<form action="saveCasa.jsp">
    <input type="text" name="newNameHouse" value="<%=casa.getName()%>">
    <button name="casaModificar" value="<%=idCasa%>">Guardar datos</button>
</form>


</body>
</html>