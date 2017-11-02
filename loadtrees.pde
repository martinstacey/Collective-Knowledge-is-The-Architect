Table treet;

void setuptt() {
  treet=loadTable("trees.csv"); 
  hloc  = new String [treet.getRowCount()][][];
  for (int i=0; i<hloc.length; i++) hloc [i] = new String [catalanint(i)][];
  for (int i=0; i<hloc.length; i++) for (int j=0; j<hloc[i].length; j++) hloc [i][j] = split(treet.getString(i,j),'.');
    println(treet.getRowCount());
   //println(treet.getString(1, 0));
}