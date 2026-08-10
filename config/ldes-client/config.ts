const config = {
  endpoints: [
    {
      name: "abb-public",
      LDES_BASE: process.env.ABB_LDES_BASE,
      FIRST_PAGE: process.env.ABB_LDES_FIRST_PAGE,
      STATUS_GRAPH: "http://mu.semte.ch/graphs/ldes/abb/public-status",
      TARGET_GRAPH: "http://mu.semte.ch/graphs/ldes/abb/public",
      BATCH_GRAPH: "http://mu.semte.ch/graphs/ldes/abb/public-batch",
    },
    {
      name: "freiburg-public",
      LDES_BASE: process.env.FREIBURG_LDES_BASE,
      FIRST_PAGE: process.env.FREIBURG_LDES_FIRST_PAGE,
      STATUS_GRAPH: "http://mu.semte.ch/graphs/ldes/freiburg/public-status",
      TARGET_GRAPH: "http://mu.semte.ch/graphs/ldes/freiburg/public",
      BATCH_GRAPH: "http://mu.semte.ch/graphs/ldes/freiburg/public-batch",
    },
    {
      name: "bamberg-public",
      LDES_BASE: process.env.BAMBERG_LDES_BASE,
      FIRST_PAGE: process.env.BAMBERG_LDES_FIRST_PAGE,
      STATUS_GRAPH: "http://mu.semte.ch/graphs/ldes/bamberg/public-status",
      TARGET_GRAPH: "http://mu.semte.ch/graphs/ldes/bamberg/public",
      BATCH_GRAPH: "http://mu.semte.ch/graphs/ldes/bamberg/public-batch",
    },
    // TODO: Uncomment when LDES is configured in docker-compose.yml
    // {
    //   name: "ghent-public",
    //   LDES_BASE: process.env.GHENT_LDES_BASE,
    //   FIRST_PAGE: process.env.GHENT_LDES_FIRST_PAGE,
    //   STATUS_GRAPH: "http://mu.semte.ch/graphs/ldes/ghent/public-status",
    //   TARGET_GRAPH: "http://mu.semte.ch/graphs/ldes/ghent/public",
    //   BATCH_GRAPH: "http://mu.semte.ch/graphs/ldes/ghent/public-batch",
    // },
  ],
};

export default config;
