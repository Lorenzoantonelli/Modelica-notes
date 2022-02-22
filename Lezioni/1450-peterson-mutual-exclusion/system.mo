class System

Processes p;
MonitorReq1 m;
MonitorReq2 m2;

equation

connect(p.pc, m.pc);
connect(p.pc, m2.pc);

end System;