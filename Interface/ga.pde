Population p;
Atribute [] at;
ArrayList <Node> gano;
int nPopX= 25;
int nPopY = 25;
int popSize = nPopX*nPopY;

void setupga() {
  int lc = leafcodes.length;
  int in = leafcodes.length-1;
  int tn = lc + in; 
  at = new Atribute [2+in+tn];          //tree num, room swap, node gene1, node gene 2
  at[0] = new Atribute ("Tree Number", 0, hloc[lc-1].length);
  at[1] = new Atribute ("roomswap", 0, factint(lc));
  for (int i=0; i<in; i++) at[i+2] = new Atribute ("inner:genes[0]", 0, 4);                      //genes[0] = 0-4
  for (int i=0; i<in; i++) at[i+2+in] = new Atribute ("inner:genes[1]", 0, 1);                      
  for (int i=0; i<lc; i++) at[i+2+in+in] = new Atribute ("leafs:genes[1]", 0, 8);  
  p = new Population(popSize);
}
float fitnessat(float [] att) {
  float f=0;
  int in = leafcodes.length-1;
  ArrayList <Node> n = setupnewnodes(hloc[leafcodes.length -1][int(att[0])], leafcodes, int(att[1]), treepos, treesize, housepos, housesize, housescale);
  for (Node ni : n) if (!ni.leaf) ni.genes[0].value= int(att[int(ni.innercount)+2]);
  for (Node ni : n) if (!ni.leaf) ni.genes[1].value= int(att[int(ni.innercount)+2+in]*100)/100.0;
  for (Node ni : n) if (ni.leaf)  ni.genes[1].value= int(att[int(ni.leafcount)+2+in+in]); 
  n=calchouse(n, housepos, housesize, housescale);
  f-=n.get(0).tfit;
  return f;
}
void draw1ga(int ind) {
  int lc = leafcodes.length;
  int in = leafcodes.length-1;
  float gasc = 100;
  PVector gapos = new PVector (400,100);
  ArrayList <Node> n = setupnewnodes(hloc[lc -1][int(p.pop[ind].phenos[0])], leafcodes, int(p.pop[ind].phenos[1]), treepos, treesize, gapos, housesize, gasc);
  for (Node ni : n) if (!ni.leaf) ni.genes[0].value= int(p.pop[ind].phenos[int(ni.innercount)+2]);
  for (Node ni : n) if (!ni.leaf) ni.genes[1].value= int(p.pop[ind].phenos[int(ni.innercount)+2+in]*100)/100.0;
  for (Node ni : n) if (ni.leaf)  ni.genes[1].value= int(p.pop[ind].phenos[int(ni.leafcount)+2+in+in]);
  n=calchouse(n, gapos, housesize, gasc);
  for (Node ni : n) ni.displayhouse();
  for (Node ni : n) ni.displaydoors();
  
}
void draw1ss(int ind) {
  int lc = leafcodes.length;
  int in = leafcodes.length-1;
  gano = setupnewnodes(hloc[lc -1][int(p.pop[ind].phenos[0])], leafcodes, int(p.pop[ind].phenos[1]), treepos, treesize, housepos, housesize, housescale);
  for (Node ni : gano) if (!ni.leaf) ni.genes[0].value= int(p.pop[ind].phenos[int(ni.innercount)+2]);
  for (Node ni : gano) if (!ni.leaf) ni.genes[1].value= int(p.pop[ind].phenos[int(ni.innercount)+2+in]*100)/100.0;
  for (Node ni : gano) if (ni.leaf)  ni.genes[1].value= int(p.pop[ind].phenos[int(ni.leafcount)+2+in+in]);
  gano=calchouse(gano, housepos, housesize, housescale);
  if (bState[0]) for (Node ni : gano) ni.display();
  if (bState[0]) for (Node ni : gano) ni.displayhouse();
  if (bState[0]) for (Node ni : gano) ni.displaydoors();
  if (bState[0]) for (Node ni : gano) ni.displaynames();
  if (bState[0]) for (Node ni : gano) ni.displayadj();




  //ssVal[0]=p.pop[ind].phenos[0];
  //ssVal[1]=p.pop[ind].phenos[1];
  //ssVal[2]=p.pop[ind].phenos[2];
}
void drawpop() {
  for (int i=0; i<p.pop.length; i++) {                                                       //Population Draw
    pushMatrix();
    scale(1.0/nPopX, 1.0/nPopY);
    translate(width*(i%nPopX), height*(i/nPopY));
    fill(255);
    rect(0, 0, width, height);
    draw1ga(i);
    popMatrix();
  }
}
void drawbestsga(int numstart) {
  for (int i=p.pop.length-numstart; i<p.pop.length; i++) {                                                       //Population Draw
    pushMatrix();
    scale(1.0/nPopX, 1.0/nPopY);
    translate(width*(i%nPopX), height*(i/nPopY));
    fill(255);
    rectMode(CORNER);
    rect(0, 0, width, height);
    draw1ga(i);
    popMatrix();
  }
}
void evolvega() {
  p.evolve();
}
class Atribute {
  String name;
  float min;
  float max;
  Atribute(String _name, float _min, float _max) {
    name=_name;
    min=_min;
    max=_max;
  }
}
class Population {
  Individual [] pop;
  int nPop;
  Population(int _nPop) {
    nPop = _nPop;
    pop = new Individual[nPop];
    for (int i=0; i<nPop; i++) {   
      pop[i] = new Individual(at);
      pop[i].evaluate();
    }
    Arrays.sort(pop);                                                                          //Arrays is a JAVA class identifier  //sort is one of its functions: it sorts a class of comparable elements
  }
  Individual select() {
    int which = (int)floor(((float)nPop-1e-6)*(1.0-sq(random(0, 1))));                          //skew distribution; multiplying by 99.999999 scales a number from 0-1 to 0-99, BUT NOT 100
    if (which == nPop) which = 0;
    return pop[which];                                                                         //the sqrt of a number between 0-1 has bigger possibilities of giving us a smaller number
  }                                                                                            //if we subtract that squares number from 1 the opposite is true-> we have bigger possibilities of having a larger number
  Individual sex(Individual a, Individual b) {
    Individual c = new Individual(at);
    for (int i=0; i<c.genes.length; i++) {
      if (random(0, 1)<0.5) c.genes[i] = a.genes[i];
      else c.genes[i] = b.genes[i];
    }
    c.mutate();
    c.inPhens();
    return c;
  }
  void evolve() {
    Individual a = select();
    Individual b = select();                                                                  //breed the two selected individuals    
    Individual x = sex(a, b);                                                                 //place the offspring in the lowest position in the population, thus replacing the previously weakest offspring    
    pop[0] = x;                                                                               //evaluate the new individual (grow)   
    x.evaluate();                                                                             //the fitter offspring will find its way in the population ranks   
    Arrays.sort(pop);
  }
  class Individual implements Comparable {                                                     //The Comparable Interface (JAVA) imposes a TOTAL ORDERING 
    float iFit;
    int [] genes;
    float [] phenos, phenosmin, phenosmax;
    Atribute[] a;
    Individual(Atribute [] _a) {
      a=_a;
      iFit = 0;
      genes  = new int [a.length];
      phenos = new float [genes.length];
      phenosmin = new float [phenos.length];
      phenosmax = new float [phenos.length];
      for (int i=0; i<phenosmin.length; i++) phenosmin [i] = a[i].min;
      for (int i=0; i<phenosmax.length; i++) phenosmax [i] = a[i].max;    
      for (int i=0; i<genes.length; i++) genes[i] = (int) random(256);
      for (int i=0; i<phenos.length; i++) phenos [i] = map(genes[i], 0, 256, phenosmin[i], phenosmax[i]);
    }
    void inGens() {
      genes = new int [a.length];
      for (int i=0; i<genes.length; i++) genes[i] = (int) random(256);
    }
    void inPhens() {
      for (int i=0; i<phenos.length; i++) phenos [i] = map(genes[i], 0, 256, phenosmin[i], phenosmax[i]);
    }
    void mutate() {                                                                               //5% mutation rate
      for (int i=0; i<genes.length; i++) if (random(100)<5)  genes[i] = (int) random(256);
    }
    void evaluate() {
      iFit = fitnessat(phenos);
    }
    int compareTo (Object objI) {                                                                 //method of the Comparable Interface
      Individual iToCompare = (Individual) objI;
      if (iFit<iToCompare.iFit) return -  1;                                                        //if i am less fit than iToCompare return -1
      else if (iFit>iToCompare.iFit)  return 1;                                                   //if i am fitter than iToCompare return 1
      return 0;                                                                                   //if we are equally fit return 0
    }
  }
}