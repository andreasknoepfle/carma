package carmob.carma

/**
* Modelliert eine Stadt (eg Wolfsburg oder Berlin)
*/
class City {
    /**
    * Name der Stadt
    */
    String name
    
    static constraints = {
    }
    /**
    * Darstellung des Objektes (Name der Stadt wird ausgegeben)
    */
    @Override public String toString() {
        StringBuilder result = new StringBuilder();

        result.append(name);

        return result.toString();
    }
}
