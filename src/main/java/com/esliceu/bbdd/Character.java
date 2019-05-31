package com.esliceu.bbdd;

/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete com.esliceu.bbdd
 * Proyecto got
 */
public class Character extends Entity {

    Integer id = null;
    String name = null;
    House allegianceTo = null;


    // Constructor
    public Character(String name, House allegianceTo) {
        this.name = name;
        this.allegianceTo = allegianceTo;
    }

    public Character(Integer id, String name, House allegianceTo) {
        this.id = id;
        this.name = name;
        this.allegianceTo = allegianceTo;
    }


}
