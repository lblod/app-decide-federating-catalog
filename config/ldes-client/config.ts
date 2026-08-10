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
    // TODO: Configure other endpoints when available
    // See `config/authorization/config.lisp` for the intended target graphs per
    // partner.
    {
      name: "freiburg-public",
      LDES_BASE: process.env.FREIBURG_LDES_BASE,
      FIRST_PAGE: process.env.FREIBURG_LDES_FIRST_PAGE,
      STATUS_GRAPH: "http://mu.semte.ch/graphs/ldes/freiburg/public-status",
      TARGET_GRAPH: "http://mu.semte.ch/graphs/ldes/freiburg/public",
      BATCH_GRAPH: "http://mu.semte.ch/graphs/ldes/freiburg/public-batch",
    },
  ],
};

export default config;
