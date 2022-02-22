function ServerProg
input Integer old_pc;         // pc of pupil
input Integer old_status;     // request (photo id)
input Integer req;            // true iff photo already present
input Boolean photopresent;   // true iff photo already present
output Integer new_pc;        // pc of pupil
output Integer new_status;    // request (photo id)


algorithm

new_pc := old_pc;
new_status := old_status;

if (old_pc == 0)  // idle state
then
       new_status := 0;
       
       if (not(req == 0))
       then // new request
            new_pc := 1;
       else  // no req
            new_pc := 0;   // busy waiting
       end if;

elseif (old_pc == 1)  // upload photo
then                                                                                          
       if (photopresent)
       then  // fail
             new_status := 2;
	     new_pc := 0; 
       else // OK, new photo
            new_status := 1;  // ok
	    new_pc := 0; 
       end if;


else  // old_pc  out of range
      new_pc := 0;   // idle
end if;

end ServerProg;

