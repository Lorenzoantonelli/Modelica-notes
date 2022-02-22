# 1240-incremental-sw-dev

Con lo stesso approccio di 1200 posso modellare anche lo sviluppo software incrementale.

Immaginiamo lo sviluppo incrementale come composto da tante micro-delivery su cui vado ad iterare. Se io facessi una catena di Markov che modella questo, sarebbe molto difficile crearla.

Esiste quindi un trucco: utilizzare le variabili.

La catena che vedo in **mc.mo** rappresenta quindi le micro-delivery.

Imposto che dopo 8 micro-delivery il software è completo.

La variabile y parte come numero di micro-delivery e viene decrementata ogni volta che arrivo ad 8, quando arrivo a 0 il software è pronto e c'è una delivery.

Devo quindi modificare il monitor rispetto all'esempio precedente. L'output è sempre il tempo atteso. L'output lo ho quando ho completato la delivery, non la micro-delivery.