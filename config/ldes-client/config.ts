const config = {
  endpoints: [
    {
      name: "public",
      LDES_BASE: "https://ds.decide-dev.s.redhost.be/ldes/public/",
      FIRST_PAGE: "https://ds.decide-dev.s.redhost.be/ldes/public/1",
      STATUS_GRAPH: "http://mu.semte.ch/graphs/ldes/decide-public-status",
      TARGET_GRAPH: "http://mu.semte.ch/graphs/ldes/decide-public",
      BATCH_GRAPH: "http://mu.semte.ch/graphs/ldes/decide-public-batch",
    },
    // TODO: Configure other endpoints when available
  ],
};

export default config;
