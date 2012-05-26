package carmob.carma

class City {
    String name
    
    static constraints = {
    }
    
    @Override public String toString() {
        StringBuilder result = new StringBuilder();

        result.append(name);

        return result.toString();
    }
}
