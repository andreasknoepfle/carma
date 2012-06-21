
package carmob.carma


class Dir {
    private String from;
    private String to;
    private Direction dir;
    
    public Dir(String f, String t, Direction d){
        from = f;
        to = t;
        dir = d;
    }
    
    public String getfrom(){
        return from;
    }
    
    public String getto(){
        return to;
    }
    
    public Direction getdir(){
        return dir;
    }
}