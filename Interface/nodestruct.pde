ArrayList <Node> Nodesfromstring(String d,PVector _tp, PVector _ts, float _hsc) {                                                                   // NODE CREATION: Code, Atributes, Loc
  ArrayList <Node> temParents   = new ArrayList <Node>();
  ArrayList <Node> nodeList     = new ArrayList <Node>();
  Node current=null;
  Node parent =null;
  Node root=null;
  boolean right=false;
  String code="";
  String atrbs="";

  for (int i=0; i<d.length(); i++) {  
    if (Character.isLetter(d.charAt(i))) code=code+d.charAt(i);
    if (Character.isDigit(d.charAt(i))||d.charAt(i)=='|'||d.charAt(i)=='.') atrbs= atrbs+d.charAt(i);
    if (d.charAt(i)=='(') if (code!="") {        
      if (root==null) { 
        Node newNode = new Node(code, atrbs, "0",_tp,_ts,_hsc);   //String code="";   String atrbs="";      (String _code, String _atributes, String _loc)
        root = newNode;
        current=newNode;
        temParents.add(current);
        nodeList.add(current);
        code="";
        atrbs="";
      } else if (root!=null &&!right) { 
        Node newNode = new Node(code, atrbs, current.loc + '0',_tp,_ts,_hsc);  
        parent = current;
        current = current.childa;
        if (current==null) {
          current=newNode;
          temParents.add(current);
        }
        nodeList.add(current);
        code="";
        atrbs="";
      } else if (root!=null &&right) { 
        Node newNode = new Node(code, atrbs, current.loc + '1',_tp,_ts,_hsc);
        parent = current;
        current = current.childb;
        if (current==null) {
          current=newNode;
          temParents.add(current);
        }
        nodeList.add(current);
        right=false;
        code="";
        atrbs="";
      }
    }
    if (d.charAt(i)==',') {
      right=true;
      if (code!="") { 
        Node newNode = new Node(code, atrbs, current.loc + '0',_tp,_ts,_hsc);  
        parent = current;
        current = current.childa;
        if (current==null) {
          current=newNode;
          temParents.add(current);
        }
        nodeList.add(current);
        code="";
        atrbs="";
      }
      if (d.charAt(i-1)!='(') {        
        if (!temParents.isEmpty()) temParents.remove(temParents.size()-1);
        if (!temParents.isEmpty()) current = temParents.get(temParents.size()-1);
        if (!temParents.isEmpty()) temParents.remove(temParents.size()-1);
      } else if (!temParents.isEmpty()) {
        current= temParents.get(temParents.size()-1);
        temParents.remove(temParents.size()-1);
      }
    }
    if (d.charAt(i)==')')  if (d.charAt(i-1)!=')') {              
      if (code!="") {
        Node newNode = new Node(code, atrbs, current.loc + '1',_tp,_ts,_hsc);
        parent = current;
        current = current.childb;
        if (current==null) {
          current=newNode;
          temParents.add(current);
        }
        nodeList.add(current);
        right=false;
        code="";
        atrbs="";
      } else temParents.add(current);
    }
  }
  Collections.sort(nodeList);
  return (nodeList);
}