String[] permutation(String [] pre, int num){
  String newA[] = perm(pre, 0,new ArrayList <String[]> (),num);
  return newA;
}
String[]  perm(String[] iA, int s, ArrayList <String[]> igm,int nume) {    
  for(int i = s; i < iA.length; i++){
        String temp = iA[s];
        iA[s] = iA[i];
        iA[i] = temp;
        perm(iA, s + 1,igm,nume);
        iA[i] = iA[s];
        iA[s] = temp;
    }
   if (s == iA.length - 1){
     String toadd= "";
     for (int i=0;i<iA.length-1; i++) toadd = toadd + iA[i] + ",";
     toadd = toadd + iA[iA.length-1];   
     igm.add(split(toadd,",")); 
   }
   String [] ig1 = null;
   if (igm.size()>nume)  ig1 = igm.get(nume);
   return ig1;
}