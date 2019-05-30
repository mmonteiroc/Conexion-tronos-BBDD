/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete PACKAGE_NAME
 * Proyecto got
 */
public class Character {
    //Atributes
    private Integer id = null;
    private String name = null;
    private House allegianceTo = null;


    // Constructor
    public Character() {
    }

    public Character(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    public Character(Integer id, String name, House allegianceTo) {
        this.id = id;
        this.name = name;
        this.allegianceTo = allegianceTo;
    }


    // Getters
    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public House getAllegianceTo() {
        return allegianceTo;
    }

    // Setters
    public void setId(Integer id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAllegianceTo(House allegianceTo) {
        this.allegianceTo = allegianceTo;
    }


}