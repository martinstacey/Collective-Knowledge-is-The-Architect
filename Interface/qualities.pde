//QualitiesList qu;
//PVector t3pos=new PVector (30, 35*10);
//void setupql() {
//  qu = new QualitiesList (no, t3pos);
//}
//void drawql() {
//  qu.display();
//}
//void pressql() {
//  qu.select();
//}
//void typeql() {
//  qu.type();
//}
//class QualitiesList {
//  PVector inpos;
//  PVector size  = new PVector (40, 20);
//  ArrayList <Node> ntx= new ArrayList<Node>();
//  ArrayList <Node> leafs=new ArrayList<Node>();
//  ArrayList <textrect> code, name;
//  ArrayList <Textedit>   iq1, iq2, iq3, iq4, iq5,iq6;
//  ArrayList <Textedit>   iw1, iw2, iw3, iw4, iw5,iw6;
//  IntList  a = new IntList ();
//  QualitiesList( ArrayList <Node> _ntx, PVector _pos) {
//    ntx = _ntx;
//    if (ntx.size()>0) for (int i=0; i<ntx.size(); i++) if (ntx.get(i).leaf) if (!ntx.get(i).code.equals("Zz")) leafs.add(ntx.get(i));
//    if (ntx.size()>0) for (int i=0; i<ntx.size(); i++) if (ntx.get(i).leaf) if (!ntx.get(i).code.equals("Zz")) a.append(i);
//    inpos=_pos;
//    code = new ArrayList  <textrect> ();
//    name = new ArrayList  <textrect> ();
//    iq1  = new ArrayList  <Textedit> ();
//    iq2  = new ArrayList  <Textedit> ();
//    iq3  = new ArrayList  <Textedit> ();
//    iq4  = new ArrayList  <Textedit> ();
//    iq5  = new ArrayList  <Textedit> ();
//    iw1  = new ArrayList  <Textedit> ();
//    iw2  = new ArrayList  <Textedit> ();
//    iw3  = new ArrayList  <Textedit> ();
//    iw4  = new ArrayList  <Textedit> ();
//    iw5  = new ArrayList  <Textedit> (); 

//    if (leafs.size()>0)  for (int i=0; i<leafs.size(); i++) if (leafs.get(i).iqual!=null) if (leafs.get(i).iqual.length!=0) {
//      code.add(new textrect(new PVector(inpos.x, inpos.y+size.y*i), size, leafs.get(i).code, i));
//      name.add(new textrect(new PVector(inpos.x+size.x, inpos.y+size.y*i), new PVector(size.x*4, size.y), leafs.get(i).name, i));               //PVector _pos, PVector _size, String _intext, String _tittle
//      iq1.add(new Textedit(new PVector (inpos.x+size.x*5, inpos.y+size.y*i), size, nf(float(leafs.get(i).iqual[2]), 0, 0), "", 10));
//      iq2.add(new Textedit(new PVector (inpos.x+size.x*6, inpos.y+size.y*i), size, nf(float(leafs.get(i).iqual[3]), 0, 0), "", 10));
//      iq3.add(new Textedit(new PVector (inpos.x+size.x*7, inpos.y+size.y*i), size, nf(float(leafs.get(i).iqual[4]), 0, 0), "", 10));
//      iq4.add(new Textedit(new PVector (inpos.x+size.x*8, inpos.y+size.y*i), size, nf(float(leafs.get(i).iqual[5]), 0, 0), "", 10));
      
//      String adjacents = "";
//      for (int j=0; j<leafs.get(i).iadj.length-1; j++)  adjacents = adjacents + leafs.get(i).iadj[j] + ",";
//      adjacents = adjacents + leafs.get(i).iadj[leafs.get(i).iadj.length-1];
//      iq5.add(new Textedit(new PVector (inpos.x+size.x*9, inpos.y+size.y*i), new PVector(size.x*4, size.y), adjacents, "", 10));

//      iw1.add(new Textedit(new PVector (inpos.x+size.x*11, inpos.y+size.y*i), size, nf(leafs.get(i).qualitiesweight.get(0)*100, 0, 0)+"%", "", 10));
//      iw2.add(new Textedit(new PVector (inpos.x+size.x*12, inpos.y+size.y*i), size, nf(leafs.get(i).qualitiesweight.get(1)*100, 0, 0)+"%", "", 10));
//      iw3.add(new Textedit(new PVector (inpos.x+size.x*13, inpos.y+size.y*i), size, nf(leafs.get(i).qualitiesweight.get(2)*100, 0, 0)+"%", "", 10));
//      iw4.add(new Textedit(new PVector (inpos.x+size.x*14, inpos.y+size.y*i), size, nf(leafs.get(i).qualitiesweight.get(3)*100, 0, 0)+"%", "", 10));
//      String adjacentsw = "";
//      for (int j=0; j<leafs.get(i).idealadjw.size()-1; j++)  adjacentsw = adjacentsw + leafs.get(i).idealadjw.get(j) + ",";
//      adjacentsw = adjacentsw + leafs.get(i).idealadjw.get(leafs.get(i).idealadjw.size()-1);
//      iw5.add(new Textedit(new PVector (inpos.x+size.x*15, inpos.y+size.y*i), new PVector(size.x*4, size.y), adjacentsw, "", 10));
 
