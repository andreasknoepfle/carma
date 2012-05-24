package carmob.carma

class Direction {
    City from
    City to
    static constraints = {
    }
    @Override public String toString() {
        StringBuilder result = new StringBuilder();
        result.append("Von ");
        result.append(from);
        result.append(" nach ");
        result.append(to);
        return result.toString();
     }
}
