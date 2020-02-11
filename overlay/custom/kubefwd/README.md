# config


get stuff ready:

```sh
> git clone --branch 1.11.0 https://github.com/txn2/kubefwd.git kubefwd
> git clone https://github.com/adisbladis/vgo2nix.git vgo2nix
```

modify the `go.mod` in kubefwd with:

```
replace github.com/Azure/go-autorest/autorest => github.com/Azure/go-autorest/autorest master

replace github.com/Azure/go-autorest/autorest/adal => github.com/Azure/go-autorest/autorest/adal master

replace github.com/Azure/go-autorest/autorest/date => github.com/Azure/go-autorest/autorest/date master

replace github.com/Azure/go-autorest/autorest/mocks => github.com/Azure/go-autorest/autorest/mocks master

replace github.com/Azure/go-autorest/logger => github.com/Azure/go-autorest/logger master

replace github.com/Azure/go-autorest/tracing => github.com/Azure/go-autorest/tracing master
```

then run:

```sh
> go mod tidy
```

to resolve to something like:

```
replace github.com/Azure/go-autorest/autorest => github.com/Azure/go-autorest/autorest v0.9.3-0.20191028180845-3492b2aff503

replace github.com/Azure/go-autorest/autorest/adal => github.com/Azure/go-autorest/autorest/adal v0.8.1-0.20191028180845-3492b2aff503

replace github.com/Azure/go-autorest/autorest/date => github.com/Azure/go-autorest/autorest/date v0.2.1-0.20191028180845-3492b2aff503

replace github.com/Azure/go-autorest/autorest/mocks => github.com/Azure/go-autorest/autorest/mocks v0.3.1-0.20191028180845-3492b2aff503

replace github.com/Azure/go-autorest/logger => github.com/Azure/go-autorest/logger v0.1.1-0.20191028180845-3492b2aff503

replace github.com/Azure/go-autorest/tracing => github.com/Azure/go-autorest/tracing v0.5.1-0.20191028180845-3492b2aff503
```

debug this with:

```sh
> GO111MODULE=on go list -json -m all
```

check that modules are replaced

---

then run a modified version of `vgo2nix` which handles replacements:

```go

// ...

type goMod struct {
    Path    string
    Main    bool
    Version string
    Replace struct {
        Path    string
        Version string
    }
}

// ...

for _, mod := range mods {
    path := mod.Path
    if mod.Replace.Path != "" {
        path = mod.Replace.Path
    }

    rev := mod.Version
    if mod.Replace.Version != "" {
        rev = mod.Replace.Version
    }

    if commitShaRev.MatchString(rev) {
        rev = commitShaRev.FindAllStringSubmatch(rev, -1)[0][1]
    } else if commitRevV2.MatchString(rev) {
        rev = commitRevV2.FindAllStringSubmatch(rev, -1)[0][1]
    } else if commitRevV3.MatchString(rev) {
        rev = commitRevV3.FindAllStringSubmatch(rev, -1)[0][1]
    }
    fmt.Println(fmt.Sprintf("goPackagePath %s has rev %s", path, rev))
    entries = append(entries, &modEntry{
        importPath: path,
        rev:        rev,
    })
}
```

```sh
> go run *.go -dir ../kubefwd -outfile ../kubefwd/deps.nix
```

---
