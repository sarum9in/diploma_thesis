input cfg/uml;

beginfig(1)
    Component.External("External client")();
    Component.Bacs("Testing system")();
    Component.Dcs("Distributing system")();
    Component.Mine("Internal")(Bacs, Dcs);
    topToBottom(20)(External, Mine);
    leftToRight(10)(Bacs, Dcs);

    drawObjects(External, Mine);

    link(providedInterface)(Bacs.n -- 0.7[Bacs.n, External.s]);
    link(requiredInterface)(External.s -- 0.7[Bacs.n, External.s]);
    link(providedInterface)(Dcs.n -- 0.7[Dcs.n, External.s]);
    link(requiredInterface)(External.s -- 0.7[Dcs.n, External.s]);
endfig;

end.
