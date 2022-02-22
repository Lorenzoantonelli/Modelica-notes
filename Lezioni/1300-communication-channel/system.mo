class System

Sender s;
Channel c;
Receiver r;
MonitorReq1 req1;


equation


connect(s.x, c.inputdata);  // connect sender to channel
connect(s.writesignal, c.writesignal);  // connect sender to channel
connect(c.spaceavailable, s.spaceavailable);  // connect sender to channel

connect(r.readsignal, c.readsignal);  // connect reaceiver to channel
connect(c.outputdata, r.data);  // connect reaceiver to channel
connect(c.datavailable, r.datavailable);  // connect reaceiver to channel

// connect channel to monitor
connect(r.readsignal, req1.readsignal);  
connect(s.writesignal, req1.writesignal);  
connect(c.outputdata, req1.outputdata);  
connect(s.x, req1.inputdata);  
connect(c.datavailable, req1.datavailable);  
connect(c.spaceavailable, req1.spaceavailable);  

end System;
