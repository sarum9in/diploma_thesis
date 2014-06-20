input cfg/uml;

beginfig(1)
    Component.repository("Repository")();
    Component.cache("Cache")();
    Component.pm("Package manager")(cache);
    Component.clientCode("Client code")();
    Component.client("Client")(pm, clientCode);

    topToBottom(30)(repository, client);

    leftToRight(30)(pm, clientCode);

    drawObjects(repository, client);

    link(providedInterface)(repository.s -- 0.5[repository.s, pm.n]);
    link(requiredInterface)(pm.n -- 0.5[repository.s, pm.n]);

    link(providedInterface)(pm.e -- 0.5[pm.e, clientCode.w]);
    link(requiredInterface)(clientCode.w -- 0.5[pm.e, clientCode.w]);
endfig;

end.
