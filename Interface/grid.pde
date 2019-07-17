ArrayList <Grid> hg;
Table tb;
ArrayList <Table> tables;
String [] flname = {"control","google","mexico", "ny"};
PVector [] dcolor = {new PVector(150, 150, 250),new PVector(165, 220, 110),new PVector(250, 200, 125),new PVector(175, 125, 255)};
void setupta(){
  tables = new ArrayList <Table> ();
  for (int i=0; i<flname.length; i++) tables.add(loadTable(flname[i]+".csv","header"));
}
void setuphg() { 
  hg = new ArrayList <Grid> ();
  tb = tables.get(ButtonSl[0]);
  PVector inpos = new PVector (150, 230);
  String name[] ={"Short Side Dim.", "Long Side Dim.", "Area", "Proportion", "Total Area", "Adjacencies", "Connectivity"};                                                   ////[0]: ss [1]: ls [2]: ar [3]: pr [4]: to [5]: dx [6] dy [7] posx [8] posy [9]: adj [10]: con
  for (int i=0; i<5; i++) hg.add(new Grid(name[i], new PVector (inpos.x+(i*270), inpos.y), 250/2, tb, i,dcolor[ButtonSl[0]]));
  for (int i=5; i<7; i++) hg.add(new Grid(name[i], new PVector (inpos.x+(i*270), inpos.y), 250/2, tb, i+4,dcolor[ButtonSl[0]]));
}
void drawhg() {
  drawbackgrid();
  pushStyle();
  for (Grid h : hg) h.display();
  //hg.get(0).displayhouse();
  popStyle();
}
class Grid {
  String tittle;
  float size;
  PVector center;
  PVector [] rgpos;
  ArrayList <HouseG> ho;
  Table table;
  Table medtable;
  HouseG median;
  int num;
  PVector datacolor;
  Grid(String _tittle, PVector _center, float _size, Table _table, int _num, PVector _datacolor) {
    tittle = _tittle;
    size=_size;
    center =  _center;
    table = _table;
    num=_num;
    datacolor=_datacolor;
    rgpos = polygon(center, rprop.length, size);
    ho = new ArrayList <HouseG>();
    for (int i=0; i<table.getRowCount(); i++) ho.add(new HouseG(table.getRow(i), center, rgpos, num,datacolor));
    medtable = table;
    String a = "";
    for (int i=0; i<table.getColumnCount(); i++) for (int j=0; j<table.getRowCount(); j++) a =table.getString(j, i);
    for (int i=0; i<table.getColumnCount(); i++) {
      float sum=0;
      float count=0;
      for (int j=0; j<table.getRowCount(); j++) {
        if (float(table.getString(j, i))>0) {
          sum=float(table.getString(j, i))+sum;         //sino 
          count++;
        }
      }
      medtable.setString(0, i, sum/count+"");
    }
    median = new HouseG(medtable.getRow(0), center, rgpos, num,datacolor);
  }
  void display() {
    stroke(200);
    strokeWeight(1); 
    fill(100);
    textSize(12);
    textAlign(CORNER);
    text(tittle, center.x-size, center.y-size-10);
    textSize(9);
    textAlign(CENTER); 
    for (int i=0; i<rprop.length; i++) line(rgpos[i].x, rgpos[i].y, center.x, center.y);    
    for (int i=0; i<rprop.length; i++) text(rprop[i][1], rgpos[i].x, rgpos[i].y);
    for (HouseG h : ho) h.display();
    
    median.displaym();
  }
  void displayhouse (){
    textSize(12);
    fill(100);
    textAlign(CORNER);
    //text("Sample Houses from Database",30,390);
    for (int i=0; i<ho.size();i++) ho.get(i).displayhouse(3, new PVector (30+(width-80)/ho.size()*i, 400));
  }
}
class HouseG {
  TableRow house;
  ArrayList <RoomG> rm;
  char [] qc = {'s', 'l', 'a', 'p', 't', 'd', 'w', 'x', 'y', 'j', 'c'};     //[0]: ss [1]: ls [2]: ar [3]: pr [4]: to [5]: dx [6] dy [7] posx [8] posy [9]: adj [10]: con
  ArrayList<String[]> qs;
  String [] ba = new String [qc.length];
  PVector center;
  PVector []rgpos;
  PVector col;
  int num;
  HouseG(TableRow _house, PVector _center, PVector[] _rgpos, int _num,PVector _col) {
    house=_house;
    center = _center;
    rgpos = _rgpos;
    num=_num;
    col=_col;
    rm = new ArrayList<RoomG> ();
    qs = new ArrayList<String[]>();
    for (int i=0; i<rprop.length; i++) qs.add(new String [qc.length]);     
    for (int j=0; j<house.getColumnCount(); j++) for (int m=0; m<qc.length; m++) if (house.getColumnTitle(j).charAt(0)==qc[m]) qs.get(j%rprop.length)[m] = house.getString(j) ;    
    for (int i=0; i<rprop.length; i++) rm.add(new RoomG(rprop[i][0], qs.get(i), center, rgpos[i], rgpos));
  }
  void display() {
    fill(col.x, col.y, col.z, 70);
    stroke(col.x, col.y, col.z, 70);
    strokeWeight(1);
    if (num<9) {
      for (int i=0; i<rm.size(); i++) if (rm.get(i).qualitiesf[num]!=0)                 ellipse(rm.get(i).qualitiesp[num].x, rm.get(i).qualitiesp[num].y, 5, 5);
      for (int i=0; i<rm.size()-1; i++)if (rm.get(i).qualitiesf[num]!=0)  line(rm.get(i).qualitiesp[num].x, rm.get(i).qualitiesp[num].y, rm.get(i+1).qualitiesp[num].x, rm.get(i+1).qualitiesp[num].y);
    } else {
      strokeWeight(2);
      stroke(col.x, col.y, col.z, 2);
      for (int i=0; i<rm.size(); i++) ellipse(rm.get(i).posname.x, rm.get(i).posname.y, 5, 5);
      if (num==9) for (int i=0; i<rm.size(); i++) for (int j=0; j<rm.get(i).adjpos.size(); j++) line(rm.get(i).adjpos.get(j).x, rm.get(i).adjpos.get(j).y, rm.get(i).posname.x, rm.get(i).posname.y);
      if (num==10)for (int i=0; i<rm.size(); i++) for (int j=0; j<rm.get(i).conpos.size(); j++) line(rm.get(i).conpos.get(j).x, rm.get(i).conpos.get(j).y, rm.get(i).posname.x, rm.get(i).posname.y);
    }
  }
  void displaym() {
    fill(col.x-70, col.y-70, col.z-70);        //175, 100, 0    //255, 150, 5 
    stroke(col.x-70, col.y-70, col.z-70);
    strokeWeight(3); 
    if (num<9) {
      for (int i=0; i<rm.size(); i++)                  ellipse(rm.get(i).qualitiesp[num].x, rm.get(i).qualitiesp[num].y, 5, 5);
      for (int i=0; i<rm.size(); i++) line(rm.get(i).qualitiesp[num].x, rm.get(i).qualitiesp[num].y, rm.get((i+1)%rm.size()).qualitiesp[num].x, rm.get((i+1)%rm.size()).qualitiesp[num].y);
    }
  }
  void displayhouse(float sc, PVector pos) {
    strokeWeight(1);
    stroke(200);
    for (int i=0; i<rm.size(); i++) {
      rectMode(CORNER);
      fill(255);
      rect(rm.get(i).roompos.x*sc+pos.x, rm.get(i).roompos.y*sc+pos.y, rm.get(i).roomsize.x*sc, rm.get(i).roomsize.y*sc);
      textSize(sc);
      textAlign(CENTER,CENTER);
      fill(200);
     if ( rm.get(i).roomcenter.x!=0 )text(rm.get(i).code, rm.get(i).roomcenter.x*sc+pos.x, rm.get(i).roomcenter.y*sc+pos.y);
   }
  }
  class RoomG {
    String code;
    String [] qualities;
    float [] qualitiesf;
    PVector[] qualitiesp;
    String []  adj, con;
    ArrayList <PVector> adjpos = new ArrayList<PVector>  ();
    ArrayList <PVector> conpos = new ArrayList<PVector>  ();
    float [] qualmax  = {11, 11, 50, 1, .5, 20, 20, 20, 20, 0, 0};  //[0]: ss [1]: ls [2]: ar [3]: pr [4]: to [5]: dx [6] dy [7] posx [8] posy [9]: adj [10]: con
    PVector center;
    PVector posname;
    PVector [] rgpos;
    PVector roomsize, roompos, roomcenter;
    RoomG(String _code, String[] _qualities, PVector _center, PVector _posname, PVector [] _rgpos) {
      code=_code;
      qualities=_qualities;
      center = _center;
      posname=_posname;
      qualitiesf = new float [qualities.length];
      qualitiesp = new PVector [qualities.length];
      rgpos = _rgpos;
      for (int i=0; i<qualities.length; i++) {
        if (i<9) {
          if (float(qualities[i])>0)qualitiesf[i] = float(qualities[i]);
          else qualitiesf[i] =0;
        } else {
          if (i==9) adj = split (qualities[i], ',');
          if (i==10) con = split (qualities[i], ',');
        }
      }
      for (int j=0; j<adj.length; j++) for (int h=0; h<rprop.length; h++) if (adj[j].equals(rprop[h][0])) adjpos.add(rgpos[h]);
      
      for (int j=0; j<con.length; j++) for (int h=0; h<rprop.length; h++) if (con[j].equals(rprop[h][0])) conpos.add(rgpos[h]);
      for (int i=0; i< qualitiesp.length-2; i++) {
        qualitiesp[i] = PVector.sub(posname, center);
        float maxmag = qualitiesp[i].mag();
        qualitiesp[i].setMag(maxmag*(qualitiesf[i]/qualmax[i]));
        qualitiesp[i] = PVector.add(qualitiesp[i], center);
      }
      roompos = new PVector (qualitiesf[7], qualitiesf[8]);                 //[5]: dx [6] dy [7] posx [8] posy
      roomsize = new PVector (qualitiesf[5], qualitiesf[6]);
      roomcenter= new PVector (qualitiesf[7]+(qualitiesf[5]/2.0), qualitiesf[8]+(qualitiesf[6]/2.0));
    }
  }
}
PVector [] polygon (PVector pos, int nsides, float radius) {
  PVector [] p = new PVector [nsides+1];
  for (int i = 0; i < p.length; i ++)  p [i] =new PVector( pos.x + cos(i*PI*2/nsides) * radius, pos.y + sin(i*PI*2/nsides) * radius); 
  return p;
}