package com.esliceu.bbdd;

/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete com.esliceu.bbdd
 * Proyecto got
 */
public class Character extends Entity {

    private Integer id = null;
    private String name = null;
    private House allegianceTo = null;


    // Constructor


    public Character(String name, House allegianceTo) {
        this.name = name;
        this.allegianceTo = allegianceTo;
    }

    public Character(String name) {
        this.name = name;
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
    public String getName() {
        return this.name;
    }

    public Integer getId() {
        return this.id;
    }

    public House getAllegianceTo() {
        return this.allegianceTo;
    }
}
