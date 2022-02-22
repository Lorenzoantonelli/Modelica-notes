block Client

   // devo inviare al canale di comunicazione i comandi

   parameter Real T = 2;    // clock


   // client input queue (ciq)

   // reader
   OutputBoolean readsignal; // lo mando alla fifo su cui leggo
   InputInteger outputdata; // il valore che vado a leggere dalla fifo su cui leggo
   InputBoolean datavailable; // mi dice se ho spazio disponibile nella fifo su cui leggo


   // server input queue (siq)

   // writer
   OutputInteger inputdata; // lo mando alla fifo su cui scrivo
   OutputBoolean writesignal; // lo mando alla fifo su cui scrivo
   InputBoolean spaceavailable; // mi dice se ho spazio disponibile nella fifo su cui scrivo

   Integer pupil; // id dello studente che vuole inviare
   Integer value; // valore dal server
   Integer photo_name; // nome della foto

   Integer pc;   // pc (status) for each pupil, il program counter

   algorithm

      when initial() then

         // nello stato iniziale non devo inviare o leggere nulla

         writesignal := false;
         readsignal := false;
         pc := 0; // sono nello stato iniziale del mio programma
         value := 0; // non ho ricevuto nessun valore dal server
         pupil := 0; // non ho scelto lo studente

      elsewhen sample(0, T) then

         // entro nello stato iniziale con probabilità 1/2
         if ( (pc == 0) and (myrandom() <= 0.5) )  then
         // select pupil that tries to upload photo

            pupil := 1 + integer(myrandom()*K.N*0.999);   // pupil that acts
            inputdata := pupil; // mando sulla fifo l'id dello studente che vuole inviare
            pc := 10; 

            print("client: time = "+String(time)+"; 0pc="+String(pc)+"; inputdata = "+String(inputdata)+"\n"); // debug
            
         elseif ( (pc == 5)  )  then
         // se entro in questa fase vuol dire che il nome della foto è stato scartato e scelgo un nuovo nome per la foto, qui rimando al server l'id dello studente che vuole inviare

            pupil := pre(pupil);  // pupil that acts
            inputdata := pupil;
            pc := 10; 

            print("client: time = "+String(time)+"; 5pc="+String(pc)+"; inputdata = "+String(inputdata)+"\n"); // debug

         elseif (pc == 10) and pre(spaceavailable)  then
         // aggiorno il segnale di scrittura sulla fifo

            writesignal := not(pre(writesignal));
            pc := 20;


         elseif (pc == 20)   then
         // scelgo un valore casuale come nome della foto

            photo_name := 1 + integer(myrandom()*K.M*0.999);
            inputdata := photo_name; // mando sulla fifo il nome della foto
            pc := 30;

            print("client: time = "+String(time)+"; 20pc="+String(pc)+"; inputdata = "+String(inputdata)+"\n"); // debug

         elseif (pc == 30) and pre(spaceavailable)  then
         // send photo name to server

            writesignal := not(pre(writesignal)); // mando il segnale di scrittura sulla fifo
            pc := 40;

         elseif (pc == 40) and pre(datavailable)  then
         // leggo dal server se il nome della foto va bene (new) o non va bene (old). In questa prima fase invio il segnale di lettura sulla fifo

            readsignal := not(pre(readsignal)) ;
            pc := 50;


         elseif (pc == 50)   then
         // leggo il dato dalla fifo

            value := pre(outputdata);

            print("client: time = "+String(time)+"; 50pc="+String(pc)+"; value = "+String(value)+"\n"); // debug

         if (value == 1) then
         // name is new, you may upload photo
               pc := 60;
         else // name already present
            if (myrandom() <= 0.5) then
            // pick new photo name and try again
               pc := 5;
            else // give up
               pc := 0;
            end if;  
         end if;

         elseif (pc == 60) and pre(spaceavailable)  then
         // upload photo

            writesignal := not(pre(writesignal));
            pc := 0;  // loop

            print("client: time = "+String(time)+"; 60pc="+String(pc)+"; value = "+String(value)+"\n");

         else  // busy waiting

            pc := pre(pc);

         end if;


      end when;


end Client;