//  }
//  }
//  void display() {   
//    textSize(13);
//    textAlign(CORNER, CENTER);
//    fill(100);
//    if (leafs.size()>0)  text("Ideal Qualities", inpos.x, inpos.y-10);
//    if (leafs.size()>0)  text("min", inpos.x+size.x*5, inpos.y-10);
//    if (leafs.size()>0)  text("max", inpos.x+size.x*6, inpos.y-10);
//    if (leafs.size()>0)  text("area", inpos.x+size.x*7, inpos.y-10);
//    if (leafs.size()>0)  text("prop", inpos.x+size.x*8, inpos.y-10);
//    if (leafs.size()>0)  text("adj", inpos.x+size.x*9, inpos.y-10);
//    if (leafs.size()>0)  text("Importance/Persistence", inpos.x+size.x*11, inpos.y-10);
    

//    if (leafs.size()>0)  for (int i=0; i<leafs.size(); i++) {
//      code.get(i).display();
//      name.get(i).display();
//      iq1.get(i).display();
//      iq2.get(i).display();
//      iq3.get(i).display();
//      iq4.get(i).display();
//      iq5.get(i).display();
//      iw1.get(i).display();
//      iw2.get(i).display();
//      iw3.get(i).display();
//      iw4.get(i).display();
//      iw5.get(i).display();
//    }
//    rectMode(CORNER);
//  }
//  void select() {
//    if (leafs.size()>0)  for (int i=0; i<leafs.size(); i++) if (leafs.get(i).idealqualities!=null) if (leafs.get(i).idealqualities.size()!=0) {
//      if (iq1.get(i).isover()) if (iq1.get(i).select) thenlist.get(a.get(i)).idealqualities.set(0, float(iq1.get(i).text));
//      if (iq2.get(i).isover()) if (iq2.get(i).select) thenlist.get(a.get(i)).idealqualities.set(1, float(iq2.get(i).text));
//      if (iq3.get(i).isover()) if (iq3.get(i).select) thenlist.get(a.get(i)).idealqualities.set(2, float(iq3.get(i).text));
//      if (iq4.get(i).isover()) if (iq4.get(i).select) thenlist.get(a.get(i)).idealqualities.set(3, float(iq4.get(i).text));
//      if (iq1.get(i).isover()) iq1.get(i).select = !iq1.get(i).select;
//      if (iq2.get(i).isover()) iq2.get(i).select = !iq2.get(i).select;
//      if (iq3.get(i).isover()) iq3.get(i).select = !iq3.get(i).select;
//      if (iq4.get(i).isover()) iq4.get(i).select = !iq4.get(i).select;
//      if (iq5.get(i).isover()) iq5.get(i).select = !iq5.get(i).select;    

//      if (iw1.get(i).isover()) if (iw1.get(i).select) thenlist.get(a.get(i)).idealqualities.set(0, float(iw1.get(i).text));
//      if (iw2.get(i).isover()) if (iw2.get(i).select) thenlist.get(a.get(i)).idealqualities.set(1, float(iw2.get(i).text));
//      if (iw3.get(i).isover()) if (iw3.get(i).select) thenlist.get(a.get(i)).idealqualities.set(2, float(iw3.get(i).text));
//      if (iw4.get(i).isover()) if (iw4.get(i).select) thenlist.get(a.get(i)).idealqualities.set(3, float(iw4.get(i).text));
//      if (iw1.get(i).isover()) iw1.get(i).select = !iw1.get(i).select;
//      if (iw2.get(i).isover()) iw2.get(i).select = !iw2.get(i).select;
//      if (iw3.get(i).isover()) iw3.get(i).select = !iw3.get(i).select;
//      if (iw4.get(i).isover()) iw4.get(i).select = !iw4.get(i).select;
//      if (iw5.get(i).isover()) iw5.get(i).select = !iw5.get(i).select;
//    }
//  }
//  void type() {
//    for (int i=0; i<iq1.size(); i++)  iq1.get(i).type();
//    for (int i=0; i<iq2.size(); i++)  iq2.get(i).type();
//    for (int i=0; i<iq3.size(); i++)  iq3.get(i).type();
//    for (int i=0; i<iq4.size(); i++)  iq4.get(i).type();
//    for (int i=0; i<iq5.size(); i++)  iq5.get(i).type();    
//    for (int i=0; i<iq1.size(); i++)  iw1.get(i).type();
//    for (int i=0; i<iq2.size(); i++)  iw2.get(i).type();
//    for (int i=0; i<iq3.size(); i++)  iw3.get(i).type();
//    for (int i=0; i<iq4.size(); i++)  iw4.get(i).type();
//    for (int i=0; i<iq5.size(); i++)  iw5.get(i).type();
//  }
//}