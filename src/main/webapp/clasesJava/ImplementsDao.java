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
 * Paquete PACKAGE_NAME
 * Proyecto got
 */
public class ImplementsDao {
    // BBDD -- Variables
    private final String HOST_BBDD = "jdbc:mysql://localhost:3306";
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "gotAdmin";
    private final String PASSWORD_BBDD = "adminGot";
    // Pool
    private BasicDataSource pool = null;

    public ImplementsDao() {
        pool = new BasicDataSource();
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


    // Functions
    public LinkedList<Character> getUsers() {
        LinkedList<Character> caracteres = new LinkedList<>();

        Connection conexion = null;
        Statement statement = null;
        ResultSet resultado = null;
        try {
            conexion = pool.getConnection();
            statement = conexion.createStatement();
            String query = "select * from characters";
            resultado = statement.executeQuery(query);
            while (resultado.next()) {
                caracteres.addLast(new Character(resultado.getInt("id"), resultado.getString("name")));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultado != null) resultado.close();
                if (statement != null) statement.close();
                if (conexion != null) conexion.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return caracteres;
    }
}
