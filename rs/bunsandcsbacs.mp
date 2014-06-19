input cfg/uml;

beginfig(1)
    Component.client("External client")();
    Component.manager("Manager")();
    Component.service("Worker")();

    Group.server(manager, service);

    leftToRight(30)(manager, service);
    topToBottom(40)(client, server);

    drawObjects(client, server);

    link(providedInterface)(manager.e -- 0.5[manager.e, service.w]);
    link(requiredInterface)(service.w -- 0.5[manager.e, service.w]);

    link(providedInterface)(manager.n -- 0.5[manager.n, client.s]);
    link(requiredInterface)(client.s -- 0.5[manager.n, client.s]);

    link(providedInterface)(service.n -- 0.5[service.n, client.s]);
    link(requiredInterface)(client.s -- 0.5[service.n, client.s]);
endfig;

end.
