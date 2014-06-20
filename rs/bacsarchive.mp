input cfg/uml;

beginfig(1)
    Component.client("Client")();
    Component.archive("Archive")();
    Component.repository("Repository")();
    Group.internal(archive, repository);

    leftToRight(40)(archive, repository);
    topToBottom(40)(client, internal);

    drawObjects(client, internal);

    link(providedInterface)(repository.w -- 0.5[repository.w, archive.e]);
    link(requiredInterface)(archive.e -- 0.5[repository.w, archive.e]);

    link(providedInterface)(archive.n -- 0.5[archive.n, client.s]);
    link(requiredInterface)(client.s -- 0.5[archive.n, client.s]);
endfig;

end.
