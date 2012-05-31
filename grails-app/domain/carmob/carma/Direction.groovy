package carmob.carma

class Direction {
    City from
    City to
    
    static constraints = {
    }
    
    @Override public String toString() {
        StringBuilder result = new StringBuilder()
        result.append("Von <b>")
        result.append(from)
        result.append("</b> nach <b>")
        result.append(to)
        result.append("</b>")
        return result.toString()
     }
}
