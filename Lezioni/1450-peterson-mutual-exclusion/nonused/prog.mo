


L0:      flag[0] = true;

L1:      turn = 1;   // P0_gate:

L2:      if (flag[1] == true && turn == 1) then goto L2 else goto L3;

L3:      // critical section loop

L4:      flag[0] = false;  // end of critical section

while (flag[1] == true && turn == 1)
         {
             // busy wait
         }

         // critical section
         ...
         // end of critical section

flag[0] = false;



if (pc == L0) then flag[0] := 1; pc = L1;

if (pc == L1) then turn := 1; pc := L2;

if (pc == L2) then if (flag[1] == true && turn == 1) then pc := L2 else pc := L3;

if (pc == L3) then pc := rand(L3, L4);  //  loop with random duration

if (pc == L4) then flag[0] := 0; pc == L5;

if (pc == L5) then (pc == L5);  // end



