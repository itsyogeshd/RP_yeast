function [trset,tsset] = createFold(Nall) 
    
    prRand = randperm(Nall); 
     
    Ntr = round(Nall*0.8); 
 
    trset = prRand(1:Ntr)'; 
    tsset = prRand(Ntr+1:end)'; 
     
  end