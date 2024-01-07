# DevOps

## Visão geral

- **Integração Contínua (Continuous Integration - CI)**
    - É uma prática que consiste em juntar o código de vários desenvolvedores, de uma mesma aplicação, com maior frequência. Com isso, a ação de _[merge](https://en.wikipedia.org/wiki/Merge_(version_control))_ ao _[branch](https://en.wikipedia.org/wiki/Branching_(version_control))_ principal doí menos, problemas são corrigidos mais rapidamente e o _[release](https://docs.github.com/en/repositories/releasing-projects-on-github/about-releases)_ de uma nova versão sai mais rápido.

- **Entrega Contínua (Continuous Delivery - CD)**
    - Preocupa-se em disponibilizar o software para ser _[implantado (software deployment)](https://en.wikipedia.org/wiki/Software_deployment)_ no ambiente de produção. Antes de disponibilizar o software, há tarefas importantes que validam a qualidade do código através da execução de testes, checagem de vulnerabilidades, para então ser gerado um _[artefato](https://en.wikipedia.org/wiki/Artifact_(software_development))_ confiável que será disponibilizado para implantação.

- **Implantação Contínua (Continuous Deployment - CD)**
    - É a etapa que cuida de implantar o artefato gerado em seu respectivo ambiente (kubernetes, container instances, etc). A ideia é ter todo o processo de implantação automatizado sem nenhuma intervenção humana.