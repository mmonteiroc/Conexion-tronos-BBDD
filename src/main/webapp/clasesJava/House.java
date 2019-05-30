/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete PACKAGE_NAME
 * Proyecto got
 */
public class House {
    // Atributes
    private Integer id = null;
    private String name = null;

    // Constructors
    public House() {
    }

    public House(Integer id, String name) {
        this.id = id;
        this.name = name;
    }


    // Getters
    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    // Setters
    public void setId(Integer id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

}
