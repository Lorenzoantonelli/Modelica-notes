function  update
  input Integer old; // il valore originale
  input Integer n; // il numero di bit
  output Integer new; // il nuovo valore

  algorithm // dentro le funzioni ci può essere solo algorithm
    if (old < (2^n - 1)) // se non sono arrivato a 2^n-1
    then
      new := old + 1; // incremento di 1
    else
      new := 0; // altrimenti torno a 0
    end if; 

end update;