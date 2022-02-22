block Receiver


   parameter Real T = 1.0;

   InputBoolean datavailable;
   InputInteger data;
   OutputBoolean readsignal;

   Integer x;
   Integer state;

   algorithm

      when initial() then
         x := 0;
         state := 0;
         readsignal := false;
         
      elsewhen (sample(0,T) and (pre(datavailable) or not(state == 0))) then


         if (pre(state) == 0)
         then  // ask for data
            readsignal := true;
            state := 1;
         else // (state == 1)
                     // read data
         //         if (datavailable) then x := data; end if;
            x := pre(data);
            readsignal := false;
            state := 0;
         end if;


      end when;


end Receiver;