package carmob.carma

class Direction {
    City from
    City to
    
    static constraints = {
    }
    
    @Override public String toString() {
        StringBuilder result = new StringBuilder()
        result.append("Von ")
        result.append(from)
        result.append(" nach ")
        result.append(to)
        return result.toString()
     }
     
     @Override public String toEmString() {
        StringBuilder result = new StringBuilder()
        result.append("Von <b>")
        result.append(from)
        result.append("</b> nach <b>")
        result.append(to)
        result.append("</b>")
        return result.toString()
     }
     
     @Override public String toItString() {
        StringBuilder result = new StringBuilder()
        result.append("Von <i>")
        result.append(from)
        result.append("</i> nach <i>")
        result.append(to)
        result.append("</i>")
        return result.toString()
     }
}
