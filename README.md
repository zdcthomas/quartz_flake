# Quartz flake

The purpose of this flake system is to make it easier to build a static site
with the Quartz Static Site generator. This way, builds can be reproducible
against either the master version of Quartz, or against a public fork you
maintain yourself. This means that your content can be completely seperate from
your quartz implementation, which means your content repo can be private, while
your fork of Quartz is public.

```

      ┌────────────────┐ EITHER ┌────────────────┐
      │jackyzha0/quartz│───OR───│your_fork/quartz│
      └────────────────┘   │    └────────────────┘
                           │
                   ┌───────┘
                   │
                   │
                   │ ┌─────────────────┐
                   │ │ Content Repo    │
                   │ │                 │
                   └─┼──►Flake.nix─────┼──►./public─►Deployment
                     │    ▲            │
                     │    └───./content│
                     └─────────────────┘
```

## Important

Right now, it's not super easy to use this to serve your site locally. But I
have plans to add that.
