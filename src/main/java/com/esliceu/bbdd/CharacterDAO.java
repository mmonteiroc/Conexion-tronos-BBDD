package com.esliceu.bbdd;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;

/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete com.esliceu.bbdd
 * Proyecto got
 */
public class CharacterDAO implements DAO<Character> {


    Statement statement = null;
    ResultSet resultSet = null;
    Connection connection = null;
    // Pool
    final BasicDataSource pool = new BasicDataSource();
    // BBDD -- Variables
    private final String HOST_BBDD = "jdbc:mysql://localhost:3306";
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "gotAdmin";
    private final String PASSWORD_BBDD = "adminGot";


    public CharacterDAO() {
        try {

            Class.forName("com.mysql.jdbc.Driver").newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // Conexion
        pool.setDefaultCatalog(NAME_BBDD);
        pool.setUsername(USER_BBDD);
        pool.setPassword(PASSWORD_BBDD);
        pool.setUrl(HOST_BBDD);

        // Parametros
        pool.setMaxIdle(10);
        pool.setMinIdle(1);
        pool.setMaxTotal(5);
        pool.setValidationQuery("select 1");
        pool.setValidationQueryTimeout(1);
        pool.setDefaultQueryTimeout(15);
        pool.setMaxWaitMillis(2000);
    }

    @Override
    public LinkedList<Character> findAll() {
        LinkedList<Character> returnList = new LinkedList<>();
        try {
            establishConnection();

            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT characters.name as nombre,house.name as casa, characters.id as personajeId FROM characters LEFT JOIN house ON characters.allegianceTo=house.id order by characters.name");

            while (resultSet.next()) {
                returnList.addLast(new Character(resultSet.getInt("personajeID"), resultSet.getString("nombre"), new House(resultSet.getString("casa"))));
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
                if (resultSet != null) resultSet.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return returnList;
    }

    public Character findById(Integer id) {
        Character devolver = null;
        try {
            establishConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select name,id from characters where id=" + id);
            resultSet.next();
            devolver = new Character(resultSet.getInt("id"), resultSet.getString("name"));

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
                if (resultSet != null) resultSet.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return devolver;
    }


    @Override
    public void delete(Character entity) {
        try {
            establishConnection();
            statement = connection.createStatement();
            statement.executeUpdate("delete from characters where id=" + entity.getId());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void update(Character entity) {
        //update characters set name="", allegianceTo= where id=
        try {
            establishConnection();
            statement = connection.createStatement();
            statement.executeUpdate("update characters set name=\"" + entity.getName() + "\", allegianceTo=" + entity.getAllegianceTo().getId() + " where id=" + entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void create(Character entity) {
        try {
            establishConnection();
            statement = connection.createStatement();
            Integer alianza = (entity.getAllegianceTo() != null) ? entity.getAllegianceTo().getId() : null;
            statement.executeUpdate("insert into characters (name,allegianceTo) values (\"" + entity.getName() + "\"," + alianza + ")");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    public void establishConnection() throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
        connection = pool.getConnection();
    }
}
