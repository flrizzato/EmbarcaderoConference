## Train

```bat
    .\train\Train.exe train.js
```

> build de testes - comentar `conditionalDefines`

> copy artifacts - renomear `DUnit` e `DUnitX`

## Gulp

### Pré-requisito

Instalar **gulp-cli** para poder rodar o **Gulp** e os pacotes utilizados no script

```powershell
   npm install -g gulp-cli
   npm install gulp gulp-zip run-sequence
```

### Execução

```powershell
   rem Basico
   gulp

   rem Compilação
   gulp compile

   rem Compilação Testes Unitários
   gulp compile-tests

   rem Executar Testes Unitários
   gulp unit-test

   rem Executar Code Coverage
   gulp code-coverage

   rem Watch
   gulp watch
```

## FinalBuilder

```powershell
   & 'C:\Program Files (x86)\FinalBuilder 8\fbcmd.exe' .\FinalBuilder.fbp8
```

## Jenkins

### Login
  
* adm / adm / Adm

### Plugins

* NUnit Plugin
* Emma plugin
* HTML Publisher plugin 

### Configurações

#### Básico

1. Source Code Management / Git / Repository URL: 

```
  file:///C:\Users\alefr\Documents\GitHub\delphi-ec2018-demo
```

2. Build Triggers / Pool SCM: 

```
  */1 * * * *
```

3. Build / Execute Windows batch Command: 

```
  "C:\program files (x86)\FinalBuilder 8\FBCMD.exe" "%WORKSPACE%\FinalBuilder.fbp8"
```

4. Post-Build Actions / Archive the Artifacts: 

```
  Artifacts/Build.zip
```

#### DUnit

1. Post-Build Actions / Publish NUnit report:

```
  Artifacts/dunit-report.xml
```

#### Code Coverage

1. Post-Build Actions / Record emma:

```
  Artifacts/Coverage/CodeCoverage_Summary.xml
```

2. Post-Build Actions / Record HTML Reports:

```
  HTML directory to archive: Bin/Coverage
  Index page[s]: CodeCoverage_summary.html
  Report title: Code Coverage Report
```