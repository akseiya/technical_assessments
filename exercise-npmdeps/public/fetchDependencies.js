const currentlyFetching = [];

const fetchRootDependencies = () => {
    demandedRoot = $('#rootPackageInput').val()
    $('h3#rootPackageName').html(demandedRoot);
    clearRootPackageDependencies();
    fetchDependencies(demandedRoot, demandedRoot, 'latest', $('ul#rootPackageDependencies'))
};

const clearRootPackageDependencies = () => {
    // remove any existing LIs from root UL
};

const fetchDependencies = (currentRoot, packageName, version, targetElement) => {
    $.get(`${npmRegistry}/${packageName}/${version}`).
    done(result => {
        if(currentRoot != demandedRoot) return;  // stop recursion when new package name is submitted
        if(result.dependencies)
            updatePackageItem(currentRoot, target, result.dependencies);
    }).
    fail({
        failPackageItem(target)
    });  
};

const updatePackageItem = (currentRoot, target, dependencies) => {
    for(packageName in dependencies) {
        if(currentRoot != demandedRoot) return;  // stop recursion when new package name is submitted
        const version = dependencies[packageName];
        const dependencyItemId = appendPackageListItem(
            packageName,
            version,
            target,
        );
        fetchDependencies(
            packageName,
            version,
            $(`#${dependencyItemId}`),
        );
    }
}

const appendPackageListItem = (name, ver, parent) => {
    /*
    Generate uniqueId
    Append a this to the parent element:
        <li>
            ${name} v. ${ver}
            <ul id="${uniqueId}"></ul>
        </li>
    */
return uniqueId;
};