input cfg/uml;

beginfig(1)
    Class.repository("repository")(
        "-m_config: config",
        "-m_local_system: local_system",
        "-m_cache: cache",
        "-m_distributor: distributor",
        "-m_builder: builder",
        "-m_extractor: extractor"
    )(
        "+extract(package: string, destination: path): void",
        "+install(package: string, destination: path): void",
        "+update(package: string, destination: path): void",
        "+update(package: string, destination: path, lifetime: time_t): void",
        "+need_update(package: string, destination: path, lifetime: time_t): bool",
        "+clean_cache(): void"
    );

    Class.local_system("local_system")()(
        "+resolver(): const utility::resolver &",
        "+tempdir_for_build(): tempfile",
        "+small_tempfile(): tempfile"
    );
    Class.cache("cache")(
        "+lock(): lock_guard",
        "+verify_and_repair(): void",
        "+clean(): void",
        "+read_index(package: string): index",
        "+read_checksum(package: string): snapshot_entry",
        "+read_build_snapshot(package: string): snapshot",
        "+read_installation_snapshot(package: string): snapshot",
        "+unpack_source(package: string, source_id: string, destination: path): void",
        "+unpack_build(package: string, source_id: string, destination: path): void",
        "+unpack_installation(package: string, source_id: string, destination: path): void",
        "+pack_build(package: string, path): void",
        "+pack_installation(package: string, path): void",
        "+build_outdated(package: string, snapshot): bool",
        "+installation_outdated(package: string, snapshot): bool",
        "+checksum_path(package: string): path",
        "+index_path(package: string): path",
        "+source_path(package: string, source_id: string): path",
        "+build_archive_path(package: string): path",
        "+build_snapshot_path(package: string): path",
        "+installation_archive_path(package: string): path",
        "+installation_snapshot_path(package: string): path"
    )();
    Class.distributor("distributor")(
        "+format(): const format_config &",
        "+archiver(): utility::archiver &",
        "+create(source: path, strip: bool): void",
        "+create_recursively(path root, strip: bool): void",
        "+update_meta(package: string): void",
        "+update_sources(package: string): void"
    )();
    Class.builder("builder")(
        "+build_empty(package: string): void",
        "+build(package: string): void",
        "+build_installation(package: string): void"
    )();
    Class.extractor("extractor")(
        "+extract(package: string, destination: path): void",
        "+install(package: string, destination: path): void",
        "+update(package: string, destination: path): void",
        "+need_update(destination: path, lifetime: time_t): bool",
        "+extract_source(package: string, source_id: string, destination: path): void",
        "+extract_build(package: string, source_id: string, destination: path): void",
        "+extract_installation(package: string, source_id: string, destination: path): void"
    )();

    Group.first(local_system, extractor);
    Group.lmid(distributor, builder);
    Group.mid(lmid, repository);
    Group.last(cache);

    topToBottom(50)(first, mid, last);
    topToBottom(30)(distributor, builder);
    leftToRight(30)(lmid, repository);
    leftToRight(30)(local_system, extractor);

    drawObjects(first, mid, last);

    link(composition)(local_system.s -- repository.nw);
    link(composition)(cache.n -- repository.s + (-90, 0));
    link(composition)(distributor.e -- repository.w + (0, 20));
    link(composition)(builder.e -- repository.w + (0, -40));
    link(composition)(extractor.s -- repository.n);
endfig;

end.
