block Server

   parameter Real T = 1;    // clock

   // to send outputs to client
   // client input queue (ciq)

   // writer
   OutputInteger inputdata;
   OutputBoolean writesignal;
   InputBoolean spaceavailable;

   // reader
   OutputBoolean readsignal;
   InputInteger outputdata;
   InputBoolean datavailable;  

   // un database che mi dice se una tupla è già stata vista oppure no 
   InputBoolean DB[K.N, K.M];   // DB for (pupil, photo) records

   Integer pc; // program counter
   Integer pupil; // studente che vuole inviare
   Integer value; // valore che il server deve inviare al client
   Integer photo; // id della foto

   algorithm

      when initial() then

         // setto tutto a false e il pc a 0

         pc := 0; 
         writesignal := false;
         readsignal := false;

         // define empty DB
         for i in 1:K.N loop
            for j in 1:K.M loop
                     DB[i,j] := false;
            end for;
         end for;

      elsewhen sample(0, T) then

         if (pc == 0) and pre(datavailable)  then
         // ask pupil id from client

            // invio il segnale di lettura alla fifo
            readsignal := not(pre(readsignal)) ;
            pc := 10;


         elseif (pc == 10)   then
         // read pupil id from client

            // leggo dalla fifo
            pupil := pre(outputdata);
            pc := 20;

            print("server: time = "+String(time)+"; 10pc="+String(pc)+"; pupil = "+String(pupil)+"\n");

         elseif (pc == 20) and pre(datavailable)  then
         // ask photo name to client

            // invio il segnale di lettura alla fifo
            readsignal := not(pre(readsignal)) ;
            pc := 30;


         elseif (pc == 30)   then
         // read photo name from client

            // leggo il nome della foto dalla fifo
            photo := pre(outputdata);
            pc := 40;

            print("server: time = "+String(time)+"; 30pc="+String(pc)+"; photo = "+String(photo)+"\n");


         elseif (pc == 40)   then
         // check if photo already stored

            print("server: time = "+String(time)+"; 40pc="+String(pc)+"; pupil = "+String(pupil)+"; photo = "+String(photo)+"\n");
            
            // se la foto è già stata ricevuta
            if DB[pupil,photo] then
            // tuple (pupil, photo) already in DB
               value := 0; // setto il valore a 0 e vado nello stato 80
               pc := 80;
            else // tuple fresh
               // inserisco la foto nel DB
               value := 1;
               DB[pupil,photo] := true;  // insert into DB
               pc := 50;
            end if;

            inputdata := value; // invio il valore alla fifo

         elseif (pc == 50) and pre(spaceavailable) then
         // send value 1 to client

            // invio il segnale di scrittura alla fifo
            writesignal := not(pre(writesignal));
            pc := 60;  

            print("server: time = "+String(time)+"; 50pc="+String(pc)+"; inputdata = "+String(inputdata)+"\n");
            
         elseif (pc == 60) and pre(datavailable) then
         // ask for  photo

            // invio il segnale di lettura alla fifo
            readsignal := not(pre(readsignal)) ;
            pc := 65;


         elseif (pc == 65)  then
         // get  photo

            // ottengo la foto
            value := pre(outputdata);
            pc := 0;  // loop

            print("server: time = "+String(time)+"; 65pc="+String(pc)+"; value = "+String(value)+"\n");
               
         elseif (pc == 80) and pre(spaceavailable)  then
         // send value 0 to client

            // invio il segnale di scrittura alla fifo (ho inviato uno 0, quindi un fail)
            writesignal := not(pre(writesignal)); 
            pc := 0;  // torno allo stato iniziale

            
         else  // busy waiting

            pc := pre(pc);

         end if;

      end when;


end Server;