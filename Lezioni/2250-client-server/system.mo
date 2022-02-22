class System

Queue ciq;   /// client input queue
Queue siq;   /// server input queue

Client c;
Server s;

MonitorReq1 m;


equation

    // client, read queue
    connect(ciq.readsignal, c.readsignal);
    connect(ciq.outputdata, c.outputdata);
    connect(ciq.datavailable, c.datavailable);

    // client, write queue
    connect(siq.inputdata, c.inputdata);
    connect(siq.writesignal, c.writesignal);
    connect(siq.spaceavailable, c.spaceavailable);


    // server, read queue
    connect(siq.readsignal, s.readsignal);
    connect(siq.outputdata, s.outputdata);
    connect(siq.datavailable, s.datavailable);

    // server, write queue
    connect(ciq.inputdata, s.inputdata);
    connect(ciq.writesignal, s.writesignal);
    connect(ciq.spaceavailable, s.spaceavailable);

    // monito connections
    connect(siq.inputdata, m.inputdata);
    connect(siq.writesignal, m.writesignal);
    connect(ciq.readsignal, m.readsignal);
    connect(ciq.outputdata, m.outputdata);


end System;
