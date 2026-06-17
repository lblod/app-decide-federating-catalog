const config = {
  endpoints: [
    {
      name: "decide-public",
      LDES_BASE: process.env.DECIDE_LDES_BASE,
      FIRST_PAGE: process.env.DECIDE_LDES_FIRST_PAGE,
      STATUS_GRAPH: "http://mu.semte.ch/graphs/ldes/decide-public-status",
      TARGET_GRAPH: "http://mu.semte.ch/graphs/ldes/decide-public",
      BATCH_GRAPH: "http://mu.semte.ch/graphs/ldes/decide-public-batch",
    },
    // TODO: Configure other endpoints when available
  ],
};

export default config;
