# Dotfiles

Dotfiles é um compilado de funções a serem utilizadas com terminal bash

## Instalação

```bash
  rm -rf /tmp/dotfiles \
  && mkdir -p /tmp/dotfiles \
  && curl -L --output /tmp/dotfiles/dotfiles.tar.gz $(curl -s https://api.github.com/repos/realfabecker/dotfiles/releases/latest | grep tarball_url | cut -d '"' -f 4) \  
  && tar -xvf dotfiles.tar.gz -C /tmp/dotfiles --strip-components=1 \
  && bash ./tmp/dotfiles/ansible/install
```
## Change log

Verifique o [CHANGELOG](CHANGELOG.md) para informações sobre alterações recentes.

## Contribuições

Refira-se ao guia de [contribuições](./docs/CONTRIBUTING.md) para detalhes de como contribuir para o projeto.

## Versionamento

O projeto utilizada [SemVer](https://semver.org/) para o versionamento. Para todas as versões disponíveis verifique as
[tags nesse repositório][project-link].

## Licença

Este projeto considera a licença MIT. Verifique a [Licença](LICENSE.md) para mais informações.

[project-link]: https://github.com/realfabecker/bashy.git
