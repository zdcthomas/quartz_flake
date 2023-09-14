{
  inputs = {};
  description = "Quartz static site";
  outputs = {...}: {
    templates.default = {
      path = ./builder;
      description = "Quartz static site generation flake";
    };
  };
}